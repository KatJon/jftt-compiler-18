module Main where

import Control.Monad

import Language.Syntax.AST
import Language.Syntax.Parser
import Language.Validation.TypeChecker
 
main = do
    input <- getContents
    let analysis = do
        ast <- parser input
        validate ast
    case analysis of 
        Left error -> putStrLn error
        Right program -> do
            putStrLn "Analysis successful"
            print program
