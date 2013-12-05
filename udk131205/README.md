131205
======

_beaglebone black as a standalone supercollider instrument_

The below instructions assume you've installed debian, python libraries, alsa, jack and supercollider. See previous weeks: [debian+python](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--preparation-first-time-only) and [alsa+jack+sc](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--install-alsa--test-sound).

The 'instrument' consists of two programs. One written in python and the other one in supercollider. Both programs must run on the beaglebone black at the same time for it all to work. The python program (called thursday.py) is reading inputs from sensors and then, if any values changed, sends osc data to a supercollider program (called thursday.scd). Both programs are templates and you should be able to modify them easily to suit your needs (number of sensors and sound synthesis).

//--fm algorithms
-----------------
First an introduction to frequency modulation ([fm](http://en.wikipedia.org/wiki/Fm_synth)):

On your laptop, open and check the files [fm_algorithms1.scd](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/fm_algorithms1.scd) and [fm_algorithms2.scd](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/fm_algorithms2.scd) from todays material. Try out different patches and note the difference in how the oscillators are connected.

Try to replace `.add` with `.draw` to see a graphical overview over the oscillators. You will first need to install the rd_dot quark and graphviz (<http://www.graphviz.org>). I use version 2.34 on my mac osx 10.9.

To install the rd_dot quark you'd type... `Quarks.checkoutAll` and `Quarks.install("rd_dot");` in supercollider (on your laptop) and then press 'p' when asked by the Terminal. Then if it worked and installed successfully, recompile sclang. Test it with `{SinOsc.ar}.draw;`. That line should have opened a window in graphviz that shows a connection diagram. Note: on mac osx you might need to force all filetypes of the type .dot open in graphviz. Do this by selecting a .dot file and get info in Finder - select open with... graphviz and apply for every file.

//--download files to bbb
-------------------------
First log in to your beaglebone black and get the two files thursday.py and thursday.scd onto there.
Either copy them from your laptop with scp (see [last week](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--copy-files-from-laptop-to-bbb)), or get them directly from github like this...

* `wget https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/thursday.py`
* `wget https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/thursday.scd`
* `ls` # list directory and show the files - double check that they are there

Note: you can use the -N flag if you wish to overwrite an old file with the same name.

Also note that if you get the 'WARNING: The certificate of raw.github.com is not trusted.' message, then set the wget flag `--no-check-certificate`.

//--starting the instrument
---------------------------
Make sure an usb sound adapter is connected.

* `jackd -dalsa -dhw:1,0 -p1024 -n3 -s &`
* `sudo -b python thursday.py`
* `sclang thursday.scd`

That should start sc and play a little startup jingle. And then you should be able to connect sensors and make noise. Stop with ctrl+c.

//--connect sensors
-------------------
This thursday 'instrument' uses by default two analog and two digital sensors. To play you'll need to connect digital sensors (buttons/switches etc) to P9_41 and P9_42, and analog sensors (pots/sliders/light etc) to P9_39 and P9_40.

Note: be extra careful when connecting. If you connect sensors to the wrong place (5v), it can DESTROY the board. Double check and make sure you have the right side up etc.

Also note that it's usually safest to turn off the beaglebone first before making the connections.

![thursdayHardware](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131205/thursdayHardware.gif)

Now one of the two digital sensors should be starting and stopping the sound (by controlling the amplitude), and the other sensors set different parameters that changes the sound. The sound is a fm-synth based on one of the the fm_algorithms above.

//--customizing the sound
-------------------------
The mapping of sensor values to sound parameters can be easily changed. You can exchange sensors or give them different functionality by editing the scd file in supercollider (using pico locally or edit it on your laptop and then upload via scp).

This part of the code is for mapping. Edit some things there and change values to see what happens.

```
//--map controllers - customize here
var freq0= 400;
var amp0= a1.lag(0.1);
var freq1= 500;
var amp1= 200;
var freq2= 600;
var amp2= (d0+0.1).lag2(0.1)*300;
var freq3= a0.lag(1);
var amp3= 800;
var amp= d1.lagud(0.01, 0.5);
```

If you know supercollider you can of course write your own sound synthesis from scratch, or adapt some old code you have.

//--customizing the hardware
----------------------------
You can also easily add more sensors. Then change in the thursday.py file and add the ones you need under settings. Here we add two more analog (total 4) and 1 more digital (total 3)...

```
analog_sensors= ["P9_39", "P9_40", "P9_37", "P9_38"] # customize here and add your own sensors
digital_sensors= ["P9_41", "P9_42", "P9_31"] # customize here  and add your own sensors
```

and then you also need to change in the thursday.scd file and add the inputs there...

```
//also here adding 2 analog and 1 digital
|p9_39= 900, p9_40= 900, p9_37= 900, p9_38= 900, p9_41= 0, p9_42= 0, p9_31= 0| //arguments - add more

//--make variables from arguments - add more below
var a0= p9_39;//analog 0
var a1= p9_40;//analog 1
var a2= p9_37;//analog 2
var a3= p9_38;//analog 3
var d0= p9_41;//digital 0
var d1= p9_42;//digital 1
var d2= p9_31;//digital 2
```

See the schematics for pin numbers. (Note that some pins might not be available - read up on overlay online if some pin doesn't work)

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
