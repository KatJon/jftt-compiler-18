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
        generate (TInc mem) = genInc mem
        generate (TDec mem) = genDec mem
        generate (TDecOrJumpZero mem lbl) = genDecOrJump mem lbl
        generate (TJZero mem lbl) = genJZero mem lbl

        genDecOrJump mem lbl = memToReg mem B 
            ++ [JZEROLABEL B lbl, DEC B]
            ++ regToMem B mem

        genJZero mem lbl = memToReg mem B
            ++ [JZEROLABEL B lbl]

        genInc mem = memToReg mem B ++ [INC B] ++ regToMem B mem

        genDec mem = memToReg mem B ++ [DEC B] ++ regToMem B mem

        genRead target = [GET B] ++ regToMem B target

        genWrite val = valToReg val B ++ [PUT B]

        genIf comp lbl = case comp of
            CEq l r -> cmpCEq l r ++ [JZEROLABEL B lbl]
            CNeq l r -> cmpCEq l r ++ [OFFSET (JZERO B) 2, JLABEL lbl]
            CGe l r -> cmpCGe l r ++ [JZEROLABEL B lbl]
            CLt l r -> cmpCGe l r ++ [OFFSET (JZERO B) 2, JLABEL lbl]
            CLe l r -> cmpCLe l r ++ [JZEROLABEL B lbl]
            CGt l r -> cmpCLe l r ++ [OFFSET (JZERO B) 2, JLABEL lbl]

            where   
                cmpCEq u v = valToReg u B ++ valToReg v C 
                    ++ [COPY D B, 
                        SUB B C,
                        SUB C D,
                        ADD B C
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


        macroMul reg1 reg2 = [
            --
            COPY H reg1,
            SUB reg1 reg2,
            OFFSET (JZERO reg1) 2,
            OFFSET JUMP 4,
            COPY reg1 reg2,
            COPY reg2 H,
            COPY H reg1,
            SUB reg1 reg1,
            OFFSET (JODD reg2) 2,
            OFFSET JUMP 2,
            ADD reg1 H,
            ADD H H,
            HALF reg2,
            OFFSET (JZERO reg2) 2,
            OFFSET JUMP (-6)
            ]
        
        quotRem reg1 reg2 = [
            SUB D D,
            SUB E E,
            OFFSET (JZERO reg2) 23, -- END
            -- DIV
            COPY E reg1,
            COPY F reg2,
            SUB A A,
            -- FINDMAX
            COPY H F,
            SUB H reg1,
            OFFSET (JZERO H) 2,
            OFFSET JUMP 4,
            ADD F F,
            INC A,
            OFFSET JUMP (-6), -- JUMP FINDMAX
            HALF F,

            -- DIVLOOP
            OFFSET (JZERO A) 11,-- JUMP END DIVLOOP
            ADD D D,
            COPY H F,
            SUB H E,
            OFFSET (JZERO H) 2,
            OFFSET JUMP 3,
            INC D,
            SUB E F,
            HALF F,
            DEC A,
            OFFSET JUMP (-10) -- JUMP DIVLOOP
            -- END DIVLOOP
            -- END
            ]
        
        macroDiv reg1 reg2 = quotRem reg1 reg2 ++ [COPY reg1 D]

        macroMod reg1 reg2 = quotRem reg1 reg2 ++ [COPY reg1 E]
