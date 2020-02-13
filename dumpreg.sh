#!/bin/bash

#
# this aparently dumps the content of the registers(?), from 0x00 to 0x76 
# the longest on my chip seems to be 34 bytes. 
# use ./dumpreg.sh &> dump.txt to dump everything to a text file. waiting one second might be a bit generous, you might lower that a bit?
# cat -n dump.txt | awk ' BEGIN{FS="\t"} {printf "%02x,%s\n", $1-1,$2}' | awk ' {gsub (",",":\t")}1' > dump-with-nice-formatting.txt

max=118
for ((i=0;i<=max;i++))
do
  i=$(printf "%#.2x\n" $i)


sudo i2ctransfer -y 1 w1@0x0b $i r34
sleep 1
done
