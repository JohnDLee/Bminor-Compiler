# Author: John Lee
# Date: 9/8/2022
# Purpose: Makefile to compile B-Minor Compiler

# compile/link all
bminor: scanner/lex.yy.o main.o bminor_helper.o parser/parser.o parser/token.h # change token.h to the one developed by bison
	gcc scanner/lex.yy.o main.o bminor_helper.o parser/parser.o -o bminor

########
# Main #
########
main.o: main.c parser/token.h
	gcc main.c -c -o main.o

bminor_helper.o: bminor_helper.c bminor_helper.h
	gcc bminor_helper.c -c -o bminor_helper.o

###########
# Scanner #
###########

# create lex.y.c
scanner/lex.yy.c: scanner/scanner.flex
	flex -o scanner/lex.yy.c scanner/scanner.flex

scanner/lex.yy.o: scanner/lex.yy.c parser/token.h
	gcc scanner/lex.yy.c -c -o scanner/lex.yy.o

scan_test: bminor
	./tests/scanner/run_all_tests.sh
	./tests_self/scanner/run_all_tests.sh


##########
# Parser #
##########

parser/parser.c parser/token.h: parser/parser.bison
	bison -o parser/parser.c parser/parser.bison --defines=parser/token.h -v --debug

parser/parser.o: parser/parser.c
	gcc parser/parser.c -c -o parser/parser.o

parser_test: bminor
	./tests/parser/run_all_tests.sh
	./tests_self/parser/run_all_tests.sh


clean:
	rm -rf scanner/lex.yy.c scanner/lex.yy.o
	rm -rf tests/scanner/*.out tests_self/scanner/*.out
	rm -rf parser/parser.c parser/parser.o
	rm -rf tests/parser/*.out tests_self/parser/*.out
	rm -rf main.o bminor_helper.o
	rm -rf bminor