# smbvga

DISCLAIMER: you should not mess with your battery, you might brick your battery, or even worse, your PC!
better use an external i2c interface! your battery might explode. again, don't mess with your battery.

goal of this project is to learn more about the dead battery of my laptop. (and maybe "how to set my home on fire")

i found out that i can plug 3 cables into the vga port of my laptop and talk to the battery via i2c-tools on linux.

primary source of information so far has been the blog karosium.com 

so far, i managed to get into (what i believe is) full access mode.
the chip on my battery is a bq8030 with sanyo firmware.

	battery pinout:

                  |  |       |   |   |   |   | 
                 
                  + +       SCL SDA  T? GND GND

	vga pinout:             15   12          5 




if your distro has it in the repos: 

sudo apt-get install i2c-tools



	sudo i2cdetect -l
	i2c-3	i2c       	i915 gmbus dpc                  	I2C adapter
	i2c-1	i2c       	i915 gmbus vga                  	I2C adapter
	i2c-6	i2c       	DPDDC-B                         	I2C adapter
	i2c-4	i2c       	i915 gmbus dpb                  	I2C adapter
	i2c-2	i2c       	i915 gmbus panel                	I2C adapter
	i2c-0	i2c       	i915 gmbus ssc                  	I2C adapter
	i2c-7	i2c       	DPDDC-D                         	I2C adapter
	i2c-5	i2c       	i915 gmbus dpd                  	I2C adapter
	
	
		sudo i2cdetect -y 1
	     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
	00:          -- -- -- -- -- -- -- -- 0b -- -- -- -- 
	10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
	70: -- -- -- -- -- -- -- --
	
also needs xxd, but i guess you already have that installed on your system.

the scripts are for the above mentioned i2c bus and address.
you can change this ONCE by running ./setup.sh
after that, if you want to change again, you'd need to edit ./setup.sh 

I recently got a cheap fx2 based logic analyzer, turns out you can run karosiums tools just fine on these, just had to abuse the eeprom on that thing as an 
i2c breakout, but it works and i was able to get dumps of both the program memory and the eeprom data.
Thanks to that i was able to spot an error in a script i wrote about a year ago, so, prgdump.sh should now dump the program memory if you are in boot rom mode.
By adjusting the start and stop address, this should be able to dump the eeprom data too iirc. (edit: i did not remember correctly, for the eeprom it's a word write, to another address, and read from another address too, just see for yourself, added dumpeep.sh now.)  
