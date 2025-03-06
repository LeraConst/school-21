#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <folder_name_letters> <file_name_letters> <file_size_mb>"
  exit 1
fi

folder_name_letters=$1
file_name_letters=$2
file_size_mb=$3

current_date=$(date +"%d%m%y")

# Проверяем валидность букв в параметре 1
if [[ ! "$folder_name_letters" =~ ^[a-zA-Z]{1,7}$ ]]; then
  echo "Вводишь че-то не то в названии папки!"
  exit 1
fi

# Проверяем валидность букв в параметре 2
if [[ ! "$file_name_letters" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
  echo "Вводишь че-то не то в названии файла!"
  exit 1
fi

# Проверяем, что после размера файла стоит Mb в параметре 3
file_size_second_to_last_char=${file_size_mb: -2:1}
file_size_last_char=${file_size_mb: -1}

if [ "$file_size_second_to_last_char" = "M" ] && [ "$file_size_last_char" = "b" ]; then
  file_size="${file_size_mb%M*}"
else
  echo "Вводишь не тот тип веса!"
  exit 1
fi

# Проверяем валидность размера файла в параметре 3 (не более 100 кб)
if [ "$file_size" -gt 100 ]; then
  echo "Вводишь не тот вес!"
  exit 1
fi

# Если все проверки прошлись успешно, выводим время начала работы скрипта
start_time=$(date +"%Y-%m-%d %H:%M:%S")

echo "Скрипт начал свою работу в: $start_time"


# Находим первый и последний символ папки
first_char_folder=${folder_name_letters:0:1}
last_char_folder=${folder_name_letters: -1}
folder_name_last=${folder_name_letters}


# Делим имя файла на имя и расшиение находим ласт и первый символ
file_name_only="${file_name_letters%.*}"
file_name_extension="${file_name_letters##*.}"
last_char_name=${file_name_only: -1}
first_char_name=${file_name_only:0:1}


# Проверка на 5 знаков
# Для папки
length_folder=${#folder_name_letters}
if [ "$length_folder" -lt 5 ]; then
lenght_folder_last=$((5 - ${#folder_name_letters}))
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
if [ "$lenght_name" -lt 5 ]; then
lenght_name_last=$((5 - ${#file_name_only}))
  for ((n=1; n<=$lenght_name_last; n++)); do
    if [ $((n % 2)) -eq 0 ]; then
      file_name_only=${file_name_only}${last_char_name}
    else
      file_name_only=${first_char_name}${file_name_only}
    fi
  done   
fi


while true
do
free_space=$(df -h / | awk 'NR==2 {print $4}')

# Проверка свободного места, если меньше 1 ГБ, то выходим из цикла. Это финал работы скрипта
if [ "${free_space%"G"}" -lt 41 ]; then
  # Записываем время окончания работы скрипта
  end_time=$(date +"%Y-%m-%d %H:%M:%S")

  echo "Скрипт завершил свою работу в: $end_time"
  
  # Вычисляем общее время работы
  start_seconds=$(date -d "$start_time" +%s)
  end_seconds=$(date -d "$end_time" +%s)
  total_seconds=$((end_seconds - start_seconds))

  # Выводим общее время работы
  echo "Общее время работы скрипта: $((total_seconds / 3600)) часов $(((total_seconds % 3600) / 60)) минут $((total_seconds % 60)) секунд"
  
  echo "Скрипт начал свою работу в: $start_time" >> "$(dirname "$0")/log.txt"
  echo "Скрипт завершил свою работу в: $end_time" >> "$(dirname "$0")/log.txt"
  echo "Общее время работы скрипта: $((total_seconds / 3600)) часов $(((total_seconds % 3600) / 60)) минут $((total_seconds % 60)) секунд" >> "$(dirname "$0")/log.txt"
  break
fi

# Получаем список всех директорий в файловой системе, исключая те, которые содержат "bin" и "sbin"
directories=($(find / -type d 2>/dev/null | grep -Ev '/(bin|sbin)/'))

# Выбираем случайную директорию
random_directory=${directories[$RANDOM % ${#directories[@]}]}

# Основной цикл. Добавим создание вложенных папок(для папок условие не больше 100 и не говорится задавать их кол-во рандомно) и файлов в них
  for ((i=1; i<=50; i++)); do
    # Проверка свободного места
    free_space=$(df -h / | awk 'NR==2 {print $4}')

    # Проверка свободного места, если меньше 1 ГБ, то выходим из цикла
    if [ "${free_space%"G"}" -lt 41 ]; then
      break
    fi
    
    while [ ! -w "$random_directory" ]; do
      random_directory=${directories[$RANDOM % ${#directories[@]}]}
    done

    # Работа с папкой - добавляем последний символ
    nested_folder="${random_directory}/${folder_name_last}_${current_date}"
    mkdir -p "$nested_folder"
  
    echo "$nested_folder $(date)" >> "$(dirname "$0")/log.txt"
  
    if [ $((i % 2)) -eq 0 ]; then
      folder_name_last=${folder_name_last}${last_char_folder}
    else
      folder_name_last=${first_char_folder}${folder_name_last}
    fi
    
    # Содаем рандом кол-во файлов. Решил ограничиться 100
    random_number_file=$((RANDOM % 100 + 1))
    
    # Добавим создание файлов
    for ((j=1; j<=random_number_file; j++)); do
  
      # Проверка свободного места
      free_space=$(df -h / | awk 'NR==2 {print $4}')

      # Проверка свободного места, если меньше 1 ГБ, то выходим из цикла
      if [ "${free_space%"G"}" -lt 41 ]; then
        break
      fi
  
      nested_file_name="${nested_folder}/${file_name_only}_${current_date}.${file_name_extension}"
    
      # Файл имеет вес, а ты?
      dd if=/dev/zero of="$nested_file_name" bs=1M count="$file_size" &>/dev/null
    
      #   Запись в лог
      echo "$nested_file_name $(date) ${file_size}MB" >> "$(dirname "$0")/log.txt"
    
      if [ $((j % 2)) -eq 0 ]; then
        file_name_only=${file_name_only}${last_char_name}
      else
        file_name_only=${first_char_name}${file_name_only}
      fi
    
    done
  
    file_name_only="${file_name_letters%.*}"

  done
  
done

echo "Все работает, ставь 5!"


