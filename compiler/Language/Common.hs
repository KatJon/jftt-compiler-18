module Language.Common where

import qualified Data.Map.Strict as Map

type Position = (Int, Int)

data SymbolType
    = Scalar
    | Array Integer Integer
    deriving (Show, Eq)

symbolTypeName (Scalar) = "Scalar"
symbolTypeName (Array _ _) = "Array"

data SymbolRecord = SR Position SymbolType
    deriving (Show, Eq)

type SymbolTable = Map.Map String SymbolRecord
