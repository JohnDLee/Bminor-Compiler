#!/bin/sh

for testfile in tests/printer/good*.bminor
do
	if ./bminor -print $testfile > $testfile.1.out
	then
		if ./bminor -print $testfile.1.out > $testfile.2.out
		then
			if diff $testfile.1.out $testfile.2.out > $testfile.diff.out
			then 
				echo "$testfile success (as expected)"
			else
				echo "$testfile difference found (INCORRECT)"
			fi
		else
			echo "$testfile failure to parse output (INCORRECT)"
		fi
	else
		echo "$testfile failure to parse initial (INCORRECT)"
	fi
done

for testfile in tests/printer/bad*.bminor
do
	if ./bminor -print $testfile > $testfile.out
	then
		echo "$testfile success (INCORRECT)"
	else
		echo "$testfile failure (as expected)"
	fi
done
