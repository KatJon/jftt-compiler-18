{-# OPTIONS_GHC -w #-}
module Language.Parser (parser) where

import Control.Monad.Except

import qualified Language.Lexer as L
import qualified Language.AST as AST
import qualified Language.Token as T
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn t4 t6 t7 t8 t9 t10 t11 t12 t13 t14
	= HappyTerminal (T.TokenInfo)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 (AST.Declarations)
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,205) ([16384,0,0,0,2,0,0,0,0,0,0,0,0,2048,0,512,0,24913,4096,0,0,0,5,0,0,0,0,0,16,6144,1557,256,0,0,0,0,0,2,0,0,0,3,0,0,24,34816,778,128,0,0,1024,0,0,8192,0,0,32768,1,0,0,64,0,0,96,0,0,1024,0,0,0,0,0,0,0,0,0,8,32768,0,0,0,32,0,32768,12456,2048,0,256,0,0,0,64512,0,512,0,0,0,0,192,0,0,0,0,0,0,0,0,0,4,0,0,4,0,0,128,0,57344,3,0,24913,4096,0,0,49152,0,0,0,6,0,0,48,0,0,384,0,0,3072,0,0,24576,0,10784,12,2,0,0,24,0,0,192,16384,6228,1024,0,0,0,0,0,0,0,0,0,128,0,0,1024,0,0,0,0,0,0,0,35464,32771,0,0,3,0,32768,1,0,4096,1559,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49834,8192,0,0,32768,1,0,0,12,0,0,96,0,0,768,0,0,6144,0,0,0,0,0,0,64,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,16384,6228,1024,0,0,0,0,0,0,0,0,0,0,0,0,96,0,0,768,0,0,0,0,0,0,0,0,0,0,41472,194,32,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_program","program","declarations","commands","command","maybeElse","iterator","iterDirection","expression","condition","value","identifier","DECLARE","IN","END","IF","THEN","ELSE","ENDIF","WHILE","ENDWHILE","DO","ENDDO","FOR","FROM","TO","DOWNTO","ENDFOR","READ","WRITE","':='","'+'","'-'","'*'","'/'","'%'","'='","'!='","'<'","'<='","'>'","'>='","VAL","ID","';'","':'","'('","')'","%eof"]
        bit_start = st * 51
        bit_end = (st + 1) * 51
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..50]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (15) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (15) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (5) = happyGoto action_4
action_2 _ = happyReduce_4

action_3 (51) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (16) = happyShift action_5
action_4 (46) = happyShift action_6
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (18) = happyShift action_12
action_5 (22) = happyShift action_13
action_5 (24) = happyShift action_14
action_5 (26) = happyShift action_15
action_5 (31) = happyShift action_16
action_5 (32) = happyShift action_17
action_5 (46) = happyShift action_18
action_5 (6) = happyGoto action_9
action_5 (7) = happyGoto action_10
action_5 (14) = happyGoto action_11
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (47) = happyShift action_7
action_6 (49) = happyShift action_8
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_2

action_8 (45) = happyShift action_33
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (17) = happyShift action_32
action_9 (18) = happyShift action_12
action_9 (22) = happyShift action_13
action_9 (24) = happyShift action_14
action_9 (26) = happyShift action_15
action_9 (31) = happyShift action_16
action_9 (32) = happyShift action_17
action_9 (46) = happyShift action_18
action_9 (7) = happyGoto action_31
action_9 (14) = happyGoto action_11
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_6

action_11 (33) = happyShift action_30
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (45) = happyShift action_22
action_12 (46) = happyShift action_18
action_12 (12) = happyGoto action_29
action_12 (13) = happyGoto action_28
action_12 (14) = happyGoto action_21
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (45) = happyShift action_22
action_13 (46) = happyShift action_18
action_13 (12) = happyGoto action_27
action_13 (13) = happyGoto action_28
action_13 (14) = happyGoto action_21
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (18) = happyShift action_12
action_14 (22) = happyShift action_13
action_14 (24) = happyShift action_14
action_14 (26) = happyShift action_15
action_14 (31) = happyShift action_16
action_14 (32) = happyShift action_17
action_14 (46) = happyShift action_18
action_14 (6) = happyGoto action_26
action_14 (7) = happyGoto action_10
action_14 (14) = happyGoto action_11
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (46) = happyShift action_25
action_15 (9) = happyGoto action_24
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (46) = happyShift action_18
action_16 (14) = happyGoto action_23
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (45) = happyShift action_22
action_17 (46) = happyShift action_18
action_17 (13) = happyGoto action_20
action_17 (14) = happyGoto action_21
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (49) = happyShift action_19
action_18 _ = happyReduce_33

action_19 (45) = happyShift action_50
action_19 (46) = happyShift action_51
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (47) = happyShift action_49
action_20 _ = happyFail (happyExpListPerState 20)

action_21 _ = happyReduce_31

action_22 _ = happyReduce_32

action_23 (47) = happyShift action_48
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (24) = happyShift action_47
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (27) = happyShift action_46
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (18) = happyShift action_12
action_26 (22) = happyShift action_45
action_26 (24) = happyShift action_14
action_26 (26) = happyShift action_15
action_26 (31) = happyShift action_16
action_26 (32) = happyShift action_17
action_26 (46) = happyShift action_18
action_26 (7) = happyGoto action_31
action_26 (14) = happyGoto action_11
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (24) = happyShift action_44
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (39) = happyShift action_38
action_28 (40) = happyShift action_39
action_28 (41) = happyShift action_40
action_28 (42) = happyShift action_41
action_28 (43) = happyShift action_42
action_28 (44) = happyShift action_43
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (19) = happyShift action_37
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (45) = happyShift action_22
action_30 (46) = happyShift action_18
action_30 (11) = happyGoto action_35
action_30 (13) = happyGoto action_36
action_30 (14) = happyGoto action_21
action_30 _ = happyFail (happyExpListPerState 30)

action_31 _ = happyReduce_5

action_32 _ = happyReduce_1

action_33 (48) = happyShift action_34
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (45) = happyShift action_71
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (47) = happyShift action_70
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (34) = happyShift action_65
action_36 (35) = happyShift action_66
action_36 (36) = happyShift action_67
action_36 (37) = happyShift action_68
action_36 (38) = happyShift action_69
action_36 _ = happyReduce_19

action_37 (18) = happyShift action_12
action_37 (22) = happyShift action_13
action_37 (24) = happyShift action_14
action_37 (26) = happyShift action_15
action_37 (31) = happyShift action_16
action_37 (32) = happyShift action_17
action_37 (46) = happyShift action_18
action_37 (6) = happyGoto action_64
action_37 (7) = happyGoto action_10
action_37 (14) = happyGoto action_11
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (45) = happyShift action_22
action_38 (46) = happyShift action_18
action_38 (13) = happyGoto action_63
action_38 (14) = happyGoto action_21
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (45) = happyShift action_22
action_39 (46) = happyShift action_18
action_39 (13) = happyGoto action_62
action_39 (14) = happyGoto action_21
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (45) = happyShift action_22
action_40 (46) = happyShift action_18
action_40 (13) = happyGoto action_61
action_40 (14) = happyGoto action_21
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (45) = happyShift action_22
action_41 (46) = happyShift action_18
action_41 (13) = happyGoto action_60
action_41 (14) = happyGoto action_21
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (45) = happyShift action_22
action_42 (46) = happyShift action_18
action_42 (13) = happyGoto action_59
action_42 (14) = happyGoto action_21
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (45) = happyShift action_22
action_43 (46) = happyShift action_18
action_43 (13) = happyGoto action_58
action_43 (14) = happyGoto action_21
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (18) = happyShift action_12
action_44 (22) = happyShift action_13
action_44 (24) = happyShift action_14
action_44 (26) = happyShift action_15
action_44 (31) = happyShift action_16
action_44 (32) = happyShift action_17
action_44 (46) = happyShift action_18
action_44 (6) = happyGoto action_57
action_44 (7) = happyGoto action_10
action_44 (14) = happyGoto action_11
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (45) = happyShift action_22
action_45 (46) = happyShift action_18
action_45 (12) = happyGoto action_56
action_45 (13) = happyGoto action_28
action_45 (14) = happyGoto action_21
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (45) = happyShift action_22
action_46 (46) = happyShift action_18
action_46 (13) = happyGoto action_55
action_46 (14) = happyGoto action_21
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (18) = happyShift action_12
action_47 (22) = happyShift action_13
action_47 (24) = happyShift action_14
action_47 (26) = happyShift action_15
action_47 (31) = happyShift action_16
action_47 (32) = happyShift action_17
action_47 (46) = happyShift action_18
action_47 (6) = happyGoto action_54
action_47 (7) = happyGoto action_10
action_47 (14) = happyGoto action_11
action_47 _ = happyFail (happyExpListPerState 47)

action_48 _ = happyReduce_12

action_49 _ = happyReduce_13

action_50 (50) = happyShift action_53
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (50) = happyShift action_52
action_51 _ = happyFail (happyExpListPerState 51)

action_52 _ = happyReduce_34

action_53 _ = happyReduce_35

action_54 (18) = happyShift action_12
action_54 (22) = happyShift action_13
action_54 (24) = happyShift action_14
action_54 (26) = happyShift action_15
action_54 (30) = happyShift action_85
action_54 (31) = happyShift action_16
action_54 (32) = happyShift action_17
action_54 (46) = happyShift action_18
action_54 (7) = happyGoto action_31
action_54 (14) = happyGoto action_11
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (28) = happyShift action_83
action_55 (29) = happyShift action_84
action_55 (10) = happyGoto action_82
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (24) = happyShift action_44
action_56 (25) = happyShift action_81
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (18) = happyShift action_12
action_57 (22) = happyShift action_13
action_57 (23) = happyShift action_80
action_57 (24) = happyShift action_14
action_57 (26) = happyShift action_15
action_57 (31) = happyShift action_16
action_57 (32) = happyShift action_17
action_57 (46) = happyShift action_18
action_57 (7) = happyGoto action_31
action_57 (14) = happyGoto action_11
action_57 _ = happyFail (happyExpListPerState 57)

action_58 _ = happyReduce_30

action_59 _ = happyReduce_29

action_60 _ = happyReduce_28

action_61 _ = happyReduce_27

action_62 _ = happyReduce_26

action_63 _ = happyReduce_25

action_64 (18) = happyShift action_12
action_64 (20) = happyShift action_79
action_64 (22) = happyShift action_13
action_64 (24) = happyShift action_14
action_64 (26) = happyShift action_15
action_64 (31) = happyShift action_16
action_64 (32) = happyShift action_17
action_64 (46) = happyShift action_18
action_64 (7) = happyGoto action_31
action_64 (8) = happyGoto action_78
action_64 (14) = happyGoto action_11
action_64 _ = happyReduce_15

action_65 (45) = happyShift action_22
action_65 (46) = happyShift action_18
action_65 (13) = happyGoto action_77
action_65 (14) = happyGoto action_21
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (45) = happyShift action_22
action_66 (46) = happyShift action_18
action_66 (13) = happyGoto action_76
action_66 (14) = happyGoto action_21
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (45) = happyShift action_22
action_67 (46) = happyShift action_18
action_67 (13) = happyGoto action_75
action_67 (14) = happyGoto action_21
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (45) = happyShift action_22
action_68 (46) = happyShift action_18
action_68 (13) = happyGoto action_74
action_68 (14) = happyGoto action_21
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (45) = happyShift action_22
action_69 (46) = happyShift action_18
action_69 (13) = happyGoto action_73
action_69 (14) = happyGoto action_21
action_69 _ = happyFail (happyExpListPerState 69)

action_70 _ = happyReduce_7

action_71 (50) = happyShift action_72
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (47) = happyShift action_90
action_72 _ = happyFail (happyExpListPerState 72)

action_73 _ = happyReduce_24

action_74 _ = happyReduce_23

action_75 _ = happyReduce_22

action_76 _ = happyReduce_21

action_77 _ = happyReduce_20

action_78 (21) = happyShift action_89
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (18) = happyShift action_12
action_79 (22) = happyShift action_13
action_79 (24) = happyShift action_14
action_79 (26) = happyShift action_15
action_79 (31) = happyShift action_16
action_79 (32) = happyShift action_17
action_79 (46) = happyShift action_18
action_79 (6) = happyGoto action_88
action_79 (7) = happyGoto action_10
action_79 (14) = happyGoto action_11
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_9

action_81 _ = happyReduce_10

action_82 _ = happyReduce_16

action_83 (45) = happyShift action_22
action_83 (46) = happyShift action_18
action_83 (13) = happyGoto action_87
action_83 (14) = happyGoto action_21
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (45) = happyShift action_22
action_84 (46) = happyShift action_18
action_84 (13) = happyGoto action_86
action_84 (14) = happyGoto action_21
action_84 _ = happyFail (happyExpListPerState 84)

action_85 _ = happyReduce_11

action_86 _ = happyReduce_18

action_87 _ = happyReduce_17

action_88 (18) = happyShift action_12
action_88 (22) = happyShift action_13
action_88 (24) = happyShift action_14
action_88 (26) = happyShift action_15
action_88 (31) = happyShift action_16
action_88 (32) = happyShift action_17
action_88 (46) = happyShift action_18
action_88 (7) = happyGoto action_31
action_88 (14) = happyGoto action_11
action_88 _ = happyReduce_14

action_89 _ = happyReduce_8

action_90 _ = happyReduce_3

happyReduce_1 = happyReduce 5 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (AST.Program (reverse happy_var_2) (reverse happy_var_4)
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_3  5 happyReduction_2
happyReduction_2 _
	(HappyTerminal (T.TI (T.ID happy_var_2) _))
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 ((AST.DeclVar happy_var_2) : happy_var_1
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happyReduce 8 5 happyReduction_3
happyReduction_3 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.TI (T.VAL happy_var_6) _)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.TI (T.VAL happy_var_4) _)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.TI (T.ID happy_var_2) _)) `HappyStk`
	(HappyAbsSyn5  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 ((AST.DeclArray happy_var_2 happy_var_4 happy_var_6) : happy_var_1
	) `HappyStk` happyRest

happyReduce_4 = happySpecReduce_0  5 happyReduction_4
happyReduction_4  =  HappyAbsSyn5
		 ([]
	)

happyReduce_5 = happySpecReduce_2  6 happyReduction_5
happyReduction_5 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_2 : happy_var_1
	)
