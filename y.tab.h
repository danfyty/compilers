/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    EOF_TOKEN = 258,
    PROGRAM = 259,
    BEG1N = 260,
    END = 261,
    CONST = 262,
    VAR = 263,
    REAL = 264,
    INTEGER = 265,
    PROCEDURE = 266,
    ELSE = 267,
    READ = 268,
    WRITE = 269,
    WHILE = 270,
    DO = 271,
    IF = 272,
    FOR = 273,
    TO = 274,
    THEN = 275,
    INT = 276,
    FLOAT = 277,
    ID = 278,
    SEMICOLON = 279,
    PERIOD = 280,
    EQUAL = 281,
    COLON = 282,
    COMMA = 283,
    LBRACKET = 284,
    RBRACKET = 285,
    ATTRIB = 286,
    NOTEQUAL = 287,
    GEQUAL = 288,
    LEQUAL = 289,
    GREATER = 290,
    LESSER = 291,
    PLUS = 292,
    MINUS = 293,
    MULT = 294,
    DIV = 295
  };
#endif
/* Tokens.  */
#define EOF_TOKEN 258
#define PROGRAM 259
#define BEG1N 260
#define END 261
#define CONST 262
#define VAR 263
#define REAL 264
#define INTEGER 265
#define PROCEDURE 266
#define ELSE 267
#define READ 268
#define WRITE 269
#define WHILE 270
#define DO 271
#define IF 272
#define FOR 273
#define TO 274
#define THEN 275
#define INT 276
#define FLOAT 277
#define ID 278
#define SEMICOLON 279
#define PERIOD 280
#define EQUAL 281
#define COLON 282
#define COMMA 283
#define LBRACKET 284
#define RBRACKET 285
#define ATTRIB 286
#define NOTEQUAL 287
#define GEQUAL 288
#define LEQUAL 289
#define GREATER 290
#define LESSER 291
#define PLUS 292
#define MINUS 293
#define MULT 294
#define DIV 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
