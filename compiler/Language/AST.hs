module Language.AST where

type PlainId = String

data Identifier
    = Id PlainId
    | ArrayId String String
    | ArrayNum String Integer
    deriving (Show, Eq)

data Value
    = ValId Identifier
    | ValNum Integer
    deriving (Show, Eq)

data Condition
    = EQ Value Value
    | NEQ Value Value
    | LT Value Value
    | LEQ Value Value
    | GT Value Value
    | GEQ Value Value
    deriving (Show, Eq)

data Expression
    = ExVal Value
    | ADD Value Value
    | SUB Value Value
    | MUL Value Value
    | DIV Value Value
    | MOD Value Value
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
