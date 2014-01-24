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

now turn off the bbb, connect the wires and try pushing the button.  the bbb should boot, and the next time you press the bbb should turn off (in a safe way - takes a few seconds).


//--servo with bbb
------------------
here's an example of controlling two servo motors from supercollider.

put the following code in to a file with `pico pwm_control.py`.  run it with `sudo python pwm_control.py`

```

# simple program to control two leds or servos via pwm on a beaglebone black
# note: must use transistors or uln2803a to protect the pins

import Adafruit_BBIO.PWM as PWM
import time
import OSC
import threading

# settings
pwm1= "P9_14"
pwm2= "P9_16"
PWM.start(pwm1, 50, 60) # pin, startpos, pwmfreq
PWM.start(pwm2, 50, 60)
server= OSC.OSCServer(('0.0.0.0', 11000)) # receive port number

server.addDefaultHandlers()
def oscInput(addr, tags, stuff, source):
        print str(stuff) # debug
        PWM.set_duty_cycle(pwm1, stuff[0]) # max range 0-100, but need to adapt to each motor
        PWM.set_duty_cycle(pwm2, stuff[1])

server.addMsgHandler("/pwm", oscInput)
server_thread= threading.Thread(target= server.serve_forever)
server_thread.start()

try:
        while True:
                time.sleep(1)
except KeyboardInterrupt:
        pass

print "stopping..."
PWM.stop(pwm1)
PWM.stop(pwm2)
PWM.cleanup()
server.close()
server_thread.join()
```

then connect two servos orange to controller pin (P9_14 or P9_16), red to P9_3 (5V raw) and brown to P9_1 (gnd)
also add 1K resistors between controller pins and the motors.

NOTE: you must use a real 5v powersupply.  do _not run the motors when powering the bbb from the usb.

see this [adafruit tutorial](http://learn.adafruit.com/controlling-a-servo-with-a-beaglebone-black?view=all)

the supercollider code is simple.  try something like this...

```
n= NetAddr("192.168.1.53", 11000);	//edit to match bbb ip (or 127.0.0.1 if running sc on the bbb itself)
(
Routine.run({
	99999.do{
		n.sendMsg(\pwm, 15.0.rand.postln, 15.0.rand.postln);
		1.wait;
	};
})
)
```
