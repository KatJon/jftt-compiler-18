.PHONY: kompilator
all: kompilator

Language/Syntax/Lexer.hs: Language/Syntax/Lexer.x
	alex --ghc $^

Language/Syntax/Parser.hs: Language/Syntax/Parser.y
	happy --ghc $^

kompilator: Language/Syntax/Lexer.hs Language/Syntax/Parser.hs
	ghc -outputdir dist --make Main.hs -o $@
