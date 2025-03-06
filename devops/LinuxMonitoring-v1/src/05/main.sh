#!/bin/bash

source check.sh

start_time=$(date +%s)

# Общее количество папок (включая вложенные)
total_folders=$(find "$directory_path" -type d | wc -l)

# Топ 5 папок с самым большим весом в порядке убывания (путь и размер)
top_folders=$(du -h --max-depth=1 "$directory_path" | sort -rh | head -n 6 | sed '1d')
top_folders_output=""
count=0
while read -r line; do
    folder_size=$(echo "$line" | awk '{print $1}')
    folder_path=$(echo "$line" | awk '{$1=""; print $0}' | sed 's/^[ \t]*//')
    ((count++))
    relative_path="${folder_path#$directory_path}"
    top_folders_output+="$count - $relative_path, $folder_size"$'\n'
done <<< "$top_folders"

# Выводим "etc up to 5" для случая, когда папок меньше 5
if [ $count -lt 5 ]; then
    top_folders_output+="etc up to 5"$'\n'
fi

# Общее количество файлов
total_files=$(find "$directory_path" -type f | wc -l)

# Количество различных типов файлов
config_files=$(find "$directory_path" -type f -name "*.conf" | wc -l)
text_files=$(find "$directory_path" -type f -exec file {} \; | grep -i 'text' | wc -l)
executable_files=$(find "$directory_path" -type f -executable | wc -l)
log_files=$(find "$directory_path" -type f -name "*.log" | wc -l)
archive_files=$(find "$directory_path" -type f \( -name "*.tar" -o -name "*.zip" \) | wc -l)
symbolic_links=$(find "$directory_path" -type l | wc -l)

# Топ 10 файлов с самым большим весом в порядке убывания (путь, размер и тип)
top_files=$(find "$directory_path" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 11 | sed '1d')
top_files_output=""
count=0
while read -r line; do
    file_size=$(echo "$line" | awk '{print $1}')
    file_path=$(echo "$line" | awk '{$1=""; print $0}' | sed 's/^[ \t]*//')
    file_type=$(file -b --mime-type "$file_path")
    ((count++))
    relative_path="${file_path#$directory_path}"
    top_files_output+="$count - $relative_path, $file_size, $file_type"$'\n'
done <<< "$top_files"

# Выводим "etc up to 10" для случая, когда файлов меньше 10
if [ $count -lt 10 ]; then
    top_files_output+="etc up to 10"$'\n'
fi

# Топ 10 исполняемых файлов с самым большим весом в порядке убывания (путь, размер и MD5 hash)
top_executable_files=$(find "$directory_path" -type f -executable -exec du -h {} + 2>/dev/null | sort -rh | head -n 11 | sed '1d')
top_executable_files_output=""
count=0
while read -r line; do
    executable_file_size=$(echo "$line" | awk '{print $1}')
    executable_file_path=$(echo "$line" | awk '{$1=""; print $0}' | sed 's/^[ \t]*//')
    md5_hash=$(md5sum "$executable_file_path" 2>/dev/null | awk '{print $1}')
    ((count++))
    relative_path="${executable_file_path#$directory_path}"
    top_executable_files_output+="$count - $relative_path, $executable_file_size, $md5_hash"$'\n'
done <<< "$top_executable_files"

# Выводим "etc up to 10" для случая, когда файлов меньше 10
if [ $count -lt 10 ]; then
    top_executable_files_output+="etc up to 10"$'\n'
fi

# Время выполнения скрипта
end_time=$(date +%s)
execution_time=$(echo "scale=2; ($end_time - $start_time)" | bc)

source output.sh
