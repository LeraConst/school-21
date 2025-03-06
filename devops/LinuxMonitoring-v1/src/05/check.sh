# check.sh

# Проверка введен ли параметр
if [ $# -ne 1 ]; then
    echo "Использование: $0 <путь к каталогу>"
    exit 1
fi

directory_path="$1"

# Проверка наличия директории
if [ ! -d "$directory_path" ]; then
    echo "Ошибка: Указанный путь не является каталогом"
    exit 1
fi
