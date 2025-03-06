#!/bin/bash

source check.sh

check_valid_params "$@"

source information.sh

source output.sh

print_colored_text "HOSTNAME = $(get_hostname)" "$1" "$2" "$3" "$4"
print_colored_text "TIMEZONE = $(get_timezone)" "$1" "$2" "$3" "$4"
print_colored_text "USER = $(get_user)" "$1" "$2" "$3" "$4"
print_colored_text "OS = $(get_os_info)" "$1" "$2" "$3" "$4"
print_colored_text "DATE = $(get_date)" "$1" "$2" "$3" "$4"
print_colored_text "UPTIME = $(get_uptime)" "$1" "$2" "$3" "$4"
print_colored_text "UPTIME_SEC = $(get_uptime_sec)" "$1" "$2" "$3" "$4"
print_colored_text "IP = $(get_ip)" "$1" "$2" "$3" "$4"
print_colored_text "MASK = $(get_mask)" "$1" "$2" "$3" "$4"
print_colored_text "GATEWAY = $(get_gateway)" "$1" "$2" "$3" "$4"
print_colored_text "RAM_TOTAL = $(get_ram_total) GB" "$1" "$2" "$3" "$4"
print_colored_text "RAM_USED = $(get_ram_used) GB" "$1" "$2" "$3" "$4"
print_colored_text "RAM_FREE = $(get_ram_free) GB" "$1" "$2" "$3" "$4"
print_colored_text "SPACE_ROOT = $(get_space_root) MB" "$1" "$2" "$3" "$4"
print_colored_text "SPACE_ROOT_USED = $(get_space_root_used) MB" "$1" "$2" "$3" "$4"
print_colored_text "SPACE_ROOT_FREE = $(get_space_root_free) MB" "$1" "$2" "$3" "$4"
