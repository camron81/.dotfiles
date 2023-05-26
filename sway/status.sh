echo "$(date +'%Y-%m-%d %I:%M:%S %p') \
  $(cat /sys/class/power_supply/BAT0/capacity)% \
  $(cat /sys/class/power_supply/BAT0/status)"
