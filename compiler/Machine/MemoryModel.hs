module Machine.MemoryModel where

import Data.List
import qualified Data.Map.Strict as Map

import qualified Language.Common as LC

type VarId = Integer

data MemoryEntry
    = Var String VarId
    | Array String VarId Integer Integer
    | Iterator String VarId VarId
    deriving (Show, Eq)

getVarName :: MemoryEntry -> String
getVarName (Var s _) = s
getVarName (Array s _ _ _) = s
getVarName (Iterator s _ _) = s

getVarId :: MemoryEntry -> VarId
getVarId (Var _ id) = id
getVarId (Array _ id _ _) = id
getVarId (Iterator _ id _) = id

getVarPriority :: MemoryEntry -> Int
getVarPriority (Var _ _) = 0
getVarPriority (Array _ _ _ _) = 1
getVarPriority (Iterator _ _ _) = 2

data Memory = Memory {
    varmap :: Map.Map String MemoryEntry,
    vars :: [MemoryEntry],
    iterators :: [MemoryEntry],
    nextId :: Integer
    }
    deriving (Show, Eq)

buildMemory :: LC.SymbolTable -> Memory
buildMemory st = run symbols Map.empty [] 0
    where
        symbols = Map.toList st

        run [] vmap variables n = Memory vmap variables [] n
        run (x:xs) vmap variables n = 
            let (vmap', variables') = build x vmap variables n
            in run xs vmap' variables' (n+1)

        build (s, (LC.SR _ symbol)) vmap variables n = 
            let entry = case symbol of
                    LC.Scalar -> Var s n
                    LC.Array l r -> Array s n l r
            in (Map.insert s entry vmap, (entry : variables))

withIterator :: Memory -> String -> Memory
withIterator (Memory vmap vars it n) name =
    let entry = Iterator name n (n+1)
        vmap' = Map.insert name entry vmap 
    in Memory vmap' vars (entry:it) (n+2)

data MemAddress 
    = AddrVar Integer
    -- | AddrArr { baseAddress :: Integer, offset :: Integer }
    | AddrArr Integer Integer
    deriving (Show)

-- FM nextAddr nextId idMapping
data FlatMemory = FM Integer Integer (Map.Map Integer MemAddress)
    deriving (Show)

flattenMemory :: Memory -> (VarId -> MemAddress)
flattenMemory mem id = (Map.!) idMap id
    where
        sorted = sortOn getVarPriority $ sortOn getVarId (vars mem)
        (FM nextAddr maxId idMap) = process 0 sorted [] 0
        
        process a [] mapping maxId = FM a maxId (Map.fromList mapping)
        process a ((Var _ i):vs) mapping _ =
            let entry = AddrVar a in
            let mapping' = (i, entry):mapping in
                process (a+1) vs mapping' i
        process a ((Array _ i l r):vs) mapping _ =
            let entry = AddrArr a l in
            let mapping' = (i, entry):mapping in
            let a' = a + r - l + 1 in
                process a' vs mapping' i
