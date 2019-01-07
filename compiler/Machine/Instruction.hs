module Machine.Instruction where

import Machine.Register

import qualified Data.Map.Strict as Map

type Label = String

data Instruction
    -- Cost 100
    = GET Reg
    | PUT Reg
    -- Cost 50
    | LOAD Reg
    | STORE Reg
    -- Cost 5
    | COPY Reg Reg
    | ADD Reg Reg
    | SUB Reg Reg
    -- Cost 1
    | HALF Reg
    | INC Reg
    | DEC Reg
    | JUMP Integer
    | JZERO Reg Integer
    | JODD Reg Integer
    -- Cost 0
    | HALT
    -- Additional "artificial" instructions, simplifying target code
    | COMMENT String
    | JLABEL Label
    | JZEROLABEL Reg Label
    | JODDLABEL Reg Label
    | LABEL Label
    | OFFSET (Integer -> Instruction) Integer

generate :: Instruction -> String
generate (COMMENT s) = "# " ++ s
generate (GET r) = "GET " ++ (show r)
generate (PUT r) = "PUT " ++ (show r)
generate (LOAD r) = "LOAD " ++ (show r)
generate (STORE r) = "STORE " ++ (show r)
generate (COPY r s) = "COPY " ++ (show r) ++ " " ++ (show s)
generate (ADD r s) = "ADD " ++ (show r) ++ " " ++ (show s)
generate (SUB r s) = "SUB " ++ (show r) ++ " " ++ (show s)
generate (HALF r) = "HALF " ++ (show r)
generate (INC r) = "INC " ++ (show r)
generate (DEC r) = "DEC " ++ (show r)
generate (JUMP i) = "JUMP " ++ (show i)
generate (JZERO r i) = "JZERO " ++ (show r) ++ " " ++ (show i)
generate (JODD r i) = "JODD " ++ (show r) ++ " " ++ (show i)
generate (HALT) = "HALT"
-- Artificial instructions
generate (JLABEL _) = error "Cannot generate code for JLABEL"
generate (JZEROLABEL _ _) = error "Cannot generate code for JZEROLABEL"
generate (JODDLABEL _ _) = error "Cannot generate code for JODDLABEL"
generate (LABEL _) = error "Cannot generate code for LABEL"
generate (OFFSET _ _) = error "Cannot generate code for OFFSET"

instance Show Instruction where
    show (JLABEL i) = "JUMP_LABEL " ++ show i
    show (JZEROLABEL r i) = "JZERO_LABEL " ++ show r ++ " " ++ show i
    show (JODDLABEL r i) = "JODD_LABEL " ++ show r ++ " " ++ show i
    show (LABEL i) = "LABEL " ++ show i
    show (OFFSET jmp off) = "OFFSET (" ++ show (jmp 0) ++ ") + " ++ show off
    show instr = generate instr

fillLabels :: [Instruction] -> [Instruction]
fillLabels instructions = substLabels instructions 0 []
    where
        substLabels [] k acc = reverse acc
        substLabels (x:xs) k acc = case x of
            LABEL _  -> substLabels xs k acc
            OFFSET jump off -> let instr = jump $ k + off
                in substLabels xs (k+1) (instr:acc)
            COMMENT _ -> substLabels xs k acc
            JLABEL i -> let instr = JUMP $ (Map.!) labelPos i
                in substLabels xs (k+1) (instr:acc)
            JZEROLABEL r i -> let instr = JZERO r $ (Map.!) labelPos i
                in substLabels xs (k+1) (instr:acc)
            JODDLABEL r i -> let instr = JODD r $ (Map.!) labelPos i
                in substLabels xs (k+1) (instr:acc)
            instr -> substLabels xs (k+1) (instr:acc)

        labelPos :: Map.Map String Integer
        labelPos = getLabelPos instructions [] 0

        getLabelPos [] posList _ = Map.fromList posList
        getLabelPos (x:xs) posList i = case x of
            LABEL s -> getLabelPos xs ((s, i):posList) i
            COMMENT s -> getLabelPos xs posList i
            _ -> getLabelPos xs posList (i + 1)
