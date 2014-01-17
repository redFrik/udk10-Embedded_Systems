140116
======

_own projects_



//--using hid in bbb
--------------------
you can connect gamepads, joysticks, and other usb devices to the beaglebone black. and to make use of them in supercollider we can write a small python program that reads and sends the hid data via osc.

first make sure you have installed pip and pyosc (+ git and the rest) following the instructions [here](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--installing-software)

* `sudo apt-get install libusb-1.0-0-dev libudev-dev`
* `sudo pip install cython`
* `git clone https://github.com/gbishop/cython-hidapi.git`
* `cd cython-hidapi`
* `sudo python setup-arm.py build`
* `sudo python setup.py install`

now connect a joystick or some other device and try the code below. (make a new file with `pico hidtest.py` and copy the code, ctrl+o and ctrl+x to save and exit, run it with `sudo python hidtest.py`)
this should list the name and some other info of all the connected devices.

```
import hid

for d in hid.enumerate(0, 0):
        keys= d.keys()
        for key in keys:
                print key, d[key]
        print ""
```

//--rotary encoder
------------------
here is a python example of how to read a rotary encoder with the beaglebone black.

```
#for reading a rotary encoder with bbb
#connect middle pin to 3v3 and the two outer pins to P9_41 and P9_42

import Adafruit_BBIO.GPIO as GPIO
import time

a= "P9_41"
b= "P9_42"

pos= 0
last_pos= 0
last= ""
val_a= 0
val_b= 0
def update(channel):
        global pos, last, val_a, val_b
        val= GPIO.input(channel)
        if channel==a:
                val_a= val
        else:
                val_b= val
        if channel!=last:
                if channel==a and val==0:
                        if val_b==0:
                                pos= pos+1
                if channel==b and val==1:
                        if val_a==1:
                                pos= pos-1
                last= channel

GPIO.setup(a, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(b, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.add_event_detect(a, GPIO.BOTH, callback= update)
GPIO.add_event_detect(b, GPIO.BOTH, callback= update)
try:
        while True:
                if pos!=last_pos:
                        print pos
                        #here send to sc or do something more useful
                        last_pos= pos
                time.sleep(0.01)
except KeyboardInterrupt:
        GPIO.cleanup()
```
