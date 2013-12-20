131219
======

_more about sensors, beaglebone black, twitter, present own project ideas_

//--autostart
-------------
To make a python program automatically start when you power on the beaglebone black, you can do edit the rc.local file and launch the .py file from there.

* `sudo pico /etc/rc.local`
* place the cursor somewhere before the `exit 0` line and type...
* `(sleep 5; python /home/debian/led_6channel_test.py) &` # edit to match the name of the file you want to autoload (no need with sudo, rc.local is already running as sudo)
* to stop in a safe way, either set up a GPIO pin with a button that turns the system off (see below), or log in with ssh and do `sudo pkill python`

If you want to test the above led_6channel_test example, connect 6 leds, 6 resistors and an uln2803a like [this](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131219/led_6channel_test.png).
The led_6channel_test pyhon code is [here](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131219/led_6channel_test.py)

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

The above bash script will start jack and sclang after each other. We then need to launch this script at startup. Here is one of the easier ways of doing that...

* `sudo pico /etc/rc.local`
* place the cursor somewhere before the `exit 0` line and type...
* `(sleep 5; /bin/bash /home/debian/autostart_test) &`
* last we should create a supercollider test file called autostart_test.scd (same as in the bash script above) and use s.waitForBoot to start scserver:
* `pico autostart_test.scd`
* add the following sc code, save and exit

```
s.waitForBoot{
        {SinOsc.ar([400, 404], 0, 0.1)}.play;
};
```

* `sudo reboot` # jack and sc should start automatically after a while
* to stop log in with ssh and do `sudo pkill jackd` (or set up a GPIO pin like described below)

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

