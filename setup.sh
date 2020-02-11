#!/bin/sh


echo "\n Initial setup. make sure you run i2cdetect to find out your I2C bus and Address \n The scripts are set up for bus 1, address 0x0b, if that's ok for you, hit ^C to quit this setup.\n This setup will work only ONCE! if you need to change your setup again, run ./chsetup.sh \n \n  if you need to change stuff, please enter the I2CBUS, e.g. for /dev/i2c-0 enter 0 : "

read busnum

echo "and now enter the address, e.g. 0x16 : "

read addr


cat *.sh | awk ' {gsub("-y 2","-y '$busnum'"); gsub("0x16","'$addr'")}'
echo "values have been changed."
