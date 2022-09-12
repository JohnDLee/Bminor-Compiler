#!/bin/sh

for testfile in tests_self/scanner/good*.bminor
do
	if ./bminor -scan $testfile > $testfile.out
	then
		echo "$testfile success (as expected)"
	else
		echo "$testfile failure (INCORRECT)"
	fi
done

for testfile in tests_self/scanner/bad*.bminor
do
	if ./bminor -scan $testfile > $testfile.out
	then
		echo "$testfile success (INCORRECT)"
	else
		echo "$testfile failure (as expected)"
	fi
done
