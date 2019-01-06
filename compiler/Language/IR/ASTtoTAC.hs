module Language.IR.ASTtoTAC where

import Language.IR.TAC
import Machine.MemoryModel
import Control.Monad
import Control.Monad.State

import qualified Language.Syntax.AST as AST

import Data.Map.Strict as Map

type ConversionState = Integer

getLabel :: State ConversionState String
getLabel = do
    lab <- get
    put $ lab + 1
    return $ "label" ++ show lab

getTAC :: Memory -> AST.Commands -> [TAC]
getTAC mem cmds = evalState (getSTAC mem cmds) 0

getSTAC :: Memory -> AST.Commands -> State ConversionState [TAC]
getSTAC mem cmds = fmap join . sequence $ fmap (commandSTAC mem) cmds

commandSTAC :: Memory -> AST.Command -> State ConversionState [TAC]
commandSTAC mem cmd = case cmd of
    AST.ASSIGN id expr -> assignSTAC id expr
    AST.IF cond cmds elseCmds -> ifSTAC cond cmds elseCmds
    AST.WHILE cond cmds -> whileSTAC cond cmds
    AST.DO_WHILE cmds cond -> doWhileSTAC cmds cond
    AST.FOR it cmds -> forSTAC it cmds 
    AST.READ id -> readSTAC id
    AST.WRITE val -> writeSTAC val
    where
        getLHS (AST.Id (id, _)) = do
            let var = case varmap mem ! id of
                    Var _ v -> v
                    Iterator _ v _ -> v
            return $ MVar var

        getLHS (AST.ArrayNum (arrid, _) i) = do
            let (Array _ arr _ _) = varmap mem ! arrid
            return $ MArrNum arr i

        getLHS (AST.ArrayId (arrid, _) (varid, _)) = do
            let (Array _ arr _ _) = varmap mem ! arrid
            let var = case varmap mem ! varid of
                    Var _ v -> v
                    Iterator _ v _ -> v
            return $ MArrVar arr var

        -- TODO LHS

        getValue (AST.ValNum i) = return $ VNum i

        getValue (AST.ValId (AST.Id (id, _))) = do
            let var = case varmap mem ! id of
                    Var _ v -> v
                    Iterator _ v _-> v
            return $ VMem (MVar var)

        getValue (AST.ValId (AST.ArrayNum (arrid, _) i)) = do
            let (Array _ arr _ _) = varmap mem ! arrid
            return $ VMem (MArrNum arr i)

        getValue (AST.ValId (AST.ArrayId (arrid, _) (varid, _))) = do
            let (Array _ arr _ _) = varmap mem ! arrid
            let var = case varmap mem ! varid of
                    Var _ v -> v
                    Iterator _ v _ -> v
            return $ VMem (MArrVar arr var)

        getIterator memory itid = do
            let (Iterator _ it range) = varmap memory ! itid
            return $ (it, range)

        getRHS (AST.ExVal v) = do
            val <- getValue v
            return $ EVal val

        getRHS (AST.Op op l r) = do
            lv <- getValue l
            rv <- getValue r
            return $ getOp op lv rv

        getOp AST.ADD = EAdd
        getOp AST.SUB = ESub
        getOp AST.MUL = EMul
        getOp AST.DIV = EDiv
        getOp AST.MOD = EMod

        assignSTAC id expr = do
            lhs <- getLHS id
            rhs <- getRHS expr
            return [TAssign lhs rhs]

        getComparator AST.EQ = CEq
        getComparator AST.NEQ = CNeq
        getComparator AST.LT = CLt
        getComparator AST.LEQ = CLe
        getComparator AST.GT = CGt
        getComparator AST.GEQ = CGe

        getComp (AST.Comp comp l r) = do
            lv <- getValue l
            rv <- getValue r
            return $ getComparator comp lv rv
            
        ifSTAC cond cmds maybeElseCmds = do
            cmp <- getComp cond
            case maybeElseCmds of
                Nothing -> do
                    endLabel <- getLabel
                    opsThen <- getSTAC mem cmds
                    return $ 
                        [TIf (negComp cmp) endLabel] 
                        ++ opsThen 
                        ++ [TLabel endLabel]

                Just elseCmds -> do
                    elseLabel <- getLabel
                    endLabel <- getLabel
                    opsThen <- getSTAC mem cmds
                    opsElse <- getSTAC mem elseCmds
                    return $ 
                        [TIf (negComp cmp) elseLabel]
                        ++ opsThen
                        ++ [TJump endLabel, TLabel elseLabel]
                        ++ opsElse
                        ++ [TLabel endLabel]

        whileSTAC cond cmds = do
            startLabel <- getLabel
            cmp <- getComp cond
            ops <- getSTAC mem cmds
            endLabel <- getLabel
            return $ 
                [TLabel startLabel]
                ++ [TIf (negComp cmp) endLabel]
                ++ ops
                ++ [TJump startLabel]
                ++ [TLabel endLabel]

        doWhileSTAC cmds cond = do
            startLabel <- getLabel
            ops <- getSTAC mem cmds
            cmp <- getComp cond
            return $
                [TLabel startLabel]
                ++ ops
                ++ [TIf cmp startLabel]

        forSTAC iter cmds = case iter of
            AST.IterTo (id,_) from to -> do
                let mem' = withIterator mem id
                (it, end) <- getIterator mem' id
                fromv <- getValue from
                tov <- getValue to
                startLabel <- getLabel
                ops <- getSTAC mem' cmds
                endLabel <- getLabel

                return $ [
                    TAssign (MVar it) $ EVal fromv,
                    TAssign (MVar end) $ EVal tov,
                    TLabel startLabel,
                    TIf (CGt (VMem (MVar it)) (VMem (MVar end))) endLabel
                    ]
                    ++ ops
                    ++ [
                    TJump startLabel,
                    TLabel endLabel
                    ]

            AST.IterDownTo (id,_) from downto -> do
                let mem' = withIterator mem id
                (it, end) <- getIterator mem' id
                fromv <- getValue from
                downtov <- getValue downto
                startLabel <- getLabel
                ops <- getSTAC mem' cmds
                endLabel <- getLabel

                return $ [
                    TAssign (MVar it) $ EVal fromv,
                    TAssign (MVar end) $ EVal downtov,
                    TLabel startLabel,
                    TIf (CLt (VMem (MVar it)) (VMem (MVar end))) endLabel
                    ]
                    ++ ops
                    ++ [
                    TJump startLabel,
                    TLabel endLabel
                    ]
                

        readSTAC id = do
            mem <- getLHS id
            return [TRead mem]

        writeSTAC val = do
            v <- getValue val
            return [TWrite v]
