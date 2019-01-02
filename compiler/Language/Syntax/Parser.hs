{-# OPTIONS_GHC -w #-}
{-# OPTIONS -XMagicHash -XBangPatterns -XTypeSynonymInstances -XFlexibleInstances -cpp #-}
#if __GLASGOW_HASKELL__ >= 710
{-# OPTIONS_GHC -XPartialTypeSignatures #-}
#endif
module Language.Syntax.Parser (parser) where

import Control.Monad.Except

import qualified Language.Syntax.Token as T
import qualified Language.Syntax.Lexer as L
import qualified Language.Syntax.AST as AST
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import qualified GHC.Exts as Happy_GHC_Exts
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

happyExpList :: HappyAddr
happyExpList = HappyA# "\x00\x40\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x02\x00\x00\x51\x61\x00\x10\x00\x00\x00\x00\x00\x00\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x18\x15\x06\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x18\x00\x00\x88\x0a\x03\x80\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x80\x01\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x60\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x80\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x80\xa8\x30\x00\x08\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\xfc\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\xc0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x80\x00\x00\x00\x00\xe0\x03\x00\x00\x00\x51\x61\x00\x10\x00\x00\x00\x00\x00\xc0\x00\x00\x00\x00\x00\x00\x06\x00\x00\x00\x00\x00\x30\x00\x00\x00\x00\x00\x80\x01\x00\x00\x00\x00\x00\x0c\x00\x00\x00\x00\x00\x60\x00\x00\x20\x2a\x0c\x00\x02\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00\xc0\x00\x00\x40\x54\x18\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x88\x8a\x03\x80\x00\x00\x00\x00\x03\x00\x00\x00\x00\x80\x01\x00\x00\x00\x00\x10\x17\x06\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xaa\xc2\x00\x20\x00\x00\x00\x00\x00\x80\x01\x00\x00\x00\x00\x00\x0c\x00\x00\x00\x00\x00\x60\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x40\x54\x18\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x60\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa2\xc2\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

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

action_0 (15#) = happyShift action_2
action_0 (4#) = happyGoto action_3
action_0 x = happyTcHack x happyFail (happyExpListPerState 0)

action_1 (15#) = happyShift action_2
action_1 x = happyTcHack x happyFail (happyExpListPerState 1)

action_2 (5#) = happyGoto action_4
action_2 x = happyTcHack x happyReduce_4

action_3 (51#) = happyAccept
action_3 x = happyTcHack x happyFail (happyExpListPerState 3)

action_4 (16#) = happyShift action_5
action_4 (46#) = happyShift action_6
action_4 x = happyTcHack x happyFail (happyExpListPerState 4)

action_5 (18#) = happyShift action_12
action_5 (22#) = happyShift action_13
action_5 (24#) = happyShift action_14
action_5 (26#) = happyShift action_15
action_5 (31#) = happyShift action_16
action_5 (32#) = happyShift action_17
action_5 (46#) = happyShift action_18
action_5 (6#) = happyGoto action_9
action_5 (7#) = happyGoto action_10
action_5 (14#) = happyGoto action_11
action_5 x = happyTcHack x happyFail (happyExpListPerState 5)

action_6 (47#) = happyShift action_7
action_6 (49#) = happyShift action_8
action_6 x = happyTcHack x happyFail (happyExpListPerState 6)

action_7 x = happyTcHack x happyReduce_2

action_8 (45#) = happyShift action_33
action_8 x = happyTcHack x happyFail (happyExpListPerState 8)

action_9 (17#) = happyShift action_32
action_9 (18#) = happyShift action_12
action_9 (22#) = happyShift action_13
action_9 (24#) = happyShift action_14
action_9 (26#) = happyShift action_15
action_9 (31#) = happyShift action_16
action_9 (32#) = happyShift action_17
action_9 (46#) = happyShift action_18
action_9 (7#) = happyGoto action_31
action_9 (14#) = happyGoto action_11
action_9 x = happyTcHack x happyFail (happyExpListPerState 9)

action_10 x = happyTcHack x happyReduce_6

action_11 (33#) = happyShift action_30
action_11 x = happyTcHack x happyFail (happyExpListPerState 11)

action_12 (45#) = happyShift action_22
action_12 (46#) = happyShift action_18
action_12 (12#) = happyGoto action_29
action_12 (13#) = happyGoto action_28
action_12 (14#) = happyGoto action_21
action_12 x = happyTcHack x happyFail (happyExpListPerState 12)

action_13 (45#) = happyShift action_22
action_13 (46#) = happyShift action_18
action_13 (12#) = happyGoto action_27
action_13 (13#) = happyGoto action_28
action_13 (14#) = happyGoto action_21
action_13 x = happyTcHack x happyFail (happyExpListPerState 13)

action_14 (18#) = happyShift action_12
action_14 (22#) = happyShift action_13
action_14 (24#) = happyShift action_14
action_14 (26#) = happyShift action_15
action_14 (31#) = happyShift action_16
action_14 (32#) = happyShift action_17
action_14 (46#) = happyShift action_18
action_14 (6#) = happyGoto action_26
action_14 (7#) = happyGoto action_10
action_14 (14#) = happyGoto action_11
action_14 x = happyTcHack x happyFail (happyExpListPerState 14)

action_15 (46#) = happyShift action_25
action_15 (9#) = happyGoto action_24
action_15 x = happyTcHack x happyFail (happyExpListPerState 15)

action_16 (46#) = happyShift action_18
action_16 (14#) = happyGoto action_23
action_16 x = happyTcHack x happyFail (happyExpListPerState 16)

action_17 (45#) = happyShift action_22
action_17 (46#) = happyShift action_18
action_17 (13#) = happyGoto action_20
action_17 (14#) = happyGoto action_21
action_17 x = happyTcHack x happyFail (happyExpListPerState 17)

action_18 (49#) = happyShift action_19
action_18 x = happyTcHack x happyReduce_33

action_19 (45#) = happyShift action_50
action_19 (46#) = happyShift action_51
action_19 x = happyTcHack x happyFail (happyExpListPerState 19)

action_20 (47#) = happyShift action_49
action_20 x = happyTcHack x happyFail (happyExpListPerState 20)

action_21 x = happyTcHack x happyReduce_31

action_22 x = happyTcHack x happyReduce_32

action_23 (47#) = happyShift action_48
action_23 x = happyTcHack x happyFail (happyExpListPerState 23)

action_24 (24#) = happyShift action_47
action_24 x = happyTcHack x happyFail (happyExpListPerState 24)

action_25 (27#) = happyShift action_46
action_25 x = happyTcHack x happyFail (happyExpListPerState 25)

action_26 (18#) = happyShift action_12
action_26 (22#) = happyShift action_45
action_26 (24#) = happyShift action_14
action_26 (26#) = happyShift action_15
action_26 (31#) = happyShift action_16
action_26 (32#) = happyShift action_17
action_26 (46#) = happyShift action_18
action_26 (7#) = happyGoto action_31
action_26 (14#) = happyGoto action_11
action_26 x = happyTcHack x happyFail (happyExpListPerState 26)

action_27 (24#) = happyShift action_44
action_27 x = happyTcHack x happyFail (happyExpListPerState 27)

action_28 (39#) = happyShift action_38
action_28 (40#) = happyShift action_39
action_28 (41#) = happyShift action_40
action_28 (42#) = happyShift action_41
action_28 (43#) = happyShift action_42
action_28 (44#) = happyShift action_43
action_28 x = happyTcHack x happyFail (happyExpListPerState 28)

action_29 (19#) = happyShift action_37
action_29 x = happyTcHack x happyFail (happyExpListPerState 29)

action_30 (45#) = happyShift action_22
action_30 (46#) = happyShift action_18
action_30 (11#) = happyGoto action_35
action_30 (13#) = happyGoto action_36
action_30 (14#) = happyGoto action_21
action_30 x = happyTcHack x happyFail (happyExpListPerState 30)

action_31 x = happyTcHack x happyReduce_5

action_32 x = happyTcHack x happyReduce_1

action_33 (48#) = happyShift action_34
action_33 x = happyTcHack x happyFail (happyExpListPerState 33)

action_34 (45#) = happyShift action_71
action_34 x = happyTcHack x happyFail (happyExpListPerState 34)

action_35 (47#) = happyShift action_70
action_35 x = happyTcHack x happyFail (happyExpListPerState 35)

action_36 (34#) = happyShift action_65
action_36 (35#) = happyShift action_66
action_36 (36#) = happyShift action_67
action_36 (37#) = happyShift action_68
action_36 (38#) = happyShift action_69
action_36 x = happyTcHack x happyReduce_19

action_37 (18#) = happyShift action_12
action_37 (22#) = happyShift action_13
action_37 (24#) = happyShift action_14
action_37 (26#) = happyShift action_15
action_37 (31#) = happyShift action_16
action_37 (32#) = happyShift action_17
action_37 (46#) = happyShift action_18
action_37 (6#) = happyGoto action_64
action_37 (7#) = happyGoto action_10
action_37 (14#) = happyGoto action_11
action_37 x = happyTcHack x happyFail (happyExpListPerState 37)

action_38 (45#) = happyShift action_22
action_38 (46#) = happyShift action_18
action_38 (13#) = happyGoto action_63
action_38 (14#) = happyGoto action_21
action_38 x = happyTcHack x happyFail (happyExpListPerState 38)

action_39 (45#) = happyShift action_22
action_39 (46#) = happyShift action_18
action_39 (13#) = happyGoto action_62
action_39 (14#) = happyGoto action_21
action_39 x = happyTcHack x happyFail (happyExpListPerState 39)

action_40 (45#) = happyShift action_22
action_40 (46#) = happyShift action_18
action_40 (13#) = happyGoto action_61
action_40 (14#) = happyGoto action_21
action_40 x = happyTcHack x happyFail (happyExpListPerState 40)

action_41 (45#) = happyShift action_22
action_41 (46#) = happyShift action_18
action_41 (13#) = happyGoto action_60
action_41 (14#) = happyGoto action_21
action_41 x = happyTcHack x happyFail (happyExpListPerState 41)

action_42 (45#) = happyShift action_22
action_42 (46#) = happyShift action_18
action_42 (13#) = happyGoto action_59
action_42 (14#) = happyGoto action_21
action_42 x = happyTcHack x happyFail (happyExpListPerState 42)

action_43 (45#) = happyShift action_22
action_43 (46#) = happyShift action_18
action_43 (13#) = happyGoto action_58
action_43 (14#) = happyGoto action_21
action_43 x = happyTcHack x happyFail (happyExpListPerState 43)

action_44 (18#) = happyShift action_12
action_44 (22#) = happyShift action_13
action_44 (24#) = happyShift action_14
action_44 (26#) = happyShift action_15
action_44 (31#) = happyShift action_16
action_44 (32#) = happyShift action_17
action_44 (46#) = happyShift action_18
action_44 (6#) = happyGoto action_57
action_44 (7#) = happyGoto action_10
action_44 (14#) = happyGoto action_11
action_44 x = happyTcHack x happyFail (happyExpListPerState 44)

action_45 (45#) = happyShift action_22
action_45 (46#) = happyShift action_18
action_45 (12#) = happyGoto action_56
action_45 (13#) = happyGoto action_28
action_45 (14#) = happyGoto action_21
action_45 x = happyTcHack x happyFail (happyExpListPerState 45)

action_46 (45#) = happyShift action_22
action_46 (46#) = happyShift action_18
action_46 (13#) = happyGoto action_55
action_46 (14#) = happyGoto action_21
action_46 x = happyTcHack x happyFail (happyExpListPerState 46)

action_47 (18#) = happyShift action_12
action_47 (22#) = happyShift action_13
action_47 (24#) = happyShift action_14
action_47 (26#) = happyShift action_15
action_47 (31#) = happyShift action_16
action_47 (32#) = happyShift action_17
action_47 (46#) = happyShift action_18
action_47 (6#) = happyGoto action_54
action_47 (7#) = happyGoto action_10
action_47 (14#) = happyGoto action_11
action_47 x = happyTcHack x happyFail (happyExpListPerState 47)

action_48 x = happyTcHack x happyReduce_12

action_49 x = happyTcHack x happyReduce_13

action_50 (50#) = happyShift action_53
action_50 x = happyTcHack x happyFail (happyExpListPerState 50)

action_51 (50#) = happyShift action_52
action_51 x = happyTcHack x happyFail (happyExpListPerState 51)

action_52 x = happyTcHack x happyReduce_34

action_53 x = happyTcHack x happyReduce_35

action_54 (18#) = happyShift action_12
action_54 (22#) = happyShift action_13
action_54 (24#) = happyShift action_14
action_54 (26#) = happyShift action_15
action_54 (30#) = happyShift action_85
action_54 (31#) = happyShift action_16
action_54 (32#) = happyShift action_17
action_54 (46#) = happyShift action_18
action_54 (7#) = happyGoto action_31
action_54 (14#) = happyGoto action_11
action_54 x = happyTcHack x happyFail (happyExpListPerState 54)

action_55 (28#) = happyShift action_83
action_55 (29#) = happyShift action_84
action_55 (10#) = happyGoto action_82
action_55 x = happyTcHack x happyFail (happyExpListPerState 55)

action_56 (24#) = happyShift action_44
action_56 (25#) = happyShift action_81
action_56 x = happyTcHack x happyFail (happyExpListPerState 56)

action_57 (18#) = happyShift action_12
action_57 (22#) = happyShift action_13
action_57 (23#) = happyShift action_80
action_57 (24#) = happyShift action_14
action_57 (26#) = happyShift action_15
action_57 (31#) = happyShift action_16
action_57 (32#) = happyShift action_17
action_57 (46#) = happyShift action_18
action_57 (7#) = happyGoto action_31
action_57 (14#) = happyGoto action_11
action_57 x = happyTcHack x happyFail (happyExpListPerState 57)

action_58 x = happyTcHack x happyReduce_30

action_59 x = happyTcHack x happyReduce_29

action_60 x = happyTcHack x happyReduce_28

action_61 x = happyTcHack x happyReduce_27

action_62 x = happyTcHack x happyReduce_26

action_63 x = happyTcHack x happyReduce_25

action_64 (18#) = happyShift action_12
action_64 (20#) = happyShift action_79
action_64 (22#) = happyShift action_13
action_64 (24#) = happyShift action_14
action_64 (26#) = happyShift action_15
action_64 (31#) = happyShift action_16
action_64 (32#) = happyShift action_17
action_64 (46#) = happyShift action_18
action_64 (7#) = happyGoto action_31
action_64 (8#) = happyGoto action_78
action_64 (14#) = happyGoto action_11
action_64 x = happyTcHack x happyReduce_15

action_65 (45#) = happyShift action_22
action_65 (46#) = happyShift action_18
action_65 (13#) = happyGoto action_77
action_65 (14#) = happyGoto action_21
action_65 x = happyTcHack x happyFail (happyExpListPerState 65)

action_66 (45#) = happyShift action_22
action_66 (46#) = happyShift action_18
action_66 (13#) = happyGoto action_76
action_66 (14#) = happyGoto action_21
action_66 x = happyTcHack x happyFail (happyExpListPerState 66)

action_67 (45#) = happyShift action_22
action_67 (46#) = happyShift action_18
action_67 (13#) = happyGoto action_75
action_67 (14#) = happyGoto action_21
action_67 x = happyTcHack x happyFail (happyExpListPerState 67)

action_68 (45#) = happyShift action_22
action_68 (46#) = happyShift action_18
action_68 (13#) = happyGoto action_74
action_68 (14#) = happyGoto action_21
action_68 x = happyTcHack x happyFail (happyExpListPerState 68)

action_69 (45#) = happyShift action_22
action_69 (46#) = happyShift action_18
action_69 (13#) = happyGoto action_73
action_69 (14#) = happyGoto action_21
action_69 x = happyTcHack x happyFail (happyExpListPerState 69)

action_70 x = happyTcHack x happyReduce_7

action_71 (50#) = happyShift action_72
action_71 x = happyTcHack x happyFail (happyExpListPerState 71)

action_72 (47#) = happyShift action_90
action_72 x = happyTcHack x happyFail (happyExpListPerState 72)

action_73 x = happyTcHack x happyReduce_24

action_74 x = happyTcHack x happyReduce_23

action_75 x = happyTcHack x happyReduce_22

action_76 x = happyTcHack x happyReduce_21

action_77 x = happyTcHack x happyReduce_20

action_78 (21#) = happyShift action_89
action_78 x = happyTcHack x happyFail (happyExpListPerState 78)

action_79 (18#) = happyShift action_12
action_79 (22#) = happyShift action_13
action_79 (24#) = happyShift action_14
action_79 (26#) = happyShift action_15
action_79 (31#) = happyShift action_16
action_79 (32#) = happyShift action_17
action_79 (46#) = happyShift action_18
action_79 (6#) = happyGoto action_88
action_79 (7#) = happyGoto action_10
action_79 (14#) = happyGoto action_11
action_79 x = happyTcHack x happyFail (happyExpListPerState 79)

action_80 x = happyTcHack x happyReduce_9

action_81 x = happyTcHack x happyReduce_10

action_82 x = happyTcHack x happyReduce_16

action_83 (45#) = happyShift action_22
action_83 (46#) = happyShift action_18
action_83 (13#) = happyGoto action_87
action_83 (14#) = happyGoto action_21
action_83 x = happyTcHack x happyFail (happyExpListPerState 83)

action_84 (45#) = happyShift action_22
action_84 (46#) = happyShift action_18
action_84 (13#) = happyGoto action_86
action_84 (14#) = happyGoto action_21
action_84 x = happyTcHack x happyFail (happyExpListPerState 84)

action_85 x = happyTcHack x happyReduce_11

action_86 x = happyTcHack x happyReduce_18

action_87 x = happyTcHack x happyReduce_17

action_88 (18#) = happyShift action_12
action_88 (22#) = happyShift action_13
action_88 (24#) = happyShift action_14
action_88 (26#) = happyShift action_15
action_88 (31#) = happyShift action_16
action_88 (32#) = happyShift action_17
action_88 (46#) = happyShift action_18
action_88 (7#) = happyGoto action_31
action_88 (14#) = happyGoto action_11
action_88 x = happyTcHack x happyReduce_14

action_89 x = happyTcHack x happyReduce_8

action_90 x = happyTcHack x happyReduce_3

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_1 = happyReduce 5# 4# happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (AST.Program (reverse happy_var_2) (reverse happy_var_4)
	) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_2 = happySpecReduce_3  5# happyReduction_2
happyReduction_2 _
	(HappyTerminal (T.TI (T.ID happy_var_2) _))
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 ((AST.DeclVar happy_var_2) : happy_var_1
	)
happyReduction_2 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_3 = happyReduce 8# 5# happyReduction_3
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

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_4 = happySpecReduce_0  5# happyReduction_4
happyReduction_4  =  HappyAbsSyn5
		 ([]
	)

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_5 = happySpecReduce_2  6# happyReduction_5
happyReduction_5 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_2 : happy_var_1
	)
happyReduction_5 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_6 = happySpecReduce_1  6# happyReduction_6
happyReduction_6 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_6 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_7 = happyReduce 4# 7# happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.ASSIGN happy_var_1 happy_var_3
	) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_8 = happyReduce 6# 7# happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.IF happy_var_2 (reverse happy_var_4) happy_var_5
	) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_9 = happyReduce 5# 7# happyReduction_9
happyReduction_9 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.WHILE happy_var_2 (reverse happy_var_4)
	) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_10 = happyReduce 5# 7# happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.DO_WHILE (reverse happy_var_2) happy_var_4
	) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_11 = happyReduce 5# 7# happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (AST.FOR happy_var_2 (reverse happy_var_4)
	) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_12 = happySpecReduce_3  7# happyReduction_12
happyReduction_12 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (AST.READ happy_var_2
	)
happyReduction_12 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_13 = happySpecReduce_3  7# happyReduction_13
happyReduction_13 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (AST.WRITE happy_var_2
	)
happyReduction_13 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_14 = happySpecReduce_2  8# happyReduction_14
happyReduction_14 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (Just (reverse happy_var_2)
	)
happyReduction_14 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_15 = happySpecReduce_0  8# happyReduction_15
happyReduction_15  =  HappyAbsSyn8
		 (Nothing
	)

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_16 = happyReduce 4# 9# happyReduction_16
happyReduction_16 ((HappyAbsSyn10  happy_var_4) `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.TI (T.ID happy_var_1) _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (happy_var_4 happy_var_1 happy_var_3
	) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_17 = happySpecReduce_2  10# happyReduction_17
happyReduction_17 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (\id l -> AST.IterTo id l happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_18 = happySpecReduce_2  10# happyReduction_18
happyReduction_18 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (\id l -> AST.IterDownTo id l happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_19 = happySpecReduce_1  11# happyReduction_19
happyReduction_19 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.ExVal happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_20 = happySpecReduce_3  11# happyReduction_20
happyReduction_20 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.Op AST.ADD happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_21 = happySpecReduce_3  11# happyReduction_21
happyReduction_21 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.Op AST.SUB happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_22 = happySpecReduce_3  11# happyReduction_22
happyReduction_22 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.Op AST.MUL happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_23 = happySpecReduce_3  11# happyReduction_23
happyReduction_23 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.Op AST.DIV happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_24 = happySpecReduce_3  11# happyReduction_24
happyReduction_24 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (AST.Op AST.MOD happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_25 = happySpecReduce_3  12# happyReduction_25
happyReduction_25 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.Comp AST.EQ happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_26 = happySpecReduce_3  12# happyReduction_26
happyReduction_26 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.Comp AST.NEQ happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_27 = happySpecReduce_3  12# happyReduction_27
happyReduction_27 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.Comp AST.LT happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_28 = happySpecReduce_3  12# happyReduction_28
happyReduction_28 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.Comp AST.LEQ happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_29 = happySpecReduce_3  12# happyReduction_29
happyReduction_29 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.Comp AST.GT happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_30 = happySpecReduce_3  12# happyReduction_30
happyReduction_30 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (AST.Comp AST.GEQ happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_31 = happySpecReduce_1  13# happyReduction_31
happyReduction_31 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (AST.ValId happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_32 = happySpecReduce_1  13# happyReduction_32
happyReduction_32 (HappyTerminal (T.TI (T.VAL happy_var_1) _))
	 =  HappyAbsSyn13
		 (AST.ValNum happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_33 = happySpecReduce_1  14# happyReduction_33
happyReduction_33 (HappyTerminal (T.TI (T.ID happy_var_1) _))
	 =  HappyAbsSyn14
		 (AST.Id happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_34 = happyReduce 4# 14# happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyTerminal (T.TI (T.ID happy_var_3) _)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.TI (T.ID happy_var_1) _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AST.ArrayId happy_var_1 happy_var_3
	) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_35 = happyReduce 4# 14# happyReduction_35
happyReduction_35 (_ `HappyStk`
	(HappyTerminal (T.TI (T.VAL happy_var_3) _)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.TI (T.ID happy_var_1) _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AST.ArrayNum happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 51# 51# notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	T.TI T.DECLARE _ -> cont 15#;
	T.TI T.IN _ -> cont 16#;
	T.TI T.END _ -> cont 17#;
	T.TI T.IF _ -> cont 18#;
	T.TI T.THEN _ -> cont 19#;
	T.TI T.ELSE _ -> cont 20#;
	T.TI T.ENDIF _ -> cont 21#;
	T.TI T.WHILE _ -> cont 22#;
	T.TI T.ENDWHILE _ -> cont 23#;
	T.TI T.DO _ -> cont 24#;
	T.TI T.ENDDO _ -> cont 25#;
	T.TI T.FOR _ -> cont 26#;
	T.TI T.FROM _ -> cont 27#;
	T.TI T.TO _ -> cont 28#;
	T.TI T.DOWNTO _ -> cont 29#;
	T.TI T.ENDFOR _ -> cont 30#;
	T.TI T.READ _ -> cont 31#;
	T.TI T.WRITE _ -> cont 32#;
	T.TI T.ASSIGN _ -> cont 33#;
	T.TI T.ADD _ -> cont 34#;
	T.TI T.SUB _ -> cont 35#;
	T.TI T.MUL _ -> cont 36#;
	T.TI T.DIV _ -> cont 37#;
	T.TI T.MOD _ -> cont 38#;
	T.TI T.EQ _ -> cont 39#;
	T.TI T.NEQ _ -> cont 40#;
	T.TI T.LT _ -> cont 41#;
	T.TI T.LEQ _ -> cont 42#;
	T.TI T.GT _ -> cont 43#;
	T.TI T.GEQ _ -> cont 44#;
	T.TI (T.VAL happy_dollar_dollar) _ -> cont 45#;
	T.TI (T.ID happy_dollar_dollar) _ -> cont 46#;
	T.TI T.SEMI _ -> cont 47#;
	T.TI T.COLON _ -> cont 48#;
	T.TI T.LPAR _ -> cont 49#;
	T.TI T.RPAR _ -> cont 50#;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 51# tk tks = happyError' (tks, explist)
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
        msg = "SYNTAX ERROR: Unexpected token: " ++ T.stringify tok
            ++ " at line " ++ show line ++ " column " ++ show col
    in throwError msg
parseError [] = throwError "Unexpected EOF"

parser :: String -> Either String AST.Program
parser str = case (L.lexerTI str) of
    Left error -> Left error
    Right tokens -> runExcept $ program tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 16 "<built-in>" #-}
{-# LINE 1 "/usr/local/Cellar/ghc/8.4.3/lib/ghc-8.4.3/include/ghcversion.h" #-}
















{-# LINE 17 "<built-in>" #-}
{-# LINE 1 "/var/folders/50/j00w7d395hd4rcb52btb39g80000gn/T/ghc17962_0/ghc_2.h" #-}





















































































































































































































































































{-# LINE 18 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 













-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.
#if __GLASGOW_HASKELL__ > 706
#define LT(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.<# m)) :: Bool)
#define GTE(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.>=# m)) :: Bool)
#define EQ(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.==# m)) :: Bool)
#else
#define LT(n,m) (n Happy_GHC_Exts.<# m)
#define GTE(n,m) (n Happy_GHC_Exts.>=# m)
#define EQ(n,m) (n Happy_GHC_Exts.==# m)
#endif

{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList








{-# LINE 65 "templates/GenericTemplate.hs" #-}


{-# LINE 75 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is 1#, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 1# tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
        (happyTcHack j ) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 137 "templates/GenericTemplate.hs" #-}


indexShortOffAddr (HappyA# arr) off =
        Happy_GHC_Exts.narrow16Int# i
  where
        i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.uncheckedShiftL# high 8#) low)
        high = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr (off' Happy_GHC_Exts.+# 1#)))
        low  = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr off'))
        off' = off Happy_GHC_Exts.*# 2#




{-# INLINE happyLt #-}
happyLt x y = LT(x,y)


readArrayBit arr bit =
    Bits.testBit (Happy_GHC_Exts.I# (indexShortOffAddr arr ((unbox_int bit) `Happy_GHC_Exts.iShiftRA#` 4#))) (bit `mod` 16)
  where unbox_int (Happy_GHC_Exts.I# x) = x






data HappyAddr = HappyA# Happy_GHC_Exts.Addr#


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Happy_GHC_Exts.Int# ->                    -- token number
         Happy_GHC_Exts.Int# ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 1# tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (Happy_GHC_Exts.I# (i)) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 1# tk st sts stk
     = happyFail [] 1# tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 1# tk st sts stk
     = happyFail [] 1# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 1# tk st sts stk
     = happyFail [] 1# tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 1# tk st sts stk
     = happyFail [] 1# tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 1# tk st sts stk
     = happyFail [] 1# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn 1# tk st sts stk
     = happyFail [] 1# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn 1# tk st sts stk
     = happyFail [] 1# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Happy_GHC_Exts.Int#
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop 0# l = l
happyDrop n ((_):(t)) = happyDrop (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Happy_GHC_Exts.-# (1#::Happy_GHC_Exts.Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (1# is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist 1# tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (Happy_GHC_Exts.I# (i)) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  1# tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action 1# 1# tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action 1# 1# tk (HappyState (action)) sts ( (HappyErrorToken (Happy_GHC_Exts.I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Happy_GHC_Exts.Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


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

