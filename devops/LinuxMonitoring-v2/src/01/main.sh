#!/bin/bash

if [ "$#" -ne 6 ]; then
  echo "Usage: $0 <absolute_path> <num_nested_folders> <folder_name_letters> <num_nested_file> <file_name_letters> <file_size_kb>"
  exit 1
fi

absolute_path=$1
num_nested_folders=$2
folder_name_letters=$3
num_nested_file=$4
file_name_letters=$5
file_size_kb=$6

current_date=$(date +"%d%m%y")

# Проверяем валидность числа вложенных папок в параметре 2
if [[ ! "$num_nested_folders" =~ ^[0-9]+$ ]]; then
  echo "С кол-вом папок что-то не то!"
  exit 1
fi

# Проверяем валидность букв в параметре 3
if [[ ! "$folder_name_letters" =~ ^[a-zA-Z]{1,7}$ ]]; then
  echo "Вводишь че-то не то в названии папки!"
  exit 1
fi

# Проверяем валидность числа вложенных папок в параметре 4
if [[ ! "$num_nested_file" =~ ^[0-9]+$ ]]; then
  echo "С кол-вом файлов что-то не то!"
  exit 1
fi

# Проверяем валидность букв в параметре 5
if [[ ! "$file_name_letters" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
  echo "Вводишь че-то не то в названии файла!"
  exit 1
fi

# Проверяем, что после размера файла стоит kb в параметре 6
file_size_second_to_last_char=${file_size_kb: -2:1}
file_size_last_char=${file_size_kb: -1}

if [ "$file_size_second_to_last_char" = "k" ] && [ "$file_size_last_char" = "b" ]; then
  file_size="${file_size_kb%k*}"
else
  echo "Вводишь не тот тип веса!"
  exit 1
fi

# Проверяем валидность размера файла в параметре 6 (не более 100 кб)
if [ "$file_size" -gt 100 ]; then
  echo "Вводишь не тот вес!"
  exit 1
fi

# Проверяем, существует ли указанный путь в параметре 1
if [ ! -d "$absolute_path" ]; then
  mkdir -p "$absolute_path"
fi

# Находим первый и последний символ папки
first_char_folder=${folder_name_letters:0:1}
last_char_folder=${folder_name_letters: -1}
folder_name_last=${folder_name_letters}

# Делим имя файла на имя и расшиение находим ласт и первый символ
file_name_only="${file_name_letters%.*}"
file_name_extension="${file_name_letters##*.}"
last_char_name=${file_name_only: -1}
first_char_name=${file_name_only:0:1}

# Проверка на 4 знака
# Для папки
length_folder=${#folder_name_letters}
if [ "$length_folder" -lt 4 ]; then
lenght_folder_last=$((4 - ${#folder_name_letters}))
  for ((k=1; k<=$lenght_folder_last; k++)); do
    if [ $((k % 2)) -eq 0 ]; then
    folder_name_last=${folder_name_last}${last_char_folder}
      else
    folder_name_last=${first_char_folder}${folder_name_last}
    fi
  done   
fi

# Для файла
lenght_name=${#file_name_only}
if [ "$lenght_name" -lt 4 ]; then
lenght_name_last=$((4 - ${#file_name_only}))
  for ((n=1; n<=$lenght_name_last; n++)); do
    if [ $((j % 2)) -eq 0 ]; then
      file_name_only=${file_name_only}${last_char_name}
    else
      file_name_only=${first_char_name}${file_name_only}
    fi
  done   
fi

# Основной цикл. Добавим создание вложенных папок и файлов в них
for ((i=1; i<=num_nested_folders; i++)); do
  # Проверка свободного места
  free_space=$(df -h / | awk 'NR==2 {print $4}')

  # Проверка свободного места, если меньше 1 ГБ, то выходим из цикла
  if [ "${free_space%"G"}" -lt 1 ]; then
    echo "Место закончилось."
    break
  fi

  # Работа с папкой - добавляем последний символ
  nested_folder="${absolute_path}/${folder_name_last}_${current_date}"
  mkdir -p "$nested_folder"
  
  echo "$nested_folder $(date)" >> "$(dirname "$0")/log.txt"
  
  if [ $((i % 2)) -eq 0 ]; then
    folder_name_last=${folder_name_last}${last_char_folder}
  else
    folder_name_last=${first_char_folder}${folder_name_last}
  fi
  
  # Добавим создание файлов
  for ((j=1; j<=num_nested_file; j++)); do
  
    # Проверка свободного места
    free_space=$(df -h / | awk 'NR==2 {print $4}')

    # Проверка свободного места, если меньше 1 ГБ, то выходим из цикла
    if [ "${free_space%"G"}" -lt 1 ]; then
      break
    fi
  
    nested_file_name="${nested_folder}/${file_name_only}_${current_date}.${file_name_extension}"
    
    # Файл имеет вес, а ты?
    dd if=/dev/zero of="$nested_file_name" bs=1024 count="$file_size" &>/dev/null
    
    # Запись в лог
    echo "$nested_file_name $(date) ${file_size}KB" >> "$(dirname "$0")/log.txt"
    
    if [ $((j % 2)) -eq 0 ]; then
      file_name_only=${file_name_only}${last_char_name}
    else
      file_name_only=${first_char_name}${file_name_only}
    fi
    
  done
  
  file_name_only="${file_name_letters%.*}"

done

echo "Все работает, ставь 5!"