You can now test this python program with the command `sudo python autostart_stop.py &`. After you run that connect a cable between P9_23 and 3.3v (Note: take extra care that the pins you are connecting to are the right ones. See <http://www.alexanderhiam.com/blog/beaglebone-pinout/>). After connecting the pin 23 (it's enough to just hold it to 3.3v more than 0.5sec), the system should turn itself off. Wait until all the blue leds are off (it takes around 25seconds) and then you can safely remove the 5v power.
If you wish to quickly start again, press the small power button next to the ethernet jack on the bbb.

Last, to automatically start this button-stop-python-program, we can edit the autostart_test script we made above.

* `pico autostart_test`
* add two lines and make it look like this (and press ctrl+o to save and ctrl+x to exit as usual)

```
#!/bin/bash
python /home/debian/autostart_stop.py & # added for stop button support
sleep 1
su debian -c "jackd -dalsa -dhw:1,0 -p1024 -n3 -s &"
sleep 1
su debian -c "sclang /home/debian/autostart_test.scd"
```

Try it by rebooting (`sudo reboot`) and when it has started, connect the pin P9_23 to 3.3v to turn off.

(Again we don't need sudo on the python script because rc.local is already running as sudo.)

//--thursday instrument autostart
---------------------------------
To add autostart and a stop button to the [thursday instrument](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205#--starting-the-instrument) we built two weeks ago, you can do the following...

* `cd /home/debian`
* `pico thursday_autostart` # create a textfile in home
* add the following (and press ctrl+o to save and ctrl+x to exit as usual)

```
#!/bin/bash
python /home/debian/thursday+.py &
sleep 1
su debian -c "jackd -dalsa -dhw:1,0 -p1024 -n3 -s &"
sleep 1
su debian -c "sclang /home/debian/thursday.scd"
```

* download and copy over (with scp) the modified [thursday+.py](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219/thursday+.py) to the bbb. (lines modified: 13, 17, 51-53)
* restart and now it should both start automatically (jingle should play) and you can turn it off by connecting P9_23 to 3.3v.

//--orfi_twitter
----------------
This is a small project I built using the following:

* [beaglebone black](http://www.exp-tech.de/Mainboards/BeagleBone-Black.html)
* [5v battery pack](http://www.reichelt.de/Mobile-Powerpacks/POWERBANK-5000/3//index.html?ACTION=3&GROUPID=4491&ARTICLE=102042&SEARCH=Mobile%20Powerpacks&SHOW=1&OFFSET=500&)
* [4-port usb hub](http://www.reichelt.de/USB-Hubs/MANHATTAN-160599/3//index.html?ACTION=3&GROUPID=6103&ARTICLE=94684&SEARCH=MANHATTAN%20160599&SHOW=1&OFFSET=500&)
* [logilink nano wlan usb adapter](http://www.reichelt.de/WLAN-Adapter/LOGILINK-WL0084B/3//index.html?ACTION=3&GROUPID=770&ARTICLE=120745&SEARCH=logilink%20nano&SHOW=1&OFFSET=500&)
* [3d sound audio usb adapter](http://dx.com/p/virtual-5-1-surround-usb-2-0-external-sound-card-22475)
* [roxcore active speaker](http://www.kjell.com/sortiment/dator-kringutrustning/datortillbehor/hogtalare-headset/mobil-och-mp3-hogtalare/roxcore-portabel-hogtalare-svart-p23133)
* [uln2803a darlington array](http://www.reichelt.de/ICs-U-ZTK-/ULN-2803A/3//index.html?ACTION=3&GROUPID=2921&ARTICLE=22085&SEARCH=uln2803a&SHOW=1&OFFSET=500&)
* [six 120ohm smd resistors](http://www.reichelt.de/SMD-1206-100-Ohm-910-Ohm/SMD-1-4W-120/3//index.html?ACTION=3&GROUPID=3088&ARTICLE=18251&SEARCH=smd%201%2F4w%20120&SHOW=1&OFFSET=500&)
* [double row pin headers](http://www.reichelt.de/Stiftleisten/SL-2X25G-2-54/3//index.html?ACTION=3&GROUPID=3220&ARTICLE=19494&SEARCH=SL%202X25G%202%2C54&SHOW=1&OFFSET=500&)
* [stripboard](http://en.wikipedia.org/wiki/Stripboard)
* [orfi pillow](http://musicalfieldsforever.com/orfi_conc.html) left over from an old installation i did together with musicalfieldsforever

![orfi_twitter](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131129/orfi_twitter/orfi_twitter.jpg)

It's a sort of wireless pillow that plays sounds and melodies generated from twitter messages. When a twitter message mentions @MFF_f0, the leds on the pillow starts to flash and a little melody is played. With the two sensors (one in each 'wing' of the pillow), one can play back the latest and next to latest melodies. The left sensor just plays the latest message, while the right one step through backwards in time and also lowers the tempo for each message playback. Message history is saved in a log and loaded again the next time you power on the pillow.

There's a python program that scans twitter messages, read sensors and controls (pwm) the six leds. There is also a supercollider program that generates and plays the melodies. All the source code and schematics are in the folder 'orfi_twitter' next to this readme file. And to get the twitter thing running I followed tutorials here...

* <https://learn.sparkfun.com/tutorials/raspberry-pi-twitter-monitor/register-your-twitter-app>
* <http://www.makeuseof.com/tag/how-to-build-a-raspberry-pi-twitter-bot/>

Basically you need to do the following on your beaglebone black...

* `sudo apt-get update`
* `sudo apt-get upgrade`
* `sudo apt-get install python-pip` # you should already have this
* `sudo pip install twython`
* then move over (with scp) the files orfi_twitter_autostart, orfi_twitter.py and orfi_twitter.scd to /home/debian/
* register an application at http://dev.twitter.com (see links to tutorials above)
* `pico orfi_twitter.py` # and edit the four twitter authentication tokens where it says 'edit'
* `sudo pico /etc/rc.local` # and add the line: `(sleep 5; /bin/bash /home/debian/orfi_twitter_autostart) &`
* shut down, connect soundcard and speaker + internet (if you use wlan it needs to be prepared. see [udk131128](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--extra))
* restart and wait a bit until fully booted
* activate the sensors to see if anything sounds
* send a twitter message with @MFF_f0 (or whatever term you set to track in the orfi_twitter.py file)

![orfi_twitter_inside](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131129/orfi_twitter/orfi_twitter_inside.jpg)

//--extra (advanced)
--------------------
To make more GPIO pins available one need to disable hdmi. See <http://www.logicsupply.com/blog/2013/07/18/disabling-the-beaglebone-black-hdmi-cape/>

//--extra
---------
To turn off the annoying and bright heartbeat led, you can do the following...

* `cd /sys/class/leds/beaglebone\:green\:usr0`
* `sudo su` # become root
* `echo none > trigger`
* `exit` # back to user debian
* `cd ~`

To get it back do the same again but replace `none` with `heartbeat`.

Though this change will not survive restarts. To make the heartbeat go away permanently you can do...

* `sudo pico /etc/rc.local`
* add the following line somewhere before exit 0
* `echo none > /sys/class/leds/beaglebone\:green\:usr0/trigger # turn off heartbeat led`
