module Main where

import Control.Monad
import System.Environment

import Language.Syntax.AST
import Language.Syntax.Parser
import Language.Validation.TypeChecker as TC
import Language.IR.ASTtoTAC
import Machine.MemoryModel
import Machine.CodeGen

import Control.Monad.State
 
main = do
    args <- getArgs
    if length args < 2 then do 
        putStrLn "Wrong number of arguments!"
        putStrLn "Usage: kompilator input target"
    else do
        let (infile : outfile : _) = args
        compile infile outfile

debug = False

compile :: String -> String -> IO ()
compile infile outfile = do
    input <- readFile infile
    debug `when` putStrLn "JFTT Compiler 2018/19 - Szymon Wróbel 236761"
    let program = do
        ast <- parser input
        validate ast
    case program of 
        Left error -> putStrLn error
        Right prog -> do
            debug `when` putStrLn "Analysis successful..."
            let (TC.Program st cmds) = prog
            let memory = buildMemory st
            let stac = cmds `seq` getTAC memory cmds
            debug `when` putStrLn "Generating code..."
            let getAddress = flattenMemory memory
            let targetInstr = codeGen stac getAddress
            let outputData = targetInstr `seq` unlines . fmap show $ targetInstr
            debug `when` putStrLn "Writing to file..."
            writeFile outfile outputData
