#!/bin/bash

output=$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu --format=csv,noheader,nounits)
output2=$(nvidia-smi dmon -s=c -c=1 --format=csv,nounit,noheader)

temperature=$(echo "$output" | awk -F', ' '{print $1}')
busypercent=$(echo "$output" | awk -F', ' '{print $2}')
memclock=$(echo "$output2" | awk -F', ' '{print $2}')
mclk_ghz=$(echo "scale=2; $memclock/10000" | bc)
pcsclock=$(echo "$output2" | awk -F', ' '{print $3}')
pclk_ghz=$(echo "scale=2; $pcsclock/10000" | bc)

echo '{"text": "   0'$pclk_ghz'GHz <span color=\"darkgray\">| '$busypercent'%</span>", "class": "custom-gpu", "tooltip": " '$temperature'°C | '$mclk_ghz'"}'

