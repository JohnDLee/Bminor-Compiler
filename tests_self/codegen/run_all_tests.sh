#!/bin/sh

gcc tests_self/codegen/library.c -c -o tests_self/codegen/library.o -Wall

for testfile in tests_self/codegen/good*.bminor
do
	if ./bminor -codegen $testfile $testfile.s > $testfile.out
	then
		gcc $testfile.s library.o -o $testfile.exe
		./$testfile.exe >> $testfile.out
		echo "$testfile success (as expected), output = $?"
	else
		echo "$testfile failure (INCORRECT)"
	fi
done
