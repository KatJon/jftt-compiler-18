.PHONY: all kompilator
all: kompilator

kompilator:
	alex --ghc Language/Syntax/Lexer.x
	happy --ghc Language/Syntax/Parser.y
	ghc -outputdir dist --make Main.hs -o $@
