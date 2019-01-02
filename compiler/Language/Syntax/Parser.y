{
module Language.Syntax.Parser (parser) where

import Control.Monad.Except

import qualified Language.Syntax.Token as T
import qualified Language.Syntax.Lexer as L
import qualified Language.Syntax.AST as AST

}

%name program
%monad { Except String } { (>>=) } { return }
%error { parseError }

%tokentype { T.TokenInfo }

%token
    -- Keywords
    DECLARE { T.TI T.DECLARE _ }
    IN { T.TI T.IN _ }
    END { T.TI T.END _ }
    IF { T.TI T.IF _ }
    THEN { T.TI T.THEN _ }
    ELSE { T.TI T.ELSE _ }
    ENDIF { T.TI T.ENDIF _ }
    WHILE { T.TI T.WHILE _ }
    ENDWHILE { T.TI T.ENDWHILE _ }
    DO { T.TI T.DO _ }
    ENDDO { T.TI T.ENDDO _ }
    FOR { T.TI T.FOR _ }
    FROM { T.TI T.FROM _ }
    TO { T.TI T.TO _ }
    DOWNTO { T.TI T.DOWNTO _ }
    ENDFOR { T.TI T.ENDFOR _ }
    READ { T.TI T.READ _ }
    WRITE { T.TI T.WRITE _ }

    -- Operators
    ':=' { T.TI T.ASSIGN _ }
    '+' { T.TI T.ADD _ }
    '-' { T.TI T.SUB _ }
    '*' { T.TI T.MUL _ }
    '/' { T.TI T.DIV _ }
    '%' { T.TI T.MOD _ }
    '=' { T.TI T.EQ _ }
    '!=' { T.TI T.NEQ _ }
    '<' { T.TI T.LT _ }
    '<=' { T.TI T.LEQ _ }
    '>' { T.TI T.GT _ }
    '>=' { T.TI T.GEQ _ }

    VAL { T.TI (T.VAL $$) _ }
    ID { T.TI (T.ID $$) _ }

    ';' { T.TI T.SEMI _ }
    ':' { T.TI T.COLON _ }
    '(' { T.TI T.LPAR _ }
    ')' { T.TI T.RPAR _ }

%%

program :   DECLARE declarations IN commands END { AST.Program (reverse $2) (reverse $4) }

declarations :: { AST.Declarations }
    :   declarations ID ';' { (AST.DeclVar $2) : $1 }
    |   declarations ID '(' VAL ':' VAL ')' ';' { (AST.DeclArray $2 $4 $6) : $1 }
    |   { [] } 

commands 
    :   commands command { $2 : $1 }
    |   command { [$1] }

command 
    :   identifier ':=' expression ';' { AST.ASSIGN $1 $3 }
    |   IF condition THEN commands maybeElse ENDIF { AST.IF $2 $4 $5 }
    |   WHILE condition DO commands ENDWHILE { AST.WHILE $2 $4 }
    |   DO commands WHILE condition ENDDO { AST.DO_WHILE $2 $4 }
    |   FOR iterator DO commands ENDFOR { AST.FOR $2 $4 }
    |   READ identifier ';' { AST.READ $2 }
    |   WRITE value ';' { AST.WRITE $2 }

maybeElse
    :   ELSE commands { Just $2 }
    |   {- empty -} { Nothing }

iterator :   ID FROM value iterDirection { $4 $1 $3 }

iterDirection
    :   TO value { \id l -> AST.IterTo id l $2 }
    |   DOWNTO value { \id l -> AST.IterDownTo id l $2 }

expression 
    :   value { AST.ExVal $1 }
    |   value '+' value { AST.Op AST.ADD $1 $3 }
    |   value '-' value { AST.Op AST.SUB $1 $3 }
    |   value '*' value { AST.Op AST.MUL $1 $3 }
    |   value '/' value { AST.Op AST.DIV $1 $3 }
    |   value '%' value { AST.Op AST.MOD $1 $3 }

condition
    :   value '=' value { AST.Comp AST.EQ $1 $3}
    |   value '!=' value { AST.Comp AST.NEQ $1 $3}
    |   value '<' value { AST.Comp AST.LT $1 $3}
    |   value '<=' value { AST.Comp AST.LEQ $1 $3}
    |   value '>' value { AST.Comp AST.GT $1 $3}
    |   value '>=' value { AST.Comp AST.GEQ $1 $3}

value 
    :   identifier { AST.ValId $1 }
    |   VAL { AST.ValNum $1 }

identifier 
    :   ID { AST.Id $1 }
    |   ID '(' ID ')' { AST.ArrayId $1 $3 }
    |   ID '(' VAL ')' { AST.ArrayNum $1 $3 }

{

parseError :: [T.TokenInfo] -> Except String a
parseError ((T.TI tok pos):_) = 
    let (line, col) = pos
        msg = "SYNTAX ERROR: Unexpected token: " ++ show tok
            ++ " at " ++ show line ++ ":" ++ show col
    in throwError msg
parseError [] = throwError "Unexpected EOF"

parser :: String -> Either String AST.Program
parser str = case (L.lexerTI str) of
    Left error -> Left error
    Right tokens -> runExcept $ program tokens

}
