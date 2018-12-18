module Language.Token where

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
    | ID String
    
    -- Other
    | SEMI -- ;
    | COLON -- :
    | LPAR -- (
    | RPAR -- )

    -- Technical tokens
    | WS__ -- whitespace
    | EOF__ -- EOF
    deriving (Show, Eq)

type Position = (Int, Int)

data TokenInfo = TI Token Position
    deriving (Show, Eq)

numberToken :: String -> Int -> Token
numberToken s len = VAL . read $ take len s

idToken :: String -> Int -> Token
idToken s len = ID $ take len s
