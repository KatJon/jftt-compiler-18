module Machine.MemoryModel where

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
