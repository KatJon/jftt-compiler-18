.PHONY=all kompilator

all: kompilator

kompilator:
	alex --ghc Language/Lexer.x
	happy Language/Parser.y
	ghc -outputdir dist --make Main.hs -o $@
