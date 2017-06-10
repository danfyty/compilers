CC=gcc
YACC_FLAGS=--debug --verbose

.PHONY: all clear zip

all: parser

parser: error_utils.c error_utils.h lexer.l parser.y
	yacc -d parser.y $(YACC_FLAGS)
	lex lexer.l
	$(CC) error_utils.c lex.yy.c y.tab.c $(FLAGS) -o parser

clear:
	rm -rf lexer parser
