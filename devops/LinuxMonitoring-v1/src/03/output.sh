# output.sh

print_colored_text() {
  local text="$1"
  local bg_name_color="$2"
  local font_name_color="$3"
  local bg_value_color="$4"
  local font_value_color="$5"
  
  # Извлекаем название и значение
  local name="${text%%=*}"
  local value="${text#*=}"

if [ "$bg_name_color" == "1" ]; then
  bg_name_color="48;5;15"
elif [ "$bg_name_color" == "2" ]; then
  bg_name_color="41"
elif [ "$bg_name_color" == "3" ]; then
  bg_name_color="42"
elif [ "$bg_name_color" == "4" ]; then
  bg_name_color="44"
elif [ "$bg_name_color" == "5" ]; then
  bg_name_color="45"
elif [ "$bg_name_color" == "6" ]; then
  bg_name_color="40"
elif [ "$bg_name_color" > "6" ] || [ "$bg_name_color" < "1" ]; then
  echo "Ошибка: Введен неверный параметр. Введите 4 числовых параметра через пробел от 1 до 6. Вызовите скрипт повторно"
  exit 1
fi

if [ "$font_name_color" == "1" ]; then
  font_name_color="38;5;15"
elif [ "$font_name_color" == "2" ]; then
  font_name_color="31"
elif [ "$font_name_color" == "3" ]; then
  font_name_color="32"
elif [ "$font_name_color" == "4" ]; then
  font_name_color="34"
elif [ "$font_name_color" == "5" ]; then
  font_name_color="35"
elif [ "$font_name_color" == "6" ]; then
  font_name_color="30"
elif [ "$font_name_color" > "6" ] || [ "$bg_name_color" < "1" ]; then
  echo "Введен неверный параметр. Введите 4 числовых параметра через пробел от 1 до 6. Вызовите скрипт повторно"
  exit 1
fi

if [ "$bg_value_color" == "1" ]; then
  bg_value_color="48;5;15"
elif [ "$bg_value_color" == "2" ]; then
  bg_value_color="41"
elif [ "$bg_value_color" == "3" ]; then
  bg_value_color="42"
elif [ "$bg_value_color" == "4" ]; then
  bg_value_color="44"
elif [ "$bg_value_color" == "5" ]; then
  bg_value_color="45"
elif [ "$bg_value_color" == "6" ]; then
  bg_value_color="40"
elif [ "$bg_value_color" > "6" ] || [ "$bg_value_color" < "1" ]; then
  echo "Введен неверный параметр. Введите 4 числовых параметра через пробел от 1 до 6. Вызовите скрипт повторно"
  exit 1
fi

if [ "$font_value_color" == "1" ]; then
  font_value_color="38;5;15"
elif [ "$font_value_color" == "2" ]; then
  font_value_color="31"
elif [ "$font_value_color" == "3" ]; then
  font_value_color="32"
elif [ "$font_value_color" == "4" ]; then
  font_value_color="34"
elif [ "$font_value_color" == "5" ]; then
  font_value_color="35"
elif [ "$font_value_color" == "6" ]; then
  font_value_color="30"
elif [ "$font_value_color" > "6" ] || [ "$font_value_color" < "1" ]; then
  echo "Введен неверный параметр. Введите 4 числовых параметра через пробел от 1 до 6. Вызовите скрипт повторно"
  exit 1
fi
  
  echo -e "\e[${bg_name_color}m\e[${font_name_color}m$name\e[0m = \e[${bg_value_color}m\e[${font_value_color}m$value\e[0m"
}

