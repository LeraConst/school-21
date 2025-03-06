#!/bin/bash

COUNTER_SUCCESS=0
COUNTER_FAIL=0
DIFF_RES=""
# TEST_FILE="test_file.txt"
echo "" > log.txt

for var in -e -i -c -n -v -l -h -o -s
do
    for var2 in 'wide' 'as' 'other' 'computer' 'r' 'q' 'w' 'order' 'a' 'w' ',' '-'
    do
        for var3 in "test_1_grep.txt" "test_2_grep.txt" "test_3_grep.txt" "test_1_grep.txt test_2_grep.txt" "test_1_grep.txt test_3_grep.txt" "test_2_grep.txt test_3_grep.txt" "test_1_grep.txt test_2_grep.txt test_3_grep.txt"
        do
            TEST1="$var $var2 $var3"
            echo "$TEST1"
            ./s21_grep $TEST1 > s21_grep.txt
            grep $TEST1 > grep.txt
            DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
            if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
            then
                (( COUNTER_SUCCESS++ ))
                echo " \033[32mSUCCESS: $COUNTER_SUCCESS\033[0m"
            else
                echo "$TEST1" >> log.txt
                (( COUNTER_FAIL++ ))
                echo "\033[31mFAIL: $COUNTER_FAIL\033[0m"
            fi
        done
    done
done
rm s21_grep.txt grep.txt log.txt

echo "\033[32mSUCCESS: $COUNTER_SUCCESS\033[0m"
echo "\033[31mFAIL: $COUNTER_FAIL\033[0m"

if [ $? -ne 0 ]; then 
  exit 1
fi
