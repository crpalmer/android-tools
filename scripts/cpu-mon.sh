#!/system/xbin/bash

cpus=`ls -d /sys/devices/system/cpu/cpu* | sort`
while true
do
    speed=""
    for i in $cpus
    do
        this_speed=`cat $i/cpufreq/scaling_cur_freq 2> /dev/null || echo 'offline'`
	speed="$speed $this_speed"
    done
    echo "$speed"
    sleep 1
done
