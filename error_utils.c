#include "error_utils.h"
#include <stdio.h>

const char* error_msg[] = {
	"Erro Sintatico",
	"Invalid Character",
	"Comentario nao fechado",
	"Programa deve comecar com programa",
	"Declaracao de constantes devem comecar com const",
	"Variaveis sao declaradas: var a,b,c : [real,integer];",
	"Esperado um tipo (integer ou real)"
};

void print_error(error_t error_code, int line_num) {
	printf("Erro %d: %s\n", line_num, error_msg[(int)error_code]);
}
