131205
======

_beaglebone black as a standalone supercollider instrument_

The below assume you've installed debian, python libraries, alsa, jack and supercollider i.e. followed the instructions from previous weeks ([debian+python](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114) and [alsa+jack+sc](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121)).

//--download files to bbb
-------------------------
First log in to you beaglebone black and get the two files thursday.py and thursday.scd.
Either copy them from your laptop with scp (see [last week](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--copy-files-from-laptop-to-bbb)), or get them directly from github like this...

* `wget http://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/thursday.py`
* `wget http://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/thursday.scd`

//--extra
---------
As always it is recommended to change the default password.

* `sudo passwd debian`
