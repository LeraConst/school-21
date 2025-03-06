#!/bin/bash

if [ $# -ge 1 ]
then
    echo "Ошибка: Не ожидаются и не заданы параметры $#"
else
    co=color.conf
    if [ -e $co ] 
    then
        source color.conf
        export L_bckgrnd_clr=$column1_background
        export L_txt_clr=$column1_font_color
        export R_bckgrnd_clr=$column2_background
        export R_txt_clr=$column2_font_color

        if [[ $L_bckgrnd_clr = "" ]]; then
            L_bckgrnd_clr=6 ; column1_background="default"
        fi
        if [[ $L_txt_clr = "" ]]; then
            L_txt_clr=1 ; column1_font_color="default"
        fi
        if [[ $R_bckgrnd_clr = "" ]]; then
            R_bckgrnd_clr=2 ; column2_background="default"
        fi
        if [[ $R_txt_clr = "" ]]; then
            R_txt_clr=4 ; column2_font_color="default"
        fi
        flag=1
        if [ $L_bckgrnd_clr -eq $L_txt_clr ]; then
            flag=0
        elif [ $R_bckgrnd_clr -eq $R_txt_clr ]; then
            flag=0
        fi
        if [ $flag -eq 1 ]; then
            source get_color.sh
            if [ $Err -eq 1 ]; then
                source information.sh
                source output.sh
            else
                echo "Неверное значение параметра в файле color.cnf: параметры должны быть числами в диапазоне 1-6"
            fi
        else
            echo "Неверное значение параметра в файле color.cnf: Параметры column1_background и column1_font_color не должны быть равны. Также параметры column2_background и column2_font_color не должны быть равны. Введите другие значения параметров"
        fi
    else
        echo "Файл $co не существует"
    fi    
fi
