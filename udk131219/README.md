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

```bash
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

```supercollider
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

```python
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

You can now test this python program with the command `sudo python autostart_stop.py &`. After you run that connect a cable between P9_23 and 3.3v (Note: take extra care that the pins you are connecting to are the right ones. See <https://web.archive.org/web/20141024082937/http://www.alexanderhiam.com/blog/beaglebone-pinout/>). After connecting the pin 23 (it's enough to just hold it to 3.3v more than 0.5sec), the system should turn itself off. Wait until all the blue leds are off (it takes around 25seconds) and then you can safely remove the 5v power.
If you wish to quickly start again, press the small power button next to the ethernet jack on the bbb.

Last, to automatically start this button-stop-python-program, we can edit the autostart_test script we made above.

* `pico autostart_test`
* add two lines and make it look like this (and press ctrl+o to save and ctrl+x to exit as usual)

```bash
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

```bash
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

* [beaglebone black](https://www.exp-tech.de/plattformen/beaglebone-black/mainboards/5740/beaglebone-black-rev-c)
* [5v battery pack](https://www.reichelt.de/nicht-mehr-lieferbar-powerbank-5000-p102042.html?GROUPID=4491&SEARCH=Mobile%20Powerpacks&SHOW=1&OFFSET=500&&r=1)
* [4-port usb hub](https://www.reichelt.de/nicht-mehr-lieferbar-manhattan-160599-p94684.html?GROUPID=6103&SEARCH=MANHATTAN%20160599&SHOW=1&OFFSET=500&&r=1)
* [logilink nano wlan usb adapter](https://www.reichelt.de/wlan-adapter-usb-150-mbit-s-logilink-wl0084e-p169760.html?&trstct=pos_3&nbc=1)
* [3d sound audio usb adapter](https://www.dx.com/p/virtual-5-1-surround-usb-2-0-external-sound-card-2006642.html)
* [roxcore active speaker](http://www.kjell.com/sortiment/dator-kringutrustning/datortillbehor/hogtalare-headset/mobil-och-mp3-hogtalare/roxcore-portabel-hogtalare-svart-p23133)
* [uln2803a darlington array](https://www.reichelt.de/eight-darlington-arrays-dil-18-uln-2803a-p22085.html?&trstct=pos_1&nbc=1)
* [six 120ohm smd resistors](https://www.reichelt.de/smd-widerstand-1206-120-ohm-250-mw-5--rnd-1206-5-120-p183371.html?search=1206+120)
* [double row pin headers](https://www.reichelt.de/2x25pol-stiftleiste-gerade-rm-2-54-sl-2x25g-2-54-p19494.html?search=Stiftleisten+2X25G)
* [stripboard](https://en.wikipedia.org/wiki/Stripboard)
* [orfi pillow](https://musicalfieldsforever.com/interactive-art/orfi/concept/) left over from an old installation i did together with musicalfieldsforever

![orfi_twitter](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131219/orfi_twitter/orfi_twitter.jpg)

It's a sort of wireless pillow that plays sounds and melodies generated from twitter messages. When a twitter message mentions @MFF_f0, the leds on the pillow starts to flash and a little melody is played. With the two sensors (one in each 'wing' of the pillow), one can play back the latest and next to latest melodies. The left sensor just plays the latest message, while the right one step through backwards in time and also lowers the tempo for each message playback. Message history is saved in a log and loaded again the next time you power on the pillow.

There's a python program that scans twitter messages, read sensors and controls (pwm) the six leds. There is also a supercollider program that generates and plays the melodies. All the source code and schematics are in the folder 'orfi_twitter' next to this readme file. And to get the twitter thing running I followed tutorials here...

* <https://learn.sparkfun.com/tutorials/raspberry-pi-twitter-monitor/register-your-twitter-app>
* <https://www.makeuseof.com/tag/how-to-build-a-raspberry-pi-twitter-bot/>

Basically you need to do the following on your beaglebone black...

* `sudo apt-get update`
* `sudo apt-get upgrade`
* `sudo apt-get install python-pip` # you should already have this
* `sudo pip install twython`
* then move over (with scp) the files orfi_twitter_autostart, orfi_twitter.py and orfi_twitter.scd to /home/debian/
* register an application at https://developer.twitter.com/en (see links to tutorials above)
* `pico orfi_twitter.py` # and edit the four twitter authentication tokens where it says 'edit'
* `sudo pico /etc/rc.local` # and add the line: `(sleep 5; /bin/bash /home/debian/orfi_twitter_autostart) &`
* shut down, connect soundcard and speaker + internet (if you use wlan it needs to be prepared. see [udk131128](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--extra))
* restart and wait a bit until fully booted
* activate the sensors to see if anything sounds
* send a twitter message with @MFF_f0 (or whatever term you set to track in the orfi_twitter.py file)

![orfi_twitter_inside](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131219/orfi_twitter/orfi_twitter_inside.jpg)

With the 5000mAh 5v battery fully charged, the system runs for about 9.5 hours.

//--extra: disable hdmi
-----------------------
(Advanced) To make more GPIO pins available one need to disable hdmi. See <https://www.onlogic.com/company/io-hub/disabling-the-beaglebone-black-hdmi-cape/>
* `sudo mkdir /mnt/boot`
* `sudo mount /dev/mmcblk0p1 /mnt/boot`
* `sudo pico /mnt/boot/uEnv.txt`
* add the following on the optargs line (line 2)...
* `capemgr.disable_partno=BB-BONELT-HDMI,BB-BONELT-HDMIN,BB-BONE-EMMC-2G`
* `sudo reboot`

//--extra: heartbeat
--------------------
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

//--extra: power consumption
----------------------------
To reduce power consumption a bit (my bbb takes around 350mA in idle mode with wlan adapter connected and jackd+sc+python running), you can decrease the cpu speed.

* `sudo apt-get install cpufrequtils`
* `cpufreq-info` # should show the default 1ghz cpu frequency
* `sudo cpufreq-set --governor powersave` # the default is performance
* `cpufreq-info`# frequency should now be 300mhz

After this the bbb should draw a bit less current (my bbb with the same setup went down to 290mA - couldn't notice any problems with sound, sensors or pwm outputs so far).

Note: on my bbb ethernet draws 90-100mA while the usb wlan adater only around 20mA. So setting up wlan and disconnecting the ethernet cable will reduce the power consumption quite a bit.
