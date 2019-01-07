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

        genRead target = [GET B] ++ regToMem B target

        genWrite val = valToReg val B ++ [PUT B]

        genIf comp lbl = case comp of
            CEq l r -> cmpCEq l r ++ [JLABEL lbl]
            CNeq l r -> cmpCEq l r ++ [OFFSET JUMP 2, JLABEL lbl]
            CGe l r -> cmpCGe l r ++ [JZEROLABEL B lbl]
            CLt l r -> cmpCGe l r ++ [OFFSET (JZERO B) 2, JLABEL lbl]
            CLe l r -> cmpCLe l r ++ [JZEROLABEL B lbl]
            CGt l r -> cmpCLe l r ++ [OFFSET (JZERO B) 2, JLABEL lbl]

            where   
                cmpCEq u v = valToReg u B ++ valToReg v C 
                    ++ [COPY D B, 
                        SUB B C, 
                        OFFSET (JZERO B) 2, 
                        OFFSET JUMP 4,
                        SUB C D,
                        OFFSET (JZERO C) 2,
                        OFFSET JUMP 2
                        ]
                
                cmpCGe u v = valToReg u C ++ valToReg v B
                    ++ [SUB B C] 
                
                cmpCLe u v = valToReg u B ++ valToReg v C
                    ++ [SUB B C] 

        genAssign target source = case source of
            EVal v -> valToReg v B ++ regToMem B target
            EAdd l r -> execOp l r [ADD B C]
            ESub l r -> execOp l r [SUB B C]
            EMul l r -> execOp l r $ macroMul B C
            EDiv l r -> execOp l r $ macroDiv B C
            EMod l r -> execOp l r $ macroMod B C
            where
                execOp l r op = valToReg l B ++ valToReg r C ++ op ++ regToMem B target

        valToReg (VNum i) reg = genConst reg i
        valToReg (VMem source) reg = memToReg source reg
    
        regToMem reg mem = case mem of
            MVar id -> let (AddrVar addr) = getAddress id in
                genConst A addr ++ [STORE reg]
            MArrNum arrid i -> 
                let (AddrArr arraddr offset) = getAddress arrid in 
                let address = max (arraddr + i - offset) 0 in
                genConst A address ++ [STORE reg]
            MArrVar arrid varid -> 
                let (AddrArr arraddr offset) = getAddress arrid in
                let (AddrVar varaddr) = getAddress varid in
                genConst A varaddr ++ [LOAD H]
                ++ genConst A arraddr
                ++ [ADD A H]
                ++ genConst H offset
                ++ [SUB A H, STORE reg]

        memToReg mem reg = case mem of
            MVar id -> let (AddrVar addr) = getAddress id in
                genConst A addr ++ [LOAD reg]
            MArrNum arrid i -> 
                let (AddrArr arraddr offset) = getAddress arrid in 
                let address = max (arraddr + i - offset) 0 in
                genConst A address ++ [LOAD reg]
            MArrVar arrid varid -> 
                let (AddrArr arraddr offset) = getAddress arrid in
                let (AddrVar varaddr) = getAddress varid in
                genConst A varaddr ++ [LOAD H]
                ++ genConst A arraddr
                ++ [ADD A H]
                ++ genConst H offset
                ++ [SUB A H, LOAD reg]

        genConst :: Reg -> Integer -> [Instruction]
        genConst reg c
            | c < 25 = (SUB reg reg) : (take (fromIntegral c) $ repeat (INC reg))
            | otherwise = let half = genConst reg (c `div` 2) in
                    if c `mod` 2 == 0
                        then half ++ [ADD reg reg]
                        else half ++ [ADD reg reg, INC reg]


        macroMul reg1 reg2 = error "macroMul not implemented"

        macroDiv reg1 reg2 = error "macroDiv not implemented"

        macroMod reg1 reg2 = error "macroMod not implemented"
