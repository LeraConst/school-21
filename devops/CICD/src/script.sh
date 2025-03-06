#!/bin/bash
scp cat/s21_cat grep/s21_grep margartccd@192.168.56.3:/usr/local/bin
if [ $? -ne 0 ]; then 
  echo "Fail"
  exit 1 
else
  echo "Succes"
  exit 0
fi