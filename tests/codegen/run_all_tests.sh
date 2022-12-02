#!/bin/sh

gcc tests/codegen/library.c -c -o tests/codegen/library.o -Wall

for testfile in tests/codegen/good*.bminor
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
