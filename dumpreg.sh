#!/bin/bash

#
# this aparently dumps the content of the registers(?), from 0x00 to 0x75 (?)
# the longest on my chip seems to be 33 bytes, however, i set it to 64, doesn't seem to hurt.  
# use ./dump.sh &> dump.txt to dump everything to a text file. waiting one second might be a bit generous, you might lower that a bit?
#

max=118
for ((i=1;i<=max;i++))
do
  i=$(printf "%#.2x\n" $i)


sudo i2ctransfer -y 1 w1@0x0b $i r64
sleep 1
done
