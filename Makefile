CC=gcc
YACC_FLAGS=

.PHONY: all clear zip

all: parser

parser: lexer.l parser.y
	yacc -d parser.y $(YACC_FLAGS)
	lex lexer.l
	$(CC) lex.yy.c y.tab.c $(FLAGS) -o parser

clear:
	rm -rf lexer parser
