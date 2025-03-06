#!/bin/bash

# Функция для генерации случайного IP-адреса
generate_ip() {
  echo "$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
}

# Функция для генерации случайного кода ответа
generate_status_code() {
  codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
  echo "${codes[RANDOM % ${#codes[@]}]}"
}

# Функция для генерации случайного метода
generate_method() {
  methods=("GET" "POST" "PUT" "PATCH" "DELETE")
  echo "${methods[RANDOM % ${#methods[@]}]}"
}

# Функция для генерации случайной даты в формате "день/месяц/год час:минута:секунда"
generate_date() {
  day=$(printf "%02d" $((RANDOM % 28 + 1)))  # Ограничим дни до 28 для простоты
  #month=$(printf "%02d" $((RANDOM % 12 + 1)))
  month="dec"
  year="2023"
  echo "$day/$month/$year"
}

#generate_time() {
#  hour=$(printf "%02d" $((RANDOM % 24)))
#  minute=$(printf "%02d" $((RANDOM % 60)))
#  second=$(printf "%02d" $((RANDOM % 60)))
#  echo "$hour:$minute:$second"
#}

# Функция для генерации случайного URL запроса агента
generate_url() {
  urls=("https://example.com/page1" "https://example.com/page2" "https://example.com/page3")
  echo "${urls[RANDOM % ${#urls[@]}]}"
}

# Функция для генерации случайного агента
generate_user_agent() {
  agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
  echo "${agents[RANDOM % ${#agents[@]}]}"
}

# Функция для генерации случайного лога за день
generate_daily_log() {
  date_only=$(generate_date)
  start_time="00:00:00"
  for ((i = 0; i < RANDOM % 901 + 100; i++)); do
    ip=$(generate_ip)
    status_code=$(generate_status_code)
    method=$(generate_method)
    time="$start_time"
    url=$(generate_url)
    user_agent=$(generate_user_agent)

    echo "$ip - - [$date_only:$start_time +0300] \"$method $url\" $status_code - - \"$user_agent\""
    start_time=$(date -u -d "1970-01-01 $start_time UTC +30 second" "+%H:%M:%S") 
  done
}

# Создаем 5 файлов логов
for ((day = 1; day <= 5; day++)); do
  log_file="nginx_log_day${day}.log"
  generate_daily_log >"$log_file"
  echo "Generated $log_file"
done

#Коды ответа:

#200: OK
#201: Created
#400: Bad Request
#401: Unauthorized
#403: Forbidden
#404: Not Found
#500: Internal Server Error
#501: Not Implemented
#502: Bad Gateway
#503: Service Unavailable

