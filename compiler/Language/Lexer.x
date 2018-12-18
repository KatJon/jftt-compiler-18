{
module Language.Lexer where

import Language.Token

}

%wrapper "monad"

@number = 0|[1-9][0-9]*
@identifier = [_a-z]+

tokens :- 
    -- Comments
    <0>     "[" { begin com }
    <com>   [^\]]|\n ;
    <com>   "]" { begin 0 }

    -- Omitting whitespace
    <0>     $white { constToken WS__ } 
    
    -- Keywords
    <0>     DECLARE { constToken DECLARE }
    <0>     IN { constToken IN }
    <0>     END { constToken END }

    <0>     IF { constToken IF }
    <0>     THEN { constToken THEN }
    <0>     ELSE { constToken ELSE }
    <0>     ENDIF { constToken ENDIF }

    <0>     WHILE { constToken WHILE }
    <0>     ENDWHILE {constToken ENDWHILE }

    <0>     DO { constToken DO }
    <0>     ENDDO { constToken ENDDO }

    <0>     FOR { constToken FOR }
    <0>     FROM { constToken FROM }
    <0>     TO { constToken TO }
    <0>     DOWNTO { constToken DOWNTO }
    <0>     ENDFOR { constToken ENDFOR }

    <0>     READ { constToken READ }
    <0>     WRITE { constToken WRITE }

    -- Operators
    <0>     ":=" { constToken ASSIGN }
    <0>     "+" { constToken ADD }
    <0>     "-" { constToken SUB }
    <0>     "*" { constToken MUL }
    <0>     "/" { constToken DIV }
    <0>     "%" { constToken MOD }
    <0>     "=" { constToken Language.Token.EQ }
    <0>     "!=" { constToken NEQ }
    <0>     "<" { constToken Language.Token.LT }
    <0>     "<=" { constToken LEQ }
    <0>     ">" { constToken Language.Token.GT }
    <0>     ">=" { constToken GEQ }

    -- Values and ids
    <0>     @number { getNumber }
    <0>     @identifier { getIdentifier }

    -- Other
    <0>     ";" { constToken SEMI }
    <0>     ":" { constToken COLON }
    <0>     "(" { constToken LPAR }
    <0>     ")" { constToken RPAR }

    -- Unknown char
    <0>     . { lexicalError }

{

getNumber :: AlexAction Token
getNumber (_, _, _, s) len = return $ numberToken s len

getIdentifier :: AlexAction Token
getIdentifier (_, _, _, s) len = return $ idToken s len

lexicalError :: AlexAction a
lexicalError (p, _, _, (c:_)) _ = 
    let showPosn (AlexPn _ line col) = show line ++ ':': show col
        msg = "ERROR: Unexpected char: " ++ [c] ++ " at " ++ showPosn p
    in alexError msg

constToken :: Token -> AlexAction Token
constToken t _ _ = return t

alexEOF :: Alex Token
alexEOF = return EOF__

lexer :: String -> Either String [Token]
lexer str = runAlex str $ do
    let loop s = do 
        tok <- alexMonadScan
        if tok == EOF__
            then return $ reverse s
            else do loop $ (tok : s)
    loop []

lexerTI :: String -> Either String [TokenInfo]
lexerTI str = runAlex str $ do
    let loop s = do 
        (p,_,_,_) <- alexGetInput
        tok <- alexMonadScan
        let (AlexPn _ line col) = p
        case tok of
            EOF__ -> return $ reverse s
            WS__ -> do loop s
            _ -> do loop $ (TI tok (line, col)) : s
    loop []

}
