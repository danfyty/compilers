%{

#include <stdio.h>

int yylex();					/* função do analisador léxico (lê e retorna tokens) */
void yyerror(const char*);		/* função chamada quando há erro sintático */
void init();					/* função que inicializa a tabela de palavras reservadas */

extern int is_lexical_error; 	/* =1 se o erro atual eh lexico*/
extern int yylineno;
extern const char *error_msg[];
extern char *yytext;
int errorn;


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

body: dc BEG1N commands END


/* declarações e variáveis*/
dc: dc_c dc_v dc_p

dc_c: dc_cc dc_c | %empty

dc_cc: CONST ID EQUAL number SEMICOLON
	| error SEMICOLON {yyerrok;}


dc_v: dc_vv dc_v | %empty

dc_vv: VAR variables COLON var_type SEMICOLON
	| VAR error SEMICOLON {yyerrok;}

var_type: REAL | INTEGER


variables: ID more_var

more_var: COMMA variables | %empty


/*declaracao de procedures*/
dc_p: dc_pp dc_p | %empty
dc_pp: PROCEDURE ID parameters SEMICOLON body_p
	| PROCEDURE error SEMICOLON body_p {yyerrok;}


parameters: LBRACKET param_list RBRACKET | %empty

param_list: variables COLON var_type more_param
		  | %empty

more_param: SEMICOLON param_list | %empty
body_p: dc_loc BEG1N commands END SEMICOLON
dc_loc: dc_v

/*fim declaracao de procedures*/

false_p: ELSE cmd | %empty


arg_list: LBRACKET arguments RBRACKET | %empty
arguments: ID more_id
more_id: SEMICOLON arguments | %empty
commands: cmd SEMICOLON commands | %empty
		| error SEMICOLON commands 				/*pula um comando ateh achar ';'*/

cmd: READ LBRACKET variables RBRACKET
   | WRITE LBRACKET variables RBRACKET
   | WHILE LBRACKET condition RBRACKET DO cmd
   | WHILE error DO cmd {yyerrok;}   			/*pula declaracao errado do WHILE ateh achar DO*/
   | FOR ID ATTRIB INT TO INT DO cmd 			/*pula declaracao errada do FOR ateh achar DO*/
   | FOR error DO cmd {yyerrok;}

   | IF condition THEN cmd false_p 
   | ID ATTRIB expression
   | ID arg_list 
   | BEG1N commands END
   | error THEN cmd false_p
   


condition: expression comparator expression
comparator: GEQUAL | LEQUAL | EQUAL | GREATER | LESSER | NOTEQUAL
expression: term other_terms
unary_op: PLUS | MINUS | %empty
other_terms: add_op term other_terms | %empty
add_op: PLUS | MINUS
term: unary_op factor more_factors
more_factors: mult_op factor more_factors | %empty
mult_op: MULT | DIV

factor: ID 
	  | number 
      | LBRACKET expression RBRACKET
      | LBRACKET error RBRACKET {;} 

number: INT | FLOAT

%%

void yyerror(const char* s)
{
	++errorn;

	fprintf (stderr, "[%d] Error:\t", yylineno); 
	if (is_lexical_error == 1)
	{
		fprintf(stderr, "Invalid Character");
	}
	else 
	{
		fprintf(stderr, "%s", s);
	}
	
	fprintf(stderr, "\t\t(%s)\n", yytext);
}

int main()
{
	errorn = 0;
	init();
	yyparse();

	printf("Parsing completed.");
	if (errorn > 0)
		printf(" %d errors found.", errorn);
	printf("\n");

	return 0;
}
