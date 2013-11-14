131114
======

_beaglebone black overview, debian setup and installation_

the beaglebone black (bbb) <http://www.exp-tech.de/Mainboards/BeagleBone-Black.html> is a small linux computer that can run supercollider, puredata and lots of other programs.

besides the bbb itself you'll need a 5v power adapter, a +2gb sd card and an ethernet cable.

sound input (electret mic) and output (active speakers, headphones or amplifier) is best handled with an usb soundcard. for example: <http://www.amazon.com/Virtual-5-1-surround-External-Sound-Card/dp/B000N35A0Y>

you can directly connect sensors to use as inputs (buttons, sliders, accelerometers etc), and actuators/outputs like leds and motors you can connect via small protective circuits or drivers.  the general purpose in and out pins (GPIO) can act as either inputs or outputs.

//--preparation (first time only)
---------------------------------

note: some of these instructions are mac osx only.  for linux and windows you will need to figure out yourself how to do it.  the process is the same (transfer the img to the sd card), but the tools will be different.
see <http://learn.adafruit.com/beaglebone-black-installing-operating-systems/overview> and follow the instructions for ubuntu (which is compatible with the debian img we are using).

* go to <http://www.armhf.com/index.php/download/> and download the "BeageBone Black Debian Wheezy 7.2" image file.
* (osx) unpack the .xz file with "The Unarchiver" (free on app store)
* (osx) go to <http://ivanx.com/raspberrypi/> and download "Pi Filler".
* (osx) start the pi filler program and follow the instructions (takes ~20min). basically the filler helps you to copy the debian disk image on to the sd card.

//--startup
-----------

* insert the micro sd card with the debian image in the bbb
* connect an ethernet cable between your bbb and your computer
* connect 5v power adapter and the bbb should start to blink (first light up 4 leds in sequence, then heartbeat)

note: you can also connect the ethernet cable directly to your wlan router (if there are any free slots).  then skip the step with internet sharing below.

//--logging in
--------------
to log in to the bbb from our laptop via ssh, we need to know the bbb's ip address.  this you can easiest find either by looking in the router status panel of connected devices, or using the LanScan.app (<http://www.iwaxx.com/lanscan/>, free on appstore).

* (osx) if you have the bbb connected directly to your mac, go to system preferences and sharing.  enable internet sharing (wlan to ethernet).
* (osx) start LanScan, press space to scan and see if it finds the ip of the bbb.
* when you have the ip, start terminal and try to log in via ssh...
* `ssh debian@192.168.2.4` # note that the ip might be different
* the default password is `debian`.

ssh troubleshooting:
* if you get `ssh: connect to host 192.168.2.4 port 22: Operation timed out` then likely the ip is wrong or that the bbb hasn't fully started yet.
* if you get `WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!` on your laptop then the ip is right but you'll need to reset the ssh key with the following command: `ssh-keygen -R 192.168.2.4`

note: you can also connect a hdmi monitor (using a hdmi micro adapter), and a usb keyboard and then run the bbb completely standalone.

//--installing software
-----------------------
this assumes you have installed debian on a sd card and booted the bbb.
to do anything useful we'll need to install some libraries and programs.  we should first set the date and update any default packages that are on the debian img.

* `date` # checks the date.  if it's the first time you start up this is probably wrong
* `sudo dpkg-reconfigure tzdata` # to set timezone
* `sudo ntpdate pool.ntp.org` # to set the time
* `date` # again check the date.  should now be correct

* `sudo apt-get update` # check for updates.  this is good to run often and always before installing new things
* `sudo apt-get upgrade` # install updates.  and this too of course.  answer Y if/when asked

now we're ready to install some stuff.

a very useful library is the python gpio library from adafruit.  see <https://github.com/adafruit/adafruit-beaglebone-io-python>

* `sudo apt-get install build-essential python-dev python-pip` # answer Y when asked
* `sudo easy_install -U distribute`
* `sudo pip install Adafruit_BBIO`

another useful library is pyOSC.  with this you can send osc commands from python.

* `sudo apt-get install git` # first install git
* `git clone git://gitorious.org/pyosc/devel.git` # get the latest pyosc version
* `cd devel` # go to directory we just cloned
* `sudo ./setup.py install` # build and install
* `cd ..` # go back
* `sudo rm -r devel` # delete cloned directory

//--a simple python program
---------------------------
our first little python program.  to type it in we need a text editor.

* `pico firsttest.py`

then type in the following.  note: in python indentation (tabs) are important

