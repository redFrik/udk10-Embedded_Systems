131205
======

_beaglebone black as a standalone supercollider instrument_

The below instructions assume you've installed debian, python libraries, alsa, jack and supercollider. See previous weeks: [debian+python](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--preparation-first-time-only) and [alsa+jack+sc](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--install-alsa--test-sound).

The 'instrument' consists of two programs. One written in python and the other one in supercollider. Both programs must run on the beaglebone black at the same time for it all to work. The python program (called thursday.py) is reading inputs from sensors and then, if any values changed, sends osc data to supercollider (called thursday.scd). Both programs are templates and you should be able to modify them easily to suit your needs (number of sensors and sound synthesis).

//--download files to bbb
-------------------------
First log in to you beaglebone black and get the two files thursday.py and thursday.scd.
Either copy them from your laptop with scp (see [last week](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--copy-files-from-laptop-to-bbb)), or get them directly from github like this...

* `wget http://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/thursday.py`
* `wget http://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/thursday.scd`
* `ls` # list directory and show the files - double check that they are there

//--starting the instrument
---------------------------
Make sure an usb sound adapter is connected.

* `jackd -dalsa -dhw:1,0 -p1024 -n3 -s &`
* `sudo python thursday.py &`
* `sclang thursday.scd`

That should start sc and play a little startup jingle.

//--connect sensors
-------------------
This thursday 'instrument' uses by default two analog and two digital sensors. To play you'll need to connect digital sensors (buttons/switches etc) to P9_41 and P9_42, and analog sensors (pots/sliders/light etc) to P9_39 and P9_40.

Note: be extra careful when connecting. If you connect sensors to the wrong place (5v), it can DESTROY the board. Double check and make sure you have the right side up etc.

![thursdayHardware](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/thursdayHardware.gif)

//--customizing the sound
-------------------------



//--customizing the hardware
----------------------------


//--quitting
------------
Quit supercollider by pressing `ctrl+c` and then do...

* `sudo pkill python`
* `pkill jackd`
* `sudo halt` # turns off the bbb

//--extra
---------
As always it is recommended to change the default password.

* `sudo passwd debian`
