131219
======

_more about sensors, beaglebone black, twitter, present own project ideas_

//--autostart
-------------
To make a python program automatically start when you power on the beaglebone black, you can do edit the rc.local file and launch the py file from there.

* `sudo pico /etc/rc.local`
* place the cursor somewhere before the `exit 0` line and type...
* `(sleep 5; python /home/debian/led_6channel_test.py) &` # edit to match the name of the file you want to autoload (no need with sudo, rc.local is already running as sudo)
* to stop in a safe way, either set up a GPIO pin with a button that turns the system off (see below), or log in with ssh and do `sudo pkill python`

If you want to test the above led_6channel_test example, connect 6 leds, 6 resistors and an uln2803a like [this](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131119/led_6channel_test.png).
The led_6channel_test pyhon code is [here](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131119/led_6channel_test.py)

//--autostart jack and sc
-------------------------
To automatically start a supercollider patch is a little bit more involved (jack needs to run first etc.) and then it is better to use a bash script.
Here is how to create and set up a bash script that will start when you turn on the beaglebone black...

* `cd /home/debian` # go to home directory
* `pico autostart_test` # create a textfile in home
* add the following (and press ctrl+o to save and ctrl+x to exit as usual)

```
#!/bin/bash
su debian -c "jackd -dalsa -dhw:1,0 -p1024 -n3 -s &"
sleep 1
su debian -c "sclang /home/debian/autostart_test.scd"
```

The above bash script will start jack and sclang after each other. We then need to launch this script at startup. Here is one of the easiest ways of doing that...

* `sudo pico /etc/rc.local`
* place the cursor somewhere before the `exit 0` line and type...
* `(sleep 5; /bin/bash /home/debian/autostart_test) &`
* last we should create a supercollider test file called `autostart_test.scd` (same as in the bash script above) and use `s.waitForBoot` to start scserver:
* `pico autostart_test.scd`
* add the following sc code, save and exit

```
s.waitForBoot{
        {SinOsc.ar([400, 404], 0, 0.1)}.play;
};
```

* `sudo reboot` # jack and sc should start automatically after a while
* to stop log in with ssh and do `sudo pkill jackd` (or use a pin like described below)

//--turning off with a button
-----------------------------
Normally we need to log in with ssh and do `sudo halt` to turn off the beaglebone black in a safe way. (If we pull the power your sd card can become corrupt - so try to avoid that if possible).
If we autostart something and run without network cables etc, we also want to be able to turn off the system in a quick and safe way. One option is to set up a GPIO pin that when pressed turns the bbb off.

* `cd /home/debian` # go to home directory
* `pico autostart_stop.py` # create a textfile in home
* add the following (and press ctrl+o to save and ctrl+x to exit as usual)

```
import Adafruit_BBIO.GPIO as GPIO
import time
import os

GPIO.setup("P9_23", GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

while True:
	val= GPIO.input("P9_23") # read pin
	if val==1: # check if connected to 3.3v
		os.system("sudo halt") # turn off the bbb
		exit() # exit this python program
	time.sleep(0.5) # wait half a second
```

You can now test this python program with the command `sudo python autostart_stop.py &`. After you run that connect a cable between P9_23 and 3.3v (Note: take extra care that the pins you are connecting to are the right ones. See <http://www.alexanderhiam.com/blog/beaglebone-pinout/>). After connecting the pin 23 (it's enough to just hold it to 3.3v more than 0.5sec), the system should turn itself off. Wait until all the blue leds are off. It takes around 25seconds. Then you can safely remove the 5v power.
If you wish to quickly start again and not remove the 5v, press the small power button next to the ethernet jack on the bbb.

Last, to start this button stop python program when the beaglebone black is started, we can edit the autostart_test script we made above.

* `pico autostart_test`
* add two lines and make it look like this (and press ctrl+o to save and ctrl+x to exit as usual)

```
#!/bin/bash
python /home/debian/autostart_stop.py &
sleep 1
su debian -c "jackd -dalsa -dhw:1,0 -p1024 -n3 -s &"
sleep 1
su debian -c "sclang /home/debian/autostart_test.scd"
```

Try it by rebooting (`sudo reboot`) and when it has started, connect the pin P9_23 to 3.3v to turn off.

(We don't need sudo on the python script because rc.local is already running as sudo.)

//--orfi_twitter
----------------
This is a small project I built using the following:

* beaglebone black
* 5v battery pack
* 4-port usb hub
* logilink nano wlan usb adapter
* 3d sound audio usb adapter
* roxcode active speaker
* uln2803a darlington array
* six 120ohm smd resistors
* double row pin headers
* [stripboard](http://en.wikipedia.org/wiki/Stripboard)


It's a sort of pillow which plays sound out of twitter messages. When a twitter message mentions @MFF_f0 the leds on the pillow starts to flash and a little melody is generated from of the text in the message. With the two sensors (one in each 'wing' of the pillow), one can play back the latest and next to latest melodies.
There's a python program that scan twitter messages, read sensors and controls the six leds, and a supercollider program for generating and playing melodies.

All the source code and schematics are in the same folder as this readme file. And to get the twitter thing running I followed tutorials here...

* <https://learn.sparkfun.com/tutorials/raspberry-pi-twitter-monitor/register-your-twitter-app>
* <http://www.makeuseof.com/tag/how-to-build-a-raspberry-pi-twitter-bot/>

Basically you need to do the following on your beaglebone black...

* `sudo apt-get update`
* `sudo apt-get upgrade`
* `sudo apt-get install python-pip` # you should already have this
* `sudo pip install twython`

//--extra (advanced)
--------------------
To make more GPIO pins available one need to disable hdmi. See <http://www.logicsupply.com/blog/2013/07/18/disabling-the-beaglebone-black-hdmi-cape/>