```
import time
val= 0
while True:
        val= val+1
        print val
        time.sleep(1)
```

then press ctrl+o to save and ctrl+x to exit the pico text editor.
now run the program with...

* `python firsttest.py`

stop with ctrl+c

//--second python program
-------------------------
this program will read a digital sensor and print the result.  we'll use pin 41 on port P9.  see <http://cholla.mmto.org/computers/beagle/beaglebone_pinout1-1024x585.png>.
again create the file and start the text editor with...

* `pico digitaltest.py`

and then type this (or copy and paste - it also works over ssh)...

```
import Adafruit_BBIO.GPIO as GPIO
import time
GPIO.setup("P9_41", GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
while True:
        val= GPIO.input("P9_41")
        print val
        time.sleep(0.25)
```

ctrl+o and ctrl+x to save and exit, use `sudo python digitaltest.py` to run.
note: we need to use sudo to run this python program because we need to have root privilegiers to access the hardware gpio pins.

while the program is running (it should print 0, 0, 0, ...) connect a cable between pin 41 and 3.3v.
NOTE: ONLY CONNECT TO 3.3V!  (P9_3 or P9_4).  if you connect this to the wrong pin (5v) you can destroy the board.
the number should change to 1, 1, 1, ...
stop with ctrl+c

![digital test](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131114/IMG_20131114_113821.jpg)

//--third program
-----------------
here we read an analog sensor and print the result.

* `pico analogtest.py`

```
import Adafruit_BBIO.ADC as ADC
import time
ADC.setup()
while True:
        val= int(ADC.read_raw("P9_39")) #0-1799
        print val
        time.sleep(0.125)
```

while the program is running connect a cable between pin 39 and vdd_adc or gnd_adc (or better connect a potentiometer to all three with 39 going to pot center pin).
NOTE: ONLY CONNECT TO VDD_ADC or GND_ADC (1.8V).  if you connect this to the wrong pin you can destroy the board.
you should see the printed number vary from 0 to 1799.

![analog test](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131114/IMG_20131114_114120.jpg)

//--send osc example
--------------------
in this example we read one digital and one analog sensor and send it via open sound control to another computer (e.g. your laptop).

* `pico osctest.py`

```
import Adafruit_BBIO.ADC as ADC
import Adafruit_BBIO.GPIO as GPIO
import time
import OSC

ADC.setup()
lastadc= -1
GPIO.setup("P9_41", GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
lastdig= -1
sc= OSC.OSCClient()
sc.connect(('192.168.1.52', 57120)) #edit to match your laptop ip

while True:
        val= int(ADC.read_raw("P9_39")) #0-1799
        if val!=lastadc:
                lastadc= val
                msg= OSC.OSCMessage()
                msg.setAddress("/adc")
                msg.append(val)
                sc.send(msg)
                print val
                #time.sleep(0.1)
        val= GPIO.input("P9_41")
        if val!=lastdig:
                lastdig= val
                msg= OSC.OSCMessage()
                msg.setAddress("/dig")
                msg.append(val)
                sc.send(msg)
                print val
        time.sleep(0.05)
```

on your laptop start supercollider and run these two lines

```
OSCFunc({|msg| msg.postln}, '/adc');
OSCFunc({|msg| msg.postln}, '/dig');
```

it should print out the incoming sensor values.
now you can use that to start synths, set parameters or whatever.

if you get the error...
```
Traceback (most recent call last):
  File "osctest.py", line 29, in <module>
    sc.send(msg)
  File "/usr/local/lib/python2.7/dist-packages/OSC.py", line 1222, in send
    raise OSCClientError("while sending: %s" % str(e))
OSC.OSCClientError: while sending: [Errno 111] Connection refused
```
then just start supercollider and try again (or comment out the two sc.send lines).

![osc test](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131114/IMG_20131114_115131.jpg)

//--turning off
---------------
avoid pulling the power.  that might corrupt the sd card and then you can't boot the bbb any more.
* type `sudo halt` and wait for the blue leds to stop blinking to turn the bbb off safely.
* and to reboot use instead `sudo reboot`.
* to start from after a halt either reconnect the 5v power, or press the power button.

//--links
---------

* <http://learn.adafruit.com/category/beaglebone>
* <http://www.element14.com/community/community/knode/single-board_computers/next-gen_beaglebone/blog>
* <http://www.michaelhleonard.com/raspberry-pi-or-beaglebone-black/>
* <http://www.codecademy.com> and click python
