131121
======

_beaglebone black setup sound and install supercollider_

This time we will install supercollider and some required extras like jack.
Some of the commands will take quite a long time, so in between we will write small python programs on our laptops.

The below assume you've done all the instructions from [previous](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114) week.

//--install alsa + test sound
-----------------------------
Connect the ethernet cable and power like last week and make sure you have connected the usb soundcard and headphones/speaker.  The soundcard i used is [this](http://dx.com/p/virtual-5-1-surround-usb-2-0-external-sound-card-22475) one, but it should also work with higher quality usb adapters.

* `sudo apt-get install alsa-base`
* `sudo depmod`
* `sudo adduser debian audio`
* `sudo reboot` # make sure usb audio adapter is inserted before this reboot - avoid hot-plugging
* `sudo aplay -l` # make sure generic usb audio device is listed (should show two devices: hdmi and generic usb)
* `speaker-test -Ddefault:CARD=Device` # should make some noise. stop with ctrl+c

//--install jack
----------------
To run supercollider we first need to manually install and build the latest jackd...

* `sudo apt-get install build-essential git libsamplerate0-dev libasound2-dev libsndfile1-dev`
* `git clone git://github.com/jackaudio/jack2.git`
* `cd jack2`
* `./waf configure --alsa`
* `./waf build` # this takes a while
* `sudo ./waf install`
* `cd ..`
* `sudo rm -r jack2`
* `sudo ldconfig`
* `sudo reboot`

//--install supercollider 3.7alpha0
-----------------------------------
This builds and installs supercollider...

* `sudo apt-get install cmake libavahi-client-dev libicu-dev libreadline-dev libfftw3-dev libxt-dev`
* `git clone --recursive git://github.com/supercollider/supercollider.git supercollider`
* `cd supercollider`
* `git checkout ddd8c8d75dd00263acf593b062ecbb06686a4574` # an older version from summer2013 that still can be compiled with gcc
* `git submodule init && git submodule update`
* `mkdir build && cd build`
* `cmake -L -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DSSE=OFF -DSSE2=OFF -DSUPERNOVA=OFF -DNOVA_SIMD=ON -DNATIVE=OFF -DSC_QT=OFF -DSC_WII=OFF -DSC_ED=OFF -DSC_IDE=OFF -DSC_EL=OFF -DCMAKE_C_FLAGS="-march=armv7-a -mtune=cortex-a8 -mfloat-abi=hard -mfpu=neon" -DCMAKE_CXX_FLAGS="-march=armv7-a -mtune=cortex-a8 -mfloat-abi=hard -mfpu=neon" ..`
* `make` # this takes a while
* `sudo make install`
* `cd ../..`
* `sudo rm -r supercollider`
* `sudo ldconfig`
* `sudo reboot`

//--start sc
------------
Finally we can start sc and make sound.

1. `jackd -dalsa -dhw:1,0 -p1024 -n3 -s &`
2. `sclang` # ignore the error "ERROR: No GUI scheme active" - it is harmless.
3. `s.boot;`
4. `a= {SinOsc.ar([400, 404], 0, 0.1)}.play;`
5. `s.dump;`
6. `a.free;`
7. `s.quit;`
8. `0.exit;`
9. `pkill jackd`

Note: if the sound is distorted you may need to reboot and try again.

//--get low latency audio
-------------------------
To run jack in realtime and get lower latency (faster response in the sound), you'll need to do the following...

1. `sudo pico /etc/security/limits.conf`
2. and add the following lines somewhere before it says end of file.
3.    `@audio - memlock 256000`
4.    `@audio - rtprio 99`
5.    `@audio - nice -19`
6. save and exit with ctrl+o, ctrl+x
7. `sudo reboot` # after reboot start sc again like in previous step

Note: to get low latency you'll need to decrease the blocksize when you start jack. Try with `-p128` instead of `-p1024` and listen if you have a clean undistorted sound. You can also try `-p256` or `-p512` if 128 is too low.

//--backup
----------
When all the above is working i'd recommend to do a backup of your sd card.  On osx it's easy to do with [PiCopier](http://ivanx.com/raspberrypi/). Then if anything break you can restore your system from this backup with Pi Filler (same as we did writing the original disk image last week).

//--loading files
-----------------
To run supercollider code from a textfile, you write the code on your laptop, save it to a .scd file and copy it over.

A simple example .scd file could look like this...
```
s.waitForBoot({
	a= {SinOsc.ar([400, 404], 0, 0.1)}.play;
});
```

You can copy files with the scp command. Example:
`scp mycode.scd debian@192.168.1.54:/home/debian/` # run from your laptop
This will copy the file mycode.scd from current directory over to the bbb and put it in the debian home folder.

To run the file on the bbb do the following...

1. `jackd -dalsa -dhw:1,0 -p1024 -n3 -s &`
2. `sclang mycode.scd`

//--extra
---------
Some simple python experiments. Type `pico mylittleprogram.py` and add this...
```python
import time

str= "hello udk!"
cnt= 0

while True:
        out= ""
        abc= 60 
        while abc>0:
                out= out+str[(cnt+abc)%10]
                abc= abc-1
        print out        
        cnt= cnt+2
        time.sleep(0.05)
```
Then press ctrl+o and ctrl+x to save and exit. Run the python program with...
`python mylittleprogram.py`
And stop with ctrl+c

//--links:
----------
* <http://supercollider.github.io/development/building-beagleboneblack.html> here i put the same thing but a bit simplified
* <http://learnpythonthehardway.org/book/>
* <http://www.eliteraspberries.com/blog/2013/09/installing-debian-on-the-beaglebone-black.html> more advanced info about installing debian on bbb
* <http://nodebox.net/code/index.php/Home> nice python 2d graphics program
