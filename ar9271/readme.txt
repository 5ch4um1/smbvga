
turns out, that good old atheros usb wifi dongle has a i2c interface to it's eeprom, a 24c08 if i see that right.
so, i am able to read that stuff. 

there are these guys over at the kali forum who did some eeprom hacking to get a higher txpower:

https://forums.kali.org/showthread.php?28874-ALFA-AWUS036NHA-hacking-EEPROM-via-UART-JTAG&highlight=ar9271

so, if i understand that right, that ar9271 is a small computer that loads it's operating system(?) aka firmware from that
eeprom? or, is ist more like some configuration values? there is this issue which sounds SUPER interesting: 

https://github.com/qca/open-ath9k-htc-firmware/issues/44

again, if i understand that right, i could now flash new stuff to that eeprom?
and it would be more convenient to have the chip boot from an sd card via spi, with a lower risk to brick something?

so, the next question now, can it do blinken lights, can i have wifi with a knight rider led-bar?
write some funny text into unused areas?
or, what else would be possible? could some smart guys maybe turn it into a general purpose sdr to send arbitrary signals?
get control over all those unused(?) gpio pins? 
and well, apart from not having anything that talks spi, those pins are really tiny, the 24c08 seems huge compared to that.






