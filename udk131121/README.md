131121
======

_beaglebone black setup sound and install supercollider_

//--install alsa and test sound
-------------------------------
This assume you've done all the instructions [previous](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114) week.
And that you have connected an usb soundcard with headphones/speaker.

* `sudo apt-get install alsa-base`
* `sudo depmod`
* `sudo adduser debian audio`
* `sudo reboot` # make sure usb audio adapter is inserted from here on
* `sudo aplay -l` # make sure usb audio is listed (should show two devices: hdmi and c-media (or whatever usb sound you're using))
* `speaker-test -Ddefault:CARD=Device` # should make some noise. stop with ctrl+c


//--install supercollider 3.4.5
-------------------------------
This installs an old version of sc...
* `sudo apt-get install supercollider` # accept jack realtime privileges when asked.

And patch jack (the one we just installed above is broken)...
* `wget -O - http://rpi.autostatic.com/autostatic.gpg.key| sudo apt-key add -`
* `sudo wget -O /etc/apt/sources.list.d/autostatic-audio-raspbian.list http://rpi.autostatic.com/autostatic-audio-raspbian.list`
* `sudo apt-get update`
* `sudo apt-get --no-install-recommends install jackd2`
* `sudo reboot`

//--start sc
------------
* `jackd -P 95 -d dummy -C 1 &`
* `alsa_out -d hw:1 2>&1 > /dev/null &`
* `sclang`
* `s.boot^L`
* `"jack_connect SuperCollider:out_1 alsa_out:playback_1 &".unixCmd^L`
* `"jack_connect SuperCollider:out_2 alsa_out:playback_2 &".unixCmd^L`
* `a={SinOsc.ar([400,404],0,0.1)}.play^L`
* `a.release^L`
* `0.exit^L`
* `pkill jackd`










//--install newest jack (temp)
-----------------------
We'll need the latest version of jack to run supercollider.  And to get it we must built it ourselves like this...

* `sudo apt-get install libsamplerate0-dev libasound2-dev libsndfile1-dev`
* `git clone git://github.com/jackaudio/jack2.git`
* `cd jack2`
* `./waf configure --alsa`
* `./waf build`
* `sudo ./waf install`
* `cd ..`
* `sudo rm -r jack2`
* `sudo ldconfig`
