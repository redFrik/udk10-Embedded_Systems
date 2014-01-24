140123
======

_own projects_


//--start stop button
---------------------
to set up a single push button to turn on and off the beaglebone black, you can connect a pull-up resistor + a diode + a button like this.

![start_stop_button](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk140123/start_stop_button.png)

the resistor is a 10K and the diode a 1N914.

* `pico start_stop.py`
* add the following program...

```
#a little python program that waits for P9_23 to go low and then turn off the bbb
import Adafruit_BBIO.GPIO as GPIO
import time
import os

off= "P9_23"
GPIO.setup(off, GPIO.IN)

while True:
	if GPIO.input(off)==0:
		os.system("sudo halt")
		exit()
	time.sleep(0.1) # wait a little
```

* `sudo pico /etc/rc.local`
* add the following line before exit
* `(python /home/debian/start_stop.py) &`
* press ctrl+o and ctrl+x to save and exit
