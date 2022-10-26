# Author: John Lee
# Date: 9/8/2022
# Purpose: Makefile to compile B-Minor Compiler

# compile/link all
bminor: lex.yy.o main.o bminor_helper.o parser.o token.h ast.o
	gcc lex.yy.o main.o bminor_helper.o ast.o parser.o -o bminor

########
# Main #
########
main.o: main.c token.h
	gcc main.c -c -o main.o

bminor_helper.o: bminor_helper.c bminor_helper.h
	gcc bminor_helper.c -c -o bminor_helper.o

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
ast.o: ast.c expr.h stmt.h type.h param_list.h symbol.h decl.h
	gcc ast.c -c -o ast.o

print_test: bminor
	./tests/printer/run_all_tests.sh
	./tests_self/printer/run_all_tests.sh

clean:
	rm -rf lex.yy.c lex.yy.o
	rm -rf tests/scanner/*.out tests_self/scanner/*.out
	rm -rf parser.c parser.o token.h parser.output
	rm -rf tests/parser/*.out tests_self/parser/*.out
	rm -rf main.o bminor_helper.o
	rm -rf ast.o
	rm -rf tests/printer/*.out tests_self/printer/*.out
	rm -rf bminor