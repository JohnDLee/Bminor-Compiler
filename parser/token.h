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

#ifndef YY_YY_PARSER_TOKEN_H_INCLUDED
# define YY_YY_PARSER_TOKEN_H_INCLUDED
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
    TOKEN_ARRAY = 258,
    TOKEN_AUTO = 259,
    TOKEN_BOOLEAN = 260,
    TOKEN_CHAR = 261,
    TOKEN_ELSE = 262,
    TOKEN_IF = 263,
    TOKEN_FALSE = 264,
    TOKEN_TRUE = 265,
    TOKEN_FOR = 266,
    TOKEN_FUNCTION = 267,
    TOKEN_INT = 268,
    TOKEN_PRINT = 269,
    TOKEN_RETURN = 270,
    TOKEN_STRING = 271,
    TOKEN_VOID = 272,
    TOKEN_WHILE = 273,
    TOKEN_ID = 274,
    TOKEN_RPAREN = 275,
    TOKEN_LPAREN = 276,
    TOKEN_RBRACKET = 277,
    TOKEN_LBRACKET = 278,
    TOKEN_RBRACE = 279,
    TOKEN_LBRACE = 280,
    TOKEN_INCREMENT = 281,
    TOKEN_DECREMENT = 282,
    TOKEN_NOT = 283,
    TOKEN_EXPONENT = 284,
    TOKEN_MULT = 285,
    TOKEN_DIV = 286,
    TOKEN_MOD = 287,
    TOKEN_PLUS = 288,
    TOKEN_MINUS = 289,
    TOKEN_GT = 290,
    TOKEN_LT = 291,
    TOKEN_GTE = 292,
    TOKEN_LTE = 293,
    TOKEN_EQ = 294,
    TOKEN_NOT_EQ = 295,
    TOKEN_ASSIGN = 296,
    TOKEN_COMMA = 297,
    TOKEN_COLON = 298,
    TOKEN_SEMI = 299,
    TOKEN_AND = 300,
    TOKEN_OR = 301,
    TOKEN_QMARK = 302,
    TOKEN_STR_LIT = 303,
    TOKEN_CHAR_LIT = 304,
    TOKEN_INT_LIT = 305,
    TOKEN_ERROR = 306
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TOKEN_H_INCLUDED  */
