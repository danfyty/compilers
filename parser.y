%{

#include <stdio.h>
#include "error_utils.h"

int yylex();					/* função do analisador léxico (lê e retorna tokens) */
void yyerror(const char*);		/* função chamada quando há erro sintático */
void init();					/* função que inicializa a tabela de palavras reservadas */

extern error_t current_error;
extern int yylineno;
extern const char *error_msg[];
extern char *yytext;

%}

%error-verbose

%token EOF_TOKEN
%token PROGRAM
%token BEG1N	
%token END
%token CONST
%token VAR
%token REAL
%token INTEGER
%token PROCEDURE
%token ELSE
%token READ
%token WRITE
%token WHILE
%token DO
%token IF
%token FOR
%token TO
%token THEN
%token INT
%token FLOAT
%token ID
%token SEMICOLON
%token PERIOD
%token EQUAL
%token COLON
%token COMMA
%token LBRACKET
%token RBRACKET
%token ATTRIB
%token NOTEQUAL
%token GEQUAL
%token LEQUAL
%token GREATER
%token LESSER
%token PLUS 
%token MINUS
%token MULT
%token DIV


%%

program: PROGRAM ID SEMICOLON body
	   | error PROGRAM ID SEMICOLON body
	   | error SEMICOLON body
       ;

body: dc BEG1N commands END

/* declarações e variáveis*/
dc: dc_c dc_v dc_p
  | dc_c dc_v dc_p error BEG1N {puts("AAA");}

dc_c: dc_cc dc_c | %empty

dc_cc: CONST ID EQUAL number SEMICOLON
	| error SEMICOLON {yyerrok;}



dc_v: dc_vv dc_v | %empty

dc_vv: VAR variables COLON var_type SEMICOLON

var_type: REAL | INTEGER
		| error {}

variables: ID more_var
		 | error {yyerrok;yyclearin;}

more_var: COMMA variables | %empty


/*declaracao de procedures*/
dc_p: dc_pp dc_p | %empty
dc_pp: PROCEDURE ID parameters SEMICOLON body_p


parameters: LBRACKET param_list RBRACKET | %empty
param_list: variables COLON var_type more_param
more_param: SEMICOLON param_list | %empty
body_p: dc_loc BEG1N commands END SEMICOLON
dc_loc: dc_v

/*fim declaracao de procedures*/


arg_list: LBRACKET arguments RBRACKET | %empty
arguments: ID more_id
more_id: SEMICOLON arguments | %empty
false_p: ELSE cmd | %empty
commands: cmd SEMICOLON commands | %empty
cmd: READ LBRACKET variables RBRACKET
   | WRITE LBRACKET variables RBRACKET
   | WHILE LBRACKET condition RBRACKET DO cmd
   | FOR ID ATTRIB INT TO INT DO cmd
   | IF condition THEN cmd false_p 
   | ID ATTRIB expression
   | ID arg_list 
   | BEG1N commands END
condition: expression comparator expression
comparator: GEQUAL | LEQUAL | EQUAL | GREATER | LESSER | NOTEQUAL
expression: term other_terms
unary_op: PLUS | MINUS | %empty
other_terms: add_op term other_terms | %empty
add_op: PLUS | MINUS
term: unary_op factor more_factors
more_factors: mult_op factor more_factors | %empty
mult_op: MULT | DIV
factor: ID | number | LBRACKET expression RBRACKET
number: INT | FLOAT

%%

void yyerror(const char* s)
{
	//printf ("Erro %d: %s\n", yylineno, error_msg[(int)current_error]); 

	printf ("Error %d: ", yylineno); 

	if (current_error == INVALID_CHAR)
	{
		puts(error_msg[(int)current_error]);
	}
	else 
	{
		puts(s);
	}
}

int main()
{
	init();
	yyparse();
	printf("Análise sintática concluída.\n");
	return 0;
}
