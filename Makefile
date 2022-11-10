# Author: John Lee
# Date: 9/8/2022
# Purpose: Makefile to compile B-Minor Compiler

# compile/link all
bminor: lex.yy.o main.o bminor_helper.o parser.o token.h decl.o type.o stmt.o param_list.o expr.o symbol.o hash_table.o scope.o
	gcc lex.yy.o main.o bminor_helper.o parser.o decl.o type.o stmt.o param_list.o expr.o symbol.o hash_table.o scope.o -o bminor 

########
# Main #
########
main.o: main.c token.h
	gcc main.c -c -o main.o -Wall

bminor_helper.o: bminor_helper.c bminor_helper.h
	gcc bminor_helper.c -c -o bminor_helper.o -Wall

###########
# Scanner #
###########

# create lex.y.c
lex.yy.c: scanner.flex
	flex -o lex.yy.c scanner.flex

lex.yy.o: lex.yy.c token.h
	gcc lex.yy.c -c -o lex.yy.o

scan_test: bminor
	./tests/scanner/run_all_tests.sh
	./tests_self/scanner/run_all_tests.sh


##########
# Parser #
##########

parser.c token.h: parser.bison
	bison -o parser.c parser.bison --defines=token.h -v --debug

parser.o: parser.c
	gcc parser.c -c -o parser.o 

parse_test: bminor
	./tests/parser/run_all_tests.sh
	./tests_self/parser/run_all_tests.sh

###########
# Printer #
###########

expr.o: expr.h expr.c
	gcc expr.c -c -o expr.o -Wall

stmt.o: stmt.h stmt.c
	gcc stmt.c -c -o stmt.o -Wall

param_list.o: param_list.h param_list.c
	gcc param_list.c -c -o param_list.o -Wall

decl.o: decl.h decl.c
	gcc decl.c -c -o decl.o -Wall

type.o: type.h type.c
	gcc type.c -c -o type.o -Wall

print_test: bminor
	./tests/printer/run_all_tests.sh
	./tests_self/printer/run_all_tests.sh

###########
# Resolve #
###########

symbol.o: symbol.h symbol.c
	gcc symbol.c -c -o symbol.o -Wall

scope.o: scope.c scope.h
	gcc scope.c -c -o scope.o -Wall

hash_table.o: hash_table.c hash_table.h
	gcc hash_table.c -c -o hash_table.o -Wall

resolve_test: bminor
	./tests/typecheck/run_good_tests.sh 
	./tests_self/typecheck/run_good_tests.sh

#############
# typecheck #
#############

typecheck_test: bminor
	./tests/typecheck/run_all_tests.sh 
	./tests_self/typecheck/run_all_tests.sh

clean:
# scanner
	rm -rf lex.yy.c lex.yy.o
	rm -rf tests/scanner/*.out tests_self/scanner/*.out
# parser
	rm -rf parser.c parser.o token.h parser.output
	rm -rf tests/parser/*.out tests_self/parser/*.out
# main/helper
	rm -rf main.o bminor_helper.o
# AST
	rm -rf decl.o type.o stmt.o param_list.o expr.o symbol.o scope.o hash_table.o
	rm -rf tests/printer/*.out tests_self/printer/*.out
	rm -rf tests/typecheck/*.out tests_self/typecheck/*out
# bminor
	rm -rf bminor