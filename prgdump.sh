#!/bin/bash

max=768
for ((i=0;i<=max;i++))
do
  y=$(printf "%#.4x\n" $i)

if [[ $y == 0000 ]]
then
y=$(echo "0x0000")
fi

a=$(echo $y | cut -c3- | awk ' {gsub(/.{2}/,"& ")}1'| awk ' {print  "0x"$2, "0x"$1}')


sudo i2cset -y 1 0x0b 0x00 $a 0x00 s
sleep 0.01
r=$(sudo i2ctransfer -y 1 w1@0x0b 0x02 r97)
echo $r | cut -c6-
sleep 0.01
done
