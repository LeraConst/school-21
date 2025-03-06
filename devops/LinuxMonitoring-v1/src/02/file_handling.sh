#!/bin/bash
source information.sh

# Предложение записи данных в файл
read -p "Хотите записать данные в файл? (Yy/Nn): " choice

if [[ $choice == [Yy] ]]; then
  # Формируем имя файла
  filename=$(date "+%d_%m_%y_%H_%M_%S.status")
  # Записываем данные в файл
  echo -e "HOSTNAME = $(get_hostname)\nTIMEZONE = $(get_timezone)\nUSER = $(get_user)\nOS = $(get_os_info)\nDATE = $(get_date)\nUPTIME = $(get_uptime)\nUPTIME_SEC = $(get_uptime_sec)\nIP = $(get_ip)\nMASK = $(get_mask)\nGATEWAY = $(get_gateway)\nRAM_TOTAL = $(get_ram_total) GB\nRAM_USED = $(get_ram_used) GB\nRAM_FREE = $(get_ram_free) GB\nSPACE_ROOT = $(get_space_root) MB\nSPACE_ROOT_USED = $(get_space_root_used) MB\nSPACE_ROOT_FREE = $(get_space_root_free) MB" > $filename
  echo "Данные сохранены в файл: $filename"
else echo "Данные не сохранены"
fi
