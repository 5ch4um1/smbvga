#!/bin/sh


sudo i2cset -y 1 0x0b 0x71 0x0214 w 
sleep 1  
sudo i2cget -y 1 0x0b 0x73 w 
sleep 1 
sudo i2cset -y 1 0x0b 0x71 0xfcab w 
echo "entered full access mode" 
