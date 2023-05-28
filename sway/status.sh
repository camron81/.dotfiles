bat_status="$(cat /sys/class/power_supply/BAT0/status)"
bat_charge="$(cat /sys/class/power_supply/BAT0/capacity)"

if [ "$bat_status" = "Charging" ]; then
    charging=" "
else
    charging=" "
fi

if [ "$bat_charge" -lt 10 ]; then
    battery=""
elif [ "$bat_charge" -lt 25 ]; then
    battery=""
elif [ "$bat_charge" -lt 50 ]; then
    battery=""
elif [ "$bat_charge" -lt 75 ]; then
    battery=""
else
    battery=""
fi

echo "$charging$battery    $bat_charge%  |  $(date +'%a %d %b %Y  %H:%M')  "
