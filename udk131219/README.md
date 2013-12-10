131219
======

_more about sensors, arduino, beaglebone black, twitter, prepare own projects_

//--orfi_twitter
----------------

* `sudo apt-get update`
* `sudo apt-get upgrade`
* `sudo apt-get install python-pip` # you should already have this
* `sudo pip install twython`

//TODO

* <https://learn.sparkfun.com/tutorials/raspberry-pi-twitter-monitor/register-your-twitter-app>
* <http://www.makeuseof.com/tag/how-to-build-a-raspberry-pi-twitter-bot/>

//--autostart
-------------
To make something automatically start when you power on the beaglebone black, you can do edit the rc.local file.

* `sudo pico /etc/rc.local`
* place the cursor somewhere before the `exit 0` line and type...
* `(sleep 5; python /home/debian/led_6channel_test.py) &` # edit to match the name of the file you want to autoload (no need with sudo, rc.local is already running as sudo)
* to stop, either set up a GPIO pin with a button that turns the system off, or log in with ssh and do `sudo pkill python`

//--autostart jack and sc
-------------------------
To auto start a supercollider patch is a little bit more involved and then you can for example do that with a bash script.

* `cd /home/debian`
* `pico autostart_test`
* add the following and press ctrl+o to save and ctrl+x to exit
```
#!/bin/bash
su debian -c "jackd -dalsa -dhw:1,0 -p1024 -n3 -s &"
sleep 1
su debian -c "sclang /home/debian/autostart_test.scd"
```
* `sudo pico /etc/rc.local`
* place the cursor somewhere before the `exit 0` line and type...
* `(sleep 5; /bin/bash /home/debian/autostart_test) &`
* to stop log in with ssh and do `sudo pkill jackd`


//--extra (advanced)
--------------------
To make more GPIO pins available one need to disable hdmi. See <http://www.logicsupply.com/blog/2013/07/18/disabling-the-beaglebone-black-hdmi-cape/>
