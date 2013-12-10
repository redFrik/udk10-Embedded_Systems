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
To make a python program automatically start when you power on the beaglebone black, you can do edit the rc.local file and launch the py file from there.

* `sudo pico /etc/rc.local`
* place the cursor somewhere before the `exit 0` line and type...
* `(sleep 5; python /home/debian/led_6channel_test.py) &` # edit to match the name of the file you want to autoload (no need with sudo, rc.local is already running as sudo)
* to stop, either set up a GPIO pin with a button that turns the system off (see below), or log in with ssh and do `sudo pkill python`

//--autostart jack and sc
-------------------------
To auto start a supercollider patch is a little bit more involved (jack need to run first etc) and then it is better to use a bash script.

* `cd /home/debian`
* `pico autostart_test`
* add the following (and press ctrl+o to save and ctrl+x to exit as usual)

```
#!/bin/bash
su debian -c "jackd -dalsa -dhw:1,0 -p1024 -n3 -s &"
sleep 1
su debian -c "sclang /home/debian/autostart_test.scd"
```

Now we have a bash script that will start jack and sclang after each other. Next we need to launch this script at startup. Here is one of the simpler ways of doing that...

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
TODO

```
def shutdown():
        close()
        os.system("sudo halt")
        exit()
```

//--extra (advanced)
--------------------
To make more GPIO pins available one need to disable hdmi. See <http://www.logicsupply.com/blog/2013/07/18/disabling-the-beaglebone-black-hdmi-cape/>
