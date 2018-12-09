module Main where

import Machine.Instruction
import Control.Monad

code = [
    GET A,
    JZERO A 10,
    COPY B A,
    HALF B,
    ADD B B,
    COPY C A,
    SUB C B,
    PUT C,
    HALF A,
    JUMP 1,
    HALT
    ]

main = forM_ code $ putStrLn . generate
