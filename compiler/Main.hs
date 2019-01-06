module Main where

import Control.Monad

import Language.Syntax.AST
import Language.Syntax.Parser
import Language.Validation.TypeChecker as TC
import Language.IR.ASTtoTAC
import Machine.MemoryModel
import Machine.CodeGen

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
            let getAddress = flattenMemory memory
            let targetCode = codeGen stac getAddress
            putStrLn $ take 20 $ repeat '-'
            putStrLn . unlines . fmap show $ stac
            putStrLn $ take 20 $ repeat '-'
            putStrLn . unlines . fmap show $ targetCode
