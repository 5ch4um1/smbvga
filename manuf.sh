#!/bin/sh



 a=$(sudo i2ctransfer -y 1 w1@0x0b 0x20 r9) 
b=$(sudo i2ctransfer -y 1 w1@0x0b 0x21 r9 )
echo "$a $b " | awk ' {gsub("0x",""); gsub(" ",""); print }' | xxd -p -r  | awk '{print "Manufacturer Info: ", $1}'








