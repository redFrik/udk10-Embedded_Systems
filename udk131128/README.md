131128
======

_beaglebone black supercollider together with python_

scp

osc

etc

//--extra
---------
Optional - if you have a wlan usb stick like [this](http://www.reichelt.de/WLAN-Adapter/LOGILINK-WL0084B/3/index.html?&ACTION=3&LA=5&ARTICLE=120745&GROUPID=770&artnr=LOGILINK+WL0084B)

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
Now try to connect from a new terminal window `ssh debian@192.168.1.56` and if that works you can unplug the ethernet cable.


//--links
---------
* <http://www.cyberciti.biz/faq/debian-linux-wpa-wpa2-wireless-wifi-networking/>

