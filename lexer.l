	/* Primeira seção: definições de regexes, opções e declarações */
	
	/* Variável global contadora de linhas */
%option yylineno

	/* Declara que não será usada/implementada a função yywrap */ 
%option noyywrap

%{

#include "y.tab.h"

%}

	/* Estado exclusivo para leitura de comentários */
%x COMMENT


%{
#define INVALID_CHARACTER_ERROR -1
#define UNCLOSED_COMMENT_ERROR -2

int is_lexical_error = 0;


/*
char* token_name[] = {
"EOF_TOKEN",
"PROGRAM",
"BEGIN", 
"END",
"CONST",
"VAR",
"REAL",
"INTEGER",
"PROCEDURE",
"ELSE",
"READ",
"WRITE",
"WHILE",
"DO",
"IF",
"FOR",
"TO",
"THEN",
"INT",
"FLOAT",
"ID",
"SEMICOLON",
"PERIOD",
"EQUAL",
"COLON",
"COMMA",
"LBRACKET",
"RBRACKET",
"ATTRIB",
"NOTEQUAL",
"GEQUAL",
"LEQUAL",
"GREATER",
"LESSER",
"PLUS",
"MINUS",
"MULT",
"DIV"};
*/

char* reserved_word[] = {
"program",
"begin", 
"end",
"const",
"var",
"real",
"integer",
"procedure",
"else",
"read",
"write",
"while",
"do",
"if",
"for",
"to",
"then",
NULL			/* Este NULL marcando o término do vetor é útil na função init() */
};

int reserved_word_token[] = {
	PROGRAM,
	BEG1N,
	END,
	CONST,
	VAR,
	REAL,
	INTEGER,
	PROCEDURE,
	ELSE,
	READ,
	WRITE,
	WHILE,
	DO,
	IF,
	FOR,
	TO,
	THEN
};

/* Tabela de Palavras Reservadas - Implementada como uma trie. */
#define MAX_WORD_LENGTH 20
#define MAX_TRIE_NODES 1000
#define ALPHABET_SIZE 26			/* Note que a trie não aceita dígitos. */
#define WORD_NOT_FOUND -1

int trie[MAX_TRIE_NODES+1][ALPHABET_SIZE];
int node_word[MAX_TRIE_NODES];		/* Para cada nó da trie, guarda a palavra a que ele corresponde, se corresponder a alguma. */
int word_count = 0;
int node_count = 1;

void trie_add(char* s)
{
	int node = 0;
	while (*s != '\0')
	{
		if (trie[node][*s-'a'] == 0)
			trie[node][*s-'a'] = node_count++;
		node = trie[node][*s-'a'];
		s++;
	}
	node_word[node] = reserved_word_token[word_count++];
}

/* Se encontrar s na trie, retorna o índice de s.
Palavras na trie recebem índices ordenados, começando de 1,
na ordem em que forem inseridas. Elas são inseridas na mesma ordem 
em que aparecem no enum e vetores acima declarados. */
int trie_find(char* s)
{
	int node = 0;
	while (*s != '\0')
	{
		if (*s < 'a' || *s > 'z')		/* Trie só contém palavras com caracteres minúsculos de a-z. */
			return WORD_NOT_FOUND;

		if (trie[node][*s-'a'])
			node = trie[node][*s-'a'];
		else
			return WORD_NOT_FOUND;
		s++;
	}
	return node_word[node];
}

/* Insere as palavras reservadas na trie. */
void init()
{
	memset(node_word, WORD_NOT_FOUND, sizeof(node_word));
	char** w = reserved_word;
	while (*w)
	{
		trie_add(*w);
		w++;
	}
}

%}


	/* Segunda seção: regexes e ações associadas */

%%

[0-9]*					{return INT;}
[0-9]+\.[0-9]+			{return FLOAT;}
[a-z][a-z0-9]*			{int w = trie_find(yytext); return w == WORD_NOT_FOUND ? ID : w;}
;						{return SEMICOLON;}
\.						{return PERIOD;}
=						{return EQUAL;}
:						{return COLON;}
,						{return COMMA;}
\(						{return LBRACKET;}
\)						{return RBRACKET;}
:=						{return ATTRIB;}			/* Lembrando que o desempate é por maior match */
\<\>					{return NOTEQUAL;}
\>=						{return GEQUAL;}
\<=						{return LEQUAL;}
\>						{return GREATER;}
\<						{return LESSER;}
\+						{return PLUS;}
\-						{return MINUS;}
\*						{return MULT;}
\/						{return DIV;}

[ \t\n]+				;							/* Ignorando espaços, tabs e linebreaks */
													/* Obs: ao encontrar EOF, a ação default é retornar 0.*/
\{						BEGIN(COMMENT);
<COMMENT>\}				BEGIN(INITIAL);
<COMMENT>.				;

<COMMENT>\n				{BEGIN(INITIAL); fprintf (stderr, "[%d] Error:\tunclosed comment\n", yylineno-1);} /*nao retornamos token quando ele ocorre, ou seja, a linha eh ignorada*/
<COMMENT><<EOF>>		{BEGIN(INITIAL); fprintf (stderr, "[%d] Error:\tunclosed comment\n", yylineno);}

.						{is_lexical_error = 1; return INVALID_CHARACTER_ERROR;} /*isso causa um erro no analizador sintatico que sabera, pela variavel current_error, que o erro eh lexico*/
%%
