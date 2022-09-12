# Author: John Lee
# Date: 9/8/2022
# Purpose: Makefile to compile B-Minor Compiler

# compile all
all: bminor


###########
# Scanner #
###########

# create lex.y.c
scanner/lex.yy.c: scanner/scanner.flex
	flex -o scanner/lex.yy.c scanner/scanner.flex

# compile/link main and lex.y.cc
bminor: scanner/lex.yy.o scanner/main.o scanner/token.h
	gcc scanner/lex.yy.o scanner/main.o -o bminor

scanner/main.o: scanner/main.c scanner/token.h
	gcc scanner/main.c -c -o scanner/main.o

scanner/lex.yy.o: scanner/lex.yy.c scanner/token.h
	gcc scanner/lex.yy.c -c -o scanner/lex.yy.o

scan_test: bminor
	./tests/scanner/run_all_tests.sh
	./tests_self/scanner/run_all_tests.sh





clean:
	rm -rf scanner/lex.yy.c scanner/main.o scanner/lex.yy.o bminor
	rm -rf tests/scanner/*.out tests_self/scanner/*.out