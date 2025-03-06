#!/bin/bash

source validator.sh
source printer.sh

if [ $# -ne 1 ]; then
    echo "Ошибка: Пожалуйста, введите значение параметра."
    exit 1
fi

param=$1

validate_input $param

print_value $param
