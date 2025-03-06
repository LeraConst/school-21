#!/bin/bash

# Проверяем существование директории, иначе создаем ее
mkdir -p /usr/share/nginx/html/

while true
do
    # Получаем информацию о ЦПУ
    cpu_info=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')

    # Получаем информацию об оперативной памяти
    mem_info=$(free -m | awk 'NR==2{print $3}')

    # Получаем информацию о жестком диске
    disk_info=$(df -h / | awk 'NR==2{print $4}')

    # Создаем HTML-страницу
    cat << EOF > /usr/share/nginx/html/metrics.html
# HELP cpu_usage CPU usage in percentage
# TYPE cpu_usage gauge
cpu_usage $cpu_info

# HELP memory_usage Memory usage in megabytes
# TYPE memory_usage gauge
memory_usage $mem_info

# HELP disk_usage Disk usage in gigabytes
# TYPE disk_usage gauge
disk_usage $disk_info
EOF

    # Ждем 3 секунды перед обновлением
    sleep 3
done