happyReduction_5 _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  6 happyReduction_6
happyReduction_6 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happyReduce 4 7 happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.ASSIGN happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 6 7 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.IF happy_var_2 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 5 7 happyReduction_9
happyReduction_9 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.WHILE happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 5 7 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.DO_WHILE happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 5 7 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.FOR happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (AST.READ happy_var_2
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  7 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (AST.WRITE happy_var_2
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_2  8 happyReduction_14
happyReduction_14 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (Just happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_0  8 happyReduction_15
happyReduction_15  =  HappyAbsSyn8
		 (Nothing
	)

happyReduce_16 = happyReduce 4 9 happyReduction_16
happyReduction_16 ((HappyAbsSyn10  happy_var_4) `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.TI (T.ID happy_var_1) _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (happy_var_4 happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_2  10 happyReduction_17
happyReduction_17 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (\id l -> AST.IterTo id l happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  10 happyReduction_18
happyReduction_18 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (\id l -> AST.IterDownTo id l happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  11 happyReduction_19
happyReduction_19 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.ExVal happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  11 happyReduction_20
happyReduction_20 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.ADD happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  11 happyReduction_21
happyReduction_21 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.SUB happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  11 happyReduction_22
happyReduction_22 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.MUL happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  11 happyReduction_23
happyReduction_23 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.DIV happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  11 happyReduction_24
happyReduction_24 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.MOD happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  12 happyReduction_25
happyReduction_25 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.EQ happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  12 happyReduction_26
happyReduction_26 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.NEQ happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  12 happyReduction_27
happyReduction_27 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.LT happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  12 happyReduction_28
happyReduction_28 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.LEQ happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  12 happyReduction_29
happyReduction_29 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.GT happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  12 happyReduction_30
happyReduction_30 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.GEQ happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  13 happyReduction_31
happyReduction_31 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (AST.ValId happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  13 happyReduction_32
happyReduction_32 (HappyTerminal (T.TI (T.VAL happy_var_1) _))
	 =  HappyAbsSyn13
		 (AST.ValNum happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  14 happyReduction_33
happyReduction_33 (HappyTerminal (T.TI (T.ID happy_var_1) _))
	 =  HappyAbsSyn14
		 (AST.Id happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happyReduce 4 14 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyTerminal (T.TI (T.ID happy_var_3) _)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.TI (T.ID happy_var_1) _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AST.ArrayId happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 4 14 happyReduction_35
happyReduction_35 (_ `HappyStk`
	(HappyTerminal (T.TI (T.VAL happy_var_3) _)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.TI (T.ID happy_var_1) _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AST.ArrayNum happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 51 51 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	T.TI T.DECLARE _ -> cont 15;
	T.TI T.IN _ -> cont 16;
	T.TI T.END _ -> cont 17;
	T.TI T.IF _ -> cont 18;
	T.TI T.THEN _ -> cont 19;
	T.TI T.ELSE _ -> cont 20;
	T.TI T.ENDIF _ -> cont 21;
	T.TI T.WHILE _ -> cont 22;
	T.TI T.ENDWHILE _ -> cont 23;
	T.TI T.DO _ -> cont 24;
	T.TI T.ENDDO _ -> cont 25;
	T.TI T.FOR _ -> cont 26;
	T.TI T.FROM _ -> cont 27;
	T.TI T.TO _ -> cont 28;
	T.TI T.DOWNTO _ -> cont 29;
	T.TI T.ENDFOR _ -> cont 30;
	T.TI T.READ _ -> cont 31;
	T.TI T.WRITE _ -> cont 32;
	T.TI T.ASSIGN _ -> cont 33;
	T.TI T.ADD _ -> cont 34;
	T.TI T.SUB _ -> cont 35;
	T.TI T.MUL _ -> cont 36;
	T.TI T.DIV _ -> cont 37;
	T.TI T.MOD _ -> cont 38;
	T.TI T.EQ _ -> cont 39;
	T.TI T.NEQ _ -> cont 40;
	T.TI T.LT _ -> cont 41;
	T.TI T.LEQ _ -> cont 42;
	T.TI T.GT _ -> cont 43;
	T.TI T.GEQ _ -> cont 44;
	T.TI (T.VAL happy_dollar_dollar) _ -> cont 45;
	T.TI (T.ID happy_dollar_dollar) _ -> cont 46;
	T.TI T.SEMI _ -> cont 47;
	T.TI T.COLON _ -> cont 48;
	T.TI T.LPAR _ -> cont 49;
	T.TI T.RPAR _ -> cont 50;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 51 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Except String a -> (a -> Except String b) -> Except String b
happyThen = ((>>=))
happyReturn :: () => a -> Except String a
happyReturn = (return)
happyThen1 m k tks = ((>>=)) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Except String a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(T.TokenInfo)], [String]) -> Except String a
happyError' = (\(tokens, _) -> parseError tokens)
program tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [T.TokenInfo] -> Except String a
parseError ((T.TI tok pos):_) = 
    let (line, col) = pos
        msg = "SYNTAX ERROR: Unexpected token: " ++ show tok
            ++ " at " ++ show line ++ ":" ++ show col
    in throwError msg
parseError [] = throwError "Unexpected EOF"

parser :: String -> Either String AST.Program
parser str = case (L.lexerTI str) of
    Left error -> Left error
    Right tokens -> runExcept $ program tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 15 "<built-in>" #-}
{-# LINE 1 "/usr/local/Cellar/ghc/8.4.3/lib/ghc-8.4.3/include/ghcversion.h" #-}
















{-# LINE 16 "<built-in>" #-}
{-# LINE 1 "/var/folders/50/j00w7d395hd4rcb52btb39g80000gn/T/ghc17959_0/ghc_2.h" #-}





















































































































































































































































































{-# LINE 17 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 










{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList








{-# LINE 65 "templates/GenericTemplate.hs" #-}


{-# LINE 75 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 137 "templates/GenericTemplate.hs" #-}


{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

