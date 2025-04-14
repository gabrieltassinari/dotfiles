#!/bin/sh

if [ -z $1 ]; then
    echo "night.sh [NUMBER]"
    exit 1
fi

bright=`echo "scale=2; $1/10" | bc`
monitors=`xrandr --listmonitors | awk 'NR>1 {print $4}'`

for monitor in $monitors
do
	xrandr --output $monitor --brightness $bright
done
