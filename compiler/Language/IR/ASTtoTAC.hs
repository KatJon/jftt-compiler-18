module Language.IR.ASTtoTAC where

import Language.IR.TAC
import Machine.MemoryModel
import Control.Monad
import Control.Monad.State

import qualified Language.Syntax.AST as AST

import Data.Map.Strict as Map

-- LabelId, TempId
type ConversionState = (Integer, Integer)

getLabel :: State ConversionState String
getLabel = do
    (lab, tmp) <- get
    put (lab + 1, tmp)
    return $ "label" ++ show lab

getTemp :: State ConversionState Integer
getTemp = do
    (lab, tmp) <- get
    put (lab, tmp + 1)
    return tmp

getTAC :: Memory -> AST.Commands -> [TAC]
getTAC mem cmds = evalState (getSTAC mem cmds) (0, 0)

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
        exprSTAC expr = do
            ret <- getTemp
            case expr of
                AST.ExVal (AST.ValNum i) -> do
                    return (ret, [TAssignTemp ret (VNum i)])

                AST.ExVal (AST.ValId (AST.Id (id, _))) -> do
                    let (Var _ var) = varmap mem ! id
                    return (ret, [TAssignTemp ret (VMem (MVar var))])

                AST.ExVal (AST.ValId (AST.ArrayNum (arrid, _) i)) -> do
                    let (Array _ arr _ _) = varmap mem ! arrid
                    return (ret, [TAssignTemp ret (VMem (MArrNum arr i))])

                AST.ExVal (AST.ValId (AST.ArrayId (arrid, _) (varid, _))) -> do
                    let (Array _ arr _ _) = varmap mem ! arrid
                    let (Var _ var) = varmap mem ! varid
                    return (ret, [TAssignTemp ret (VMem (MArrVar arr var))])
                    
                _ -> return (ret, [])

        assignSTAC id expr = do
            (temp, cmds) <- exprSTAC expr
            return $ [TComment "Assign"] ++ cmds 

        ifSTAC cond cmds elseCmds = return [TComment "If"]

        whileSTAC cond cmds = return [TComment "While"]

        doWhileSTAC cmds cond = return [TComment "Do While"]

        forSTAC it cmds = return [TComment "For"]

        readSTAC id = return [TComment "Read"]

        writeSTAC val = return [TComment "Write"]
