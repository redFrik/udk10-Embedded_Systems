131128
======

_beaglebone black supercollider together with python_

//--copy files from laptop to bbb
---------------------------------
One way is to use scp. It stands for Secure CoPy and is built in to both your laptop (osx/linux) and the bbb (linux).

* on your laptop change to a directory (`cd`) where you have a file you'd like to copy to your bbb. Or create a temporary file with `echo "test" >> scptest.txt`
* `scp scptest.txt debian@192.168.1.53:/home/debian` # replace filename and ip
* now on the bbb cd to home directory (`cd ~`) and do `ls`. The file should be there
* `rm scptest.txt` # run on both laptop and bbb to delete the file

//--sending osc from python to sc
---------------------------------
Copy the two files [osctest.py](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131128/osctest.py) and [readsensors1.py](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131128/readsensors1.py) to the bbb.

* `scp osctest.py debian@192.168.1.53:/home/debian`
* `scp readsensors1.py debian@192.168.1.53:/home/debian`

Start jack if it isn't already running...

* `jackd -dalsa -dhw:1,0 -p1024 -n3 -s &`

Start osctest with...

* `python osctest.py &`
* `sclang`
* `OSCFunc.trace(true)` # this should start posting incoming 111 osc message once per second.

* `0.exit`
* `pkill python`

Start readsensors1 with...

* `sudo -b python readsensors1.py` # we need sudo because of gpio access
* `sclang`
* `OSCFunc.trace(true)` # again this should start posting a lot of incoming osc messages

* `0.exit`
* `sudo pkill python`

Now connect sensors to the pins listed in the readsensors python code. See pin connection diagram here... [http://www.alexanderhiam.com/blog/beaglebone-pinout/](https://web.archive.org/web/20141024082937/http://www.alexanderhiam.com/blog/beaglebone-pinout/) and also see instructions two weeks ago [here](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--second-python-program)

//--receiving osc in python
---------------------------
Copy the file [osctest2.py](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131128/osctest2.py) to the bbb.

* `python osctest2.py`

Then in supercollider on your laptop type this...

* `n= NetAddr("192.168.1.53", 10000)` # edit to match ip of bbb
* `n.sendMsg(\toPython, 123)`

The osctest2 python program should print out `[123]`. Stop it with ctrl+c.

//--extra: wlan/wifi
--------------------
Optional - if you have a wlan usb stick like [this](https://www.reichelt.de/wlan-adapter-usb-150-mbit-s-logilink-wl0084e-p169760.html?search=wl0084e)

* `sudo apt-get update`
* `sudo apt-get upgrade`
* `sudo apt-get install firmware-ralink firmware-realtek`
* `sudo pico /etc/network/interfaces`
* edit the last four lines to say...

```
auto wlan0
iface wlan0 inet dhcp
	wpa-ssid "your_wlan_name"
	wpa-psk "your_wlan_pass"
	wireless-power off
```

* `sudo ifdown wlan0`
* `sudo ifup wlan0`

It should say something like... "bound to 192.168.1.56 -- renewal in 243311 seconds." and the led on the wlan adapter will start blinking.

Now try to turn off the bbb (`sudo halt`), disconnect the ethernet cable, start up again and connect again using the new IP given (`ssh debian@192.168.1.56`). Note that it will take a while before you'll be able to log in - wait for the led to start blinking.

To connect the usb soundcard and wlan usb adapter at the same time, you'll need a small usb hub like [this](https://www.reichelt.de/nicht-mehr-lieferbar-manhattan-160599-p94684.html?r=1).

//--links
---------
* <https://www.cyberciti.biz/faq/debian-linux-wpa-wpa2-wireless-wifi-networking/> (advanced)
