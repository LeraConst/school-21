#!/bin/bash

source information.sh

echo "HOSTNAME = $(get_hostname)"
echo "TIMEZONE = $(get_timezone)"
echo "USER = $(get_user)"
echo "OS = $(get_os_info)"
echo "DATE = $(get_date)"
echo "UPTIME = $(get_uptime)"
echo "UPTIME_SEC = $(get_uptime_sec)"
echo "IP = $(get_ip)"
echo "MASK = $(get_mask)"
echo "GATEWAY = $(get_gateway)"
echo "RAM_TOTAL = $(get_ram_total) GB"
echo "RAM_USED = $(get_ram_used) GB"
echo "RAM_FREE = $(get_ram_free) GB"
echo "SPACE_ROOT = $(get_space_root) MB"
echo "SPACE_ROOT_USED = $(get_space_root_used) MB"
echo "SPACE_ROOT_FREE = $(get_space_root_free) MB"

source file_handling.sh
