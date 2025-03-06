# functions.sh

get_hostname() {
  hostname
}

get_timezone() {
  timedatectl | grep "Time zone" | awk '{print $3, $4, $5}'
}

get_user() {
  whoami
}

get_os_info() {
  cat /etc/os-release | grep PRETTY_NAME | cut -d "=" -f 2- | tr -d '"'
}

get_date() {
  date "+%d %b %Y %T"
}

get_uptime() {
  uptime -p | cut -d " " -f 2-
}

get_uptime_sec() {
  cat /proc/uptime | awk '{print $1,"sec"}'
}

get_ip() {
  ip a | grep "inet " | awk '{print $2}' | head -n 1
}

get_mask() {
  ip a | grep "inet " | awk '{print $2}' | cut -d "/" -f 2 | head -n 1
}

get_gateway() {
  ip route | grep default | awk '{print $3}'
}

get_ram_total() {
  free  |  head -2 | tail +2 | awk '{printf("%.3f", $2/(1024*1024))}'
}

get_ram_used() {
  free  |  head -2 | tail +2 | awk '{printf("%.3f", $3/(1024*1024))}'
}

get_ram_free() {
  free  |  head -2 | tail +2 | awk '{printf("%.3f", $4/(1024*1024))}'
}

get_space_root() {
  df / |  head -2 | tail +2 | awk '{printf("%.2f", $2/1024)}'
}

get_space_root_used() {
  df / |  head -2 | tail +2 | awk '{printf("%.2f", $3/1024)}'
}

get_space_root_free() {
  df / |  head -2 | tail +2 | awk '{printf("%.2f", $4/1024)}'
}
