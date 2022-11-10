#!/bin/sh

for testfile in tests/typecheck/good*.bminor
do
	if ./bminor -resolve $testfile > $testfile.out
	then
		echo "$testfile success (as expected)"
	else
		echo "$testfile failure (INCORRECT)"
	fi
done


