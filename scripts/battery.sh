#!/system/xbin/bash

CPU=/sys/devices/system/cpu

for i in 1 2 3
do
    echo 1 > $CPU/cpu$i/online
done

for n_cores in 4 3 2 1
do
  for freq in `cat $CPU/cpu0/cpufreq/scaling_available_frequencies`
  do
     for i in 0 1 2 3
     do
        echo 500000 > $CPU/cpu$i/cpufreq/scaling_min_freq
        echo 2333000 > $CPU/cpu$i/cpufreq/scaling_max_freq
        echo $freq > $CPU/cpu$i/cpufreq/scaling_min_freq
        echo $freq > $CPU/cpu$i/cpufreq/scaling_max_freq
     done 2> /dev/null
     sleep 30
     echo -n $n_cores $freq $mA >> /sdcard/output
     sum=0
     n=0
     for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
     do
        this=`cat /sys/class/power_supply/battery/current_now`
	sum=`expr $sum + $this`
	n=`expr $n + 1`
        sleep 1
     done
     mA_raw=`expr $sum / $n`
     mA=`expr 500000 - $mA_raw`
     echo $n_cores $freq $mA >> /sdcard/output
     echo $n_cores $freq $mA
  done
  echo 0 > $CPU/cpu`expr $n_cores - 1`/online
done
