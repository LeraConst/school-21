#!/bin/bash

SUCCESS=0
FAIL=0
COUNTER=0
DIFF_RES=""
s21_cat=(".././s21_cat")

declare -a tests=(
"VAR test_1_cat.txt"
"VAR test_2_cat.txt"
"VAR test_3_cat.txt"
"VAR test_4_cat.txt"
"VAR test_1_cat.txt test_2_cat.txt"
"VAR test_1_cat.txt test_2_cat.txt test_3_cat.txt"
"VAR test_1_cat.txt test_2_cat.txt test_3_cat.txt test_4_cat.txt"
"VAR test_1_cat.txt test_2_cat.txt test_3_cat.txt test_4_cat.txt test_5_cat.txt"
"VAR test_1_cat.txt test_3_cat.txt test_4_cat.txt"
"VAR test_1_cat.txt test_2_cat.txt test_4_cat.txt"
"VAR test_3_cat.txt test_4_cat.txt"
"VAR test_2_cat.txt test_4_cat.txt"
"VAR test_2_cat.txt test_3_cat.txt test_4_cat.txt"
"VAR test_2_cat.txt test_3_cat.txt"
"VAR test_1_cat.txt test_2_cat.txt test_4_cat.txt test_5_cat.txt"
"VAR test_3_cat.txt test_4_cat.txt test_5_cat.txt"
"VAR test_2_cat.txt test_4_cat.txt test_5_cat.txt"
"VAR test_2_cat.txt test_3_cat.txt test_4_cat.txt test_5_cat.txt"
"VAR test_2_cat.txt test_3_cat.txt test_5_cat.txt"
"VAR test_2_cat.txt test_5_cat.txt"
"VAR test_3_cat.txt test_5_cat.txt"
"VAR test_4_cat.txt test_5_cat.txt"
)

declare -a extra=(
"no_file.txt"
"test_1_cat.txt"
"test_2_cat.txt"
"test_3_cat.txt"
"test_4_cat.txt"
)

testing()
{
    t=$(echo $@ | sed "s/VAR/$var/")
    $s21_cat $t > test_s21_cat.log
    cat $t > test_sys_cat.log
    DIFF_RES="$(diff -s test_s21_cat.log test_sys_cat.log)"
    (( COUNTER++ ))
    if [ "$DIFF_RES" == "Files test_s21_cat.log and test_sys_cat.log are identical" ]
    then
      (( SUCCESS++ ))
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[32msuccess\033[0m cat $t"
    else
      (( FAIL++ ))
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[31mfail\033[0m cat $t"
    fi
    rm test_s21_cat.log test_sys_cat.log
}


# 1 параметр
for var1 in b e n s t
do
    for i in "${tests[@]}"
    do
          var="-$var1"
          testing $i
    done
done


echo "\033[31mFAIL: $FAIL\033[0m"
echo "\033[32mSUCCESS: $SUCCESS\033[0m"
echo "ALL: $COUNTER"

