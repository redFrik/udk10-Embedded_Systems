140116
======

_own projects_



//--using hid in bbb
--------------------
you can connect gamepads, joysticks, and other usb devices to the beaglebone black. and to make use of them in supercollider we can write a small python program that reads and sends the hid data via osc.

first make sure you have installed pip and pyosc (and git and the rest) following the instructions [here](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114)

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
