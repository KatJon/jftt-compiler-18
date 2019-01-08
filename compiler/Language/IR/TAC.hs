module Language.IR.TAC where

import qualified Language.Syntax.AST as AST

type VarID = Integer

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
    show (MArrNum arr i) = "P[" ++ show arr ++ "[" ++ show i ++ "]]"
    show (MArrVar arr x) = "P[" ++ show arr ++ "[" ++ "P[" ++ show x ++ "]]"

data Expr
    = EVal Value
    | EAdd Value Value
    | ESub Value Value
    | EMul Value Value
    | EDiv Value Value
    | EMod Value Value
    deriving (Eq)

instance Show Expr where
    show (EVal v) = show v
    show (EAdd l r) = show l ++ " + " ++ show r
    show (ESub l r) = show l ++ " - " ++ show r
    show (EMul l r) = show l ++ " * " ++ show r
    show (EDiv l r) = show l ++ " / " ++ show r
    show (EMod l r) = show l ++ " % " ++ show r

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

negComp :: Comp -> Comp
negComp (CEq l r) = CNeq l r
negComp (CNeq l r) = CEq l r
negComp (CLt l r) = CGe l r
negComp (CLe l r) = CGt l r
negComp (CGt l r) = CLe l r
negComp (CGe l r) = CLt l r

type Label = String

data TAC
    = TComment Label
    | TLabel Label
    | TAssign Mem Expr
    | TRead Mem
    | TWrite Value
    | TIf Comp Label
    | TJump Label
    | TInc Mem
    | TDec Mem
    | TDecOrJumpZero Mem Label
    deriving (Eq)

instance Show TAC where
    show (TLabel s) = s ++ ":"
    show (TComment s) = "# " ++ s
    show (TAssign mem v) = show mem ++ " <- " ++ show v
    show (TRead mem) = "read " ++ show mem
    show (TWrite val) = "write " ++ show val
    show (TIf cmp label) = "if " ++ show cmp ++ " goto " ++ label
    show (TJump label) = "goto " ++ label
    show (TInc mem) = show mem ++ "++"
    show (TDec mem) = show mem ++ "--"
    show (TDecOrJumpZero mem label) = "if " ++ show mem ++ "-- = 0 goto " ++ label 
