#!/bin/sh


sudo i2cget -y 1 0x0b 0x09 w | awk ' {print substr($1,3); }' | awk ' {$1=strtonum("0x" $1)}  gsub("^.{1}","&.") {print "Voltage is: " $1 " V"} '
