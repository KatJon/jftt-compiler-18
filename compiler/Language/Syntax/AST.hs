module Language.Syntax.AST where

import Language.Common

type PlainId = (String, (Int, Int))

data Identifier
    = Id PlainId
    | ArrayId PlainId PlainId
    | ArrayNum PlainId Integer
    deriving (Show, Eq)

data Value
    = ValId Identifier
    | ValNum Integer
    deriving (Show, Eq)

data Comparator = EQ | NEQ | LT | LEQ | GT | GEQ
    deriving (Show, Eq)

data Condition = Comp Comparator Value Value
    deriving (Show, Eq)

data Operator = ADD | SUB | MUL | DIV | MOD
    deriving (Show, Eq)

data Expression
    = ExVal Value
    | Op Operator Value Value
    
    deriving (Show, Eq)

data Iterator 
    = IterTo PlainId Value Value
    | IterDownTo PlainId Value Value
    deriving (Show, Eq)

data Command
    = ASSIGN Identifier Expression
    | IF Condition Commands (Maybe Commands)
    | WHILE Condition Commands
    | DO_WHILE Commands Condition
    | FOR Iterator Commands
    | READ Identifier
    | WRITE Value
    deriving (Show, Eq)

type Commands = [Command]

data Declaration 
    = DeclVar PlainId
    | DeclArray PlainId Integer Integer
    deriving (Show, Eq)

type Declarations = [Declaration]

data Program = Program {
    declarations :: Declarations,
    commands :: Commands
} deriving (Show, Eq)
