#ifndef ERROR_UTILS_H
#define ERROR_UTILS_H

typedef enum {
	SYNTAX_ERROR = 0,
	INVALID_CHAR = 1,
	UNCLOSED_COMMENT=2,
	SHOULD_BEGIN_WITH_PROGRAM = 3,
	WRONG_CONST_DECL = 4,
	WRONG_VAR_DECL = 5,
	WRONG_VAR_TYPE = 6,
}error_t;

void print_error(error_t error_code, int line_num);

#endif
