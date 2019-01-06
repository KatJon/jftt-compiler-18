module Main where

import Control.Monad

import Language.Syntax.AST
import Language.Syntax.Parser
import Language.Validation.TypeChecker as TC
import Language.IR.ASTtoTAC
import Machine.MemoryModel

import Control.Monad.State
 
main = do
    input <- getContents
    let program = do
        ast <- parser input
        validate ast
    case program of 
        Left error -> putStrLn error
        Right prog -> do
            putStrLn "Analysis successful"
            let (TC.Program st cmds) = prog
            let memory = buildMemory st
            let stac = getTAC memory cmds
            putStrLn . unlines . fmap show $ stac
            print prog
