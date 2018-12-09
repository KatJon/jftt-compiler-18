module Machine.Instruction where

import Machine.Register

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
    | JUMP Int
    | JZERO Reg Int
    | JODD Reg Int
    -- Cost 0
    | HALT
    -- Additional "artificial" instructions, simplifying target code
    | JLABEL Int
    | LABEL Int

generate :: Instruction -> String
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
generate (LABEL _) = error "Cannot generate code for LABEL"

instance Show Instruction where
    show (JLABEL i) = "(JUMP_LABEL " ++ (show i) ++ ")"
    show (LABEL i) = "(LABEL " ++ (show i) ++ ")"
    show instr = "(" ++ generate instr ++ ")"
