# smbvga

goal of this project is to learn more about the dead battery of my laptop. (and maybe "how set my house on fire")

i found out that i can plug 3 cables into the vga port of my laptop and talk to the battery via i2c-tools on linux.

primary source of information so far has been the blog karosium.com 

so far, i managed to get into (what i believe is) full access mode.
the chip on my battery is a bq8030 with sanyo firmware.

battery pinout:

                 |  |       |   |   |   |   | 
                 
                 + +       SCL SDA  T? GND GND

vga pinout:                15   12          5 




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




sudo i2cdump -y 1 0x0b w
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: b002 01e8 000a e000 0000 ffff ffff ffff 
08: 0b88 24a4 0000 0000 0000 0000 0000 0000 
10: 084d 0000 0000 ffff 0000 0000 03d0 0080 
18: 1314 2b5c 0031 3c3c .... XXXX XXXX XXXX 
20: 5308 4c08 4c04 420e XXXX XXXX XXXX XXXX 
28: XXXX XXXX XXXX XXXX XXXX XXXX XXXX 310b 
30: 0d0a a910 c810 0018 XXXX XXXX XXXX XXXX 
38: XXXX XXXX XXXX 0b8a 4c0a 0000 0001 0000 
40: 1717 XXXX 00ff ff20 XXXX XXXX XXXX XXXX 
48: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
50: 4203 0b0a 0108 0007 000d XXXX XXXX XXXX 
58: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
60: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
68: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
70: XXXX 1717 0000 XXXX XXXX XXXX XXXX XXXX 
78: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
80: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
88: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
90: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
98: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
a0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
a8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
b0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
b8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
c0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
c8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
d0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
d8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
e0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
e8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
f0: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
f8: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX



reading anything before 0x40 throws me out of full access mode:


sudo i2cdump -y -r 0x40-0x80 1 0x0b w
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
40: 1717 1717 00ff ff20 1717 ff0e XXXX XXXX 
48: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
50: 4204 0b0a 0108 0007 000d XXXX XXXX XXXX 
58: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
60: 1717 XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
68: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
70: 1717 1717 0000 0355 XXXX XXXX XXXX XXXX 
78: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
80: XXXX                        



writing stuff to 0x40 changes things in 0x42 and 0x43:

sudo i2cset -y 1 0x0b 0x40 0x0000 w

sudo i2cdump -y -r 0x40-0xff 1 0x0b w
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
40: 1717 XXXX 0003 0320 XXXX XXXX XXXX XXXX 
48: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
50: 4203 0b0a 0108 0007 000d XXXX XXXX XXXX 
58: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
60: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
68: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
70: XXXX 1717 0000 0355 XXXX XXXX XXXX XXXX 
78: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX




sudo i2cset -y 1 0x0b 0x40 0xff00 w

sudo i2cdump -y -r 0x40-0x80 1 0x0b w
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
40: 1717 1717 0000 0020 1717 000e XXXX XXXX 
48: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
50: 4204 0b0a 0108 0007 000d XXXX XXXX XXXX 
58: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
60: 1717 XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
68: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX 
70: 1717 1717 0000 0355 XXXX XXXX XXXX XXXX 
78: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX


this also changes 0x3b:

38: XXXX XXXX XXXX 0b8a 4c0a 0000 0001 0000

38: XXXX XXXX XXXX 0b89 4c0a 0000 0001 0000

the laptop then displays different manufacturer names. 
shouldn't the manufacturer name be at 0x20?  
