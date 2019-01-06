module Language.IR.SimpleTAC where

type VarID = Integer
type TempID = Integer

data Value
    = VNum Integer
    | VVar VarID
    | VArrNum VarID Integer
    | VArrVar VarID VarID

data LHS
    = LHS_Var VarID
    | LHS_ArrNum VarID Integer
    | LHS_ArrVar VarID VarID

data Operator = ADD | SUB | MUL | DIV | MOD
    deriving (Show, Eq)

data Expr = Expr Operator TempID TempID

data SimpleTAC
    = TAssignTemp TempID Value
    | TAssignTempExpr TempID Expr
    | TAssignLHS LHS TempID


