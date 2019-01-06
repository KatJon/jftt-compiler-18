module Machine.CodeGen where

import Language.IR.TAC
import Machine.Instruction
import Machine.MemoryModel
import Machine.Register

codeGen :: [TAC] -> (Integer -> MemAddress) -> [Instruction]
codeGen tac getAddress = fillLabels $ (tac >>= generate) ++ [HALT]
    where
        generate :: TAC -> [Instruction]
        generate (TComment comm) = [COMMENT comm]
        generate (TLabel lbl) = [LABEL lbl]
        generate (TJump lbl) = [JLABEL lbl]
        generate (TAssign target source) = genAssign target source
        generate (TRead target) = genRead target
        generate (TWrite source) = genWrite source
        generate (TIf comp lbl) = genIf comp lbl

        genRead target = [COMMENT "READ"]

        genWrite source = [COMMENT "WRITE"]

        genIf comp lbl = [COMMENT "IF JUMP"]

        genAssign target source = [COMMENT "ASSIGN"]

        genConst reg c = 
            where
                bits 0 acc = acc
                bits i acc = bits (i `div` 2) $ (i `mod` 2) : acc
