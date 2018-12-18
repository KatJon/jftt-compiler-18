module Main where

import Language.Parser

main = do
    input <- getContents
    let stream = parser input
    print stream
