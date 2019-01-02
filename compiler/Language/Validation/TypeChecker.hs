module Language.Validation.TypeChecker where

import Control.Monad.State
import Control.Monad.Except
import qualified Data.Map.Strict as Map

import qualified Language.Syntax.AST as AST
import Language.Common

data SemanticError
    = UndefinedVariable String Position
    | Redeclaration String Position
    | ArrayRange String Position
    -- TypeMismatch : Expected Type, Actual Type
    | TypeMismatch SymbolType SymbolType String Position
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
 
semanticError = throwError . show

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
validateUsage symTab cmds = loop cmds []  
    where
        loop :: AST.Commands -> [(String, SymbolRecord)] -> Either String ()
        loop [] _ = return ()
        loop (x:xs) local = do
            checkIdUsage x local
            loop xs local

        checkIdUsage x local = case x of
            AST.ASSIGN id expr -> checkAssign id expr local
            AST.IF cond cmds elseCmds -> checkIf cond elseCmds local
            AST.WHILE cond cmds -> checkWhile cond cmds local
            AST.DO_WHILE cond cmds -> checkDoWhile cond cmds local
            AST.FOR iter cmds -> checkFor iter cmds local
            AST.READ id -> checkId id local
            AST.WRITE val -> checkVal val local
        
        checkId (AST.Id id) local =
            case (fst id) `Map.lookup` symTab of
                Nothing -> Left . show $ uncurry UndefinedVariable id
                Just (SR pos (Scalar)) -> return ()
                _ -> Left . show $ uncurry (TypeMismatch Scalar (Array 0 0)) id

        checkAssign id expr local = return ()

        checkIf cond maybeElseCmds local = return ()

        checkWhile cond cmds local = return ()

        checkDoWhile cond cmds local = return ()

        checkFor iter cmds local = return ()

        checkVal val local = return ()
