131121
======

_beaglebone black setup sound and install supercollider_

//--installing alsa and test sound
----------------------------------
This assume you've done all the instructions [previous](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114) week.

* `sudo apt-get install alsa-base`
* `sudo depmod`
* `sudo adduser debian audio`
* `sudo reboot`
* `speaker-test -Ddefault:CARD=Device`


