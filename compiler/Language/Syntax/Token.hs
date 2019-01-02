module Language.Syntax.Token where

import Language.Common

data Token
    -- Keywords
    = DECLARE | IN | END
    | IF | THEN | ELSE | ENDIF 
    | WHILE | ENDWHILE
    | DO | ENDDO
    | FOR | FROM | TO | DOWNTO | ENDFOR
    | READ
    | WRITE

    -- Operators
    | ASSIGN -- :=
    | ADD -- +
    | SUB -- -
    | MUL -- *
    | DIV -- /
    | MOD -- %
    | EQ -- =
    | NEQ -- !=
    | LT -- <
    | LEQ -- <=
    | GT -- >
    | GEQ -- >= 

    -- Values and ids
    | VAL Integer
    | ID (String, Position)
    
    -- Other
    | SEMI -- ;
    | COLON -- :
    | LPAR -- (
    | RPAR -- )

    -- Technical tokens
    | ID__ String
    | WS__ -- whitespace
    | EOF__ -- EOF
    deriving (Show, Eq)

data TokenInfo = TI Token Position
    deriving (Show, Eq)

numberToken :: String -> Int -> Token
numberToken s len = VAL . read $ take len s

idToken :: String -> Int -> Token
idToken s len = ID__ $ take len s
