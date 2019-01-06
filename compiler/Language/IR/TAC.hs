module Language.IR.TAC where

import qualified Language.Syntax.AST as AST

type VarID = Integer
type TempID = Integer

data Value
    = VNum Integer
    | VMem Mem
    deriving (Eq)

instance Show Value where
    show (VNum i) = show i
    show (VMem mem) = show mem
    
data Mem
    = MVar VarID
    | MArrNum VarID Integer
    | MArrVar VarID VarID
    deriving (Eq)

instance Show Mem where
    show (MVar x) = "P[" ++ show x ++ "]"
    show (MArrNum arr i) = "P[" ++ show arr ++ "[" ++ show i ++ "]"
    show (MArrVar arr x) = "P[" ++ show arr ++ "[" ++ "P[" ++ show x ++ "]" ++ "]"

data Expr
    = EAdd TempID TempID
    | ESub TempID TempID
    | EMul TempID TempID
    | EDiv TempID TempID
    | EMod TempID TempID
    deriving (Eq)

instance Show Expr where
    show (EAdd l r) = "t" ++ show l ++ " + " ++ "t" ++ show r
    show (ESub l r) = "t" ++ show l ++ " - " ++ "t" ++ show r
    show (EMul l r) = "t" ++ show l ++ " * " ++ "t" ++ show r
    show (EDiv l r) = "t" ++ show l ++ " / " ++ "t" ++ show r
    show (EMod l r) = "t" ++ show l ++ " % " ++ "t" ++ show r

data Comp
    = CEq Value Value
    | CNeq Value Value
    | CLt Value Value
    | CLe Value Value
    | CGt Value Value
    | CGe Value Value
    deriving (Eq)

instance Show Comp where
    show (CEq l r) = show l ++ " = " ++ show r
    show (CNeq l r) = show l ++ " != " ++ show r
    show (CLt l r) = show l ++ " < " ++ show r
    show (CLe l r) = show l ++ " <= " ++ show r
    show (CGt l r) = show l ++ " > " ++ show r
    show (CGe l r) = show l ++ " >= " ++ show r

type Label = String

data TAC
    = TComment Label
    | TLabel Label
    | TAssignTemp TempID Value
    | TAssignTempExpr TempID Expr
    | TAssignMem Mem TempID
    deriving (Eq)

instance Show TAC where
    show (TLabel s) = s ++ ":"
    show (TComment s) = "# " ++ s
    show (TAssignTemp t v) = "t" ++ show t ++ " <- " ++ show v
    show (TAssignTempExpr t e) =  "t" ++ show t ++ " <- " ++ show e
    show (TAssignMem mem t) = show mem ++ " <- " ++ show t

code = unlines . fmap show $ [
    TAssignTemp 1 (VNum 3),
    TAssignTemp 2 (VMem (MVar 0)),
    TAssignTempExpr 3 (EAdd 1 2)
    ]
