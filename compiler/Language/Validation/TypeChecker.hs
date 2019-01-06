module Language.Validation.TypeChecker where

import Control.Monad.State
import Control.Monad.Except
import Data.List
import qualified Data.Map.Strict as Map

import qualified Language.Syntax.AST as AST
import Language.Common

data SemanticError
    = UndefinedVariable String Position
    | Redeclaration String Position
    | ArrayRange String Position
    -- TypeMismatch : Expected Type, Actual Type
    | TypeMismatch SymbolType SymbolType String Position
    | OutOfRange String Position
    | LocalIteratorMutation String Position
    deriving (Eq)

showPos (line, col) = "line " ++ show line ++ " column " ++ show col

instance Show SemanticError where
    show (UndefinedVariable id pos) = 
        "Error: Usage of undefined variable " ++ id 
            ++ " at " ++ showPos pos
    show (Redeclaration id pos) = 
        "Error: Redeclaration of variable " ++ id 
            ++ " at " ++ showPos pos
    show (ArrayRange id pos) = 
        "Error: Wrong range in declaration of array " ++ id 
            ++ " at " ++ showPos pos
    show (TypeMismatch expected actual id pos) =
        "Error: Type mismatch \n"
            ++ "  expected: " ++ symbolTypeName expected ++ "\n"
            ++ "  actual:   " ++ symbolTypeName actual ++ "\n"
            ++ "  at " ++ showPos pos
    show (OutOfRange id pos) =
        "Error: Index outside of range of the array " ++ id
            ++ " at " ++ showPos pos
    show (LocalIteratorMutation id pos) = 
        "Error: Mutation of local iterator " ++ id
            ++ " at " ++ showPos pos
 
semanticError = throwError . show

eitherShowError :: (String -> Position -> SemanticError) -> (String, Position) -> Either String a
eitherShowError err x = Left . show $ uncurry err x

data Program = Program SymbolTable AST.Commands
    deriving (Show, Eq)

validate :: AST.Program -> Either String Program
validate prog = do
    let (AST.Program decl commands) = prog
    symbolTable <- validateDeclarations decl
    validateUsage symbolTable commands
    return $ Program symbolTable commands

validateDeclarations :: [AST.Declaration] -> Either String SymbolTable
validateDeclarations decl = runExcept $ execStateT (loop decl) Map.empty
    where   
        loop :: [AST.Declaration] -> StateT SymbolTable (Except String) ()
        loop [] = return ()
        loop (x:xs) = do
            table <- get
            case x of
                AST.DeclVar id -> tryInsert table id $ Scalar
                AST.DeclArray id l r -> do
                    checkRange id l r
                    tryInsert table id $ Array l r
            loop xs
        
        tryInsert :: SymbolTable -> (String, Position) -> SymbolType -> StateT SymbolTable (Except String) ()
        tryInsert table id symType = do
            case (fst id) `Map.lookup` table of
                Nothing -> do
                    modify $ Map.insert (fst id) $ SR (snd id) symType
                Just _ -> semanticError $ uncurry Redeclaration $ id

        checkRange :: (String, Position) -> Integer -> Integer -> StateT SymbolTable (Except String) ()
        checkRange id l r 
            | l > r = semanticError $ uncurry ArrayRange $ id
            | otherwise = return ()

validateUsage :: SymbolTable -> AST.Commands -> Either String ()
validateUsage symTab cmds = checkCmds cmds []  
    where
        checkCmds :: AST.Commands -> [(String, SymbolRecord)] -> Either String ()
        checkCmds [] _ = return ()
        checkCmds (x:xs) local = do
            checkIdUsage x local
            checkCmds xs local

        checkIdUsage x local = case x of
            AST.ASSIGN id expr -> checkAssign id expr local
            AST.IF cond cmds elseCmds -> checkIf cond cmds elseCmds local
            AST.WHILE cond cmds -> checkWhile cond cmds local
            AST.DO_WHILE cond cmds -> checkDoWhile cond cmds local
            AST.FOR iter cmds -> checkFor iter cmds local
            AST.READ id -> checkRead id local
            AST.WRITE val -> checkVal val local
        
        findById id local = fmap snd $ find (\x -> fst x == fst id) local

        checkLocalIteratorMutation (AST.Id id) local =
            case id `findById` local of
                Just _ -> eitherShowError LocalIteratorMutation id
                Nothing -> return ()
        -- Local iterators can only be scalar        
        checkLocalIteratorMutation _ _ = return ()

        checkId (AST.Id id) local = do
            let mismatch = eitherShowError (TypeMismatch (Array 0 0) Scalar) id
            case id `findById` local of
                Just (SR _ Scalar) -> return ()
                Just _ -> mismatch
                Nothing -> case (fst id) `Map.lookup` symTab of
                    Nothing -> eitherShowError UndefinedVariable id
                    Just (SR _ (Scalar)) -> return ()
                    _ -> mismatch
        
        checkId (AST.ArrayId id arg) local = do
            let mismatch = eitherShowError (TypeMismatch Scalar (Array 0 0)) id
            let next = checkId (AST.Id arg) local
            case id `findById` local of
                -- Local ids can only be scalars
                Just _ -> mismatch
                Nothing -> case (fst id) `Map.lookup` symTab of
                    Nothing -> eitherShowError UndefinedVariable id
                    Just (SR _ (Array _ _)) -> next
                    _ -> mismatch

        checkId (AST.ArrayNum id num) local = do
            let mismatch = eitherShowError (TypeMismatch Scalar (Array 0 0)) id
            case id `findById` local of
                -- Local ids can only be scalars
                Just _ -> mismatch
                Nothing -> case (fst id) `Map.lookup` symTab of
                    Nothing -> eitherShowError UndefinedVariable id
                    Just (SR _ (Array l r)) -> checkRange l r
                    _ -> mismatch
            where   
                checkRange l r 
                    | l <= num && num <= r = return ()
                    | otherwise = eitherShowError OutOfRange id
 
        checkVal (AST.ValNum _) _ = return ()
        checkVal (AST.ValId id) local = checkId id local

        checkExpr (AST.ExVal val) local = checkVal val local
        checkExpr (AST.Op _ left right) local = do
            checkVal left local
            checkVal right local

        checkCond (AST.Comp _ left right) local = do
            checkVal left local
            checkVal right local

        checkAssign id expr local = do
            checkId id local
            checkExpr expr local
            checkLocalIteratorMutation id local
        
        checkWhile cond cmds local = do
            checkCond cond local
            checkCmds cmds local

        checkDoWhile cmds cond local = do
            checkCmds cmds local
            checkCond cond local

        checkIf cond cmds maybeElseCmds local = do
            checkCond cond local
            checkCmds cmds local
            case maybeElseCmds of
                Just elseCmds -> checkCmds cmds local
                Nothing -> return ()

        checkIter (AST.IterTo id left right) local = do
            checkVal left local
            checkVal right local
            return id

        checkIter (AST.IterDownTo id left right) local = do
            checkVal left local 
            checkVal right local
            return id

        checkFor iter cmds local = do
            id <- checkIter iter local
            let local' = (fst id, SR (snd id) Scalar) : local
            checkCmds cmds local'

        checkRead id local = do
            checkId id local
            checkLocalIteratorMutation id local
