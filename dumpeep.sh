#!/bin/bash

max=18416
for ((i=16384;i<=max;))

do
  y=$(printf "%#.4x\n" $i)
let "i+=32"


sudo i2cset -y 1 0x0b 0x09 $y w
sleep 0.01
r=$(sudo i2ctransfer -y 1 w1@0x0b 0x0c r33)
echo $r | cut -c6-
sleep 0.01
done
