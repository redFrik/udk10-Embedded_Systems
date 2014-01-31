udk-avprogramming 2013-2014_WS
==============================

Olofsson: Audiovisual programming - Embedded Systems

Fast, small and cheap linux computers have recently become widely available. In this course we will experiment with two of them: the [BeagleBone Black](http://beagleboard.org/Products/BeagleBone%20Black) and the [Raspberry Pi](http://raspberrypi.org). The plan is to use these platforms as stepping stones for learning about programming, networks, electronics and more. And the general goal is to build small wireless systems that do interesting stuff.
In more detail we will try connecting sensor across the internet, code synthetic sound in SuperCollider, embed computers into soft material and find suitable batteries and speakers for it all. The software put to use will mainly be SuperCollider and Python. The hardware will be provided as a loan.

room111, UdK, medienhaus, kleistpark

dates
-----
- [x] [17oct 14-16](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131017): raspberry pi overview, introduction, ssh login, getting around and making sound:
	- [4-channel-video-player](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131017#--4-channel-video-player)
	- [96-channel-pwm-led-driver](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131017#--96-channel-pwm-led-driver)
	- [operating-systems](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131017#--operating-systems)
	- [minimum-requirements](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131017#--minimum-requirements)
	- [basic-preparation-and-startup](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131017#--basic-preparation-and-startup)
	- [running-sc-on-rpi-raspbian](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131017#--running-sc-on-rpi-raspbian)
	- [links](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131017#--links)
- [ ] [24oct] **NO CLASS** (design workshop)
- [ ] 31oct: **NO CLASS**
- [ ] 07nov: **NO CLASS**
- [x] [14nov 14-16](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114): beaglebone black overview, debian setup and installation:
	[preparation-first-time-only](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--preparation-first-time-only),
	[startup](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--startup),
	[logging-in](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--logging-in),
	[installing-software](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--installing-software),
	[a-simple-python-program](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--a-simple-python-program),
	[second-python-program](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--second-python-program),
	[third-program](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--third-program),
	[send-osc-example](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--send-osc-example),
	[turning-off](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--turning-off),
	[links](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131114#--links)
- [x] [21nov 14-16](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121): beaglebone black setup sound and install supercollider:
	[install-alsa--test-sound](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--install-alsa--test-sound),
	[install-jack](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--install-jack),
	[install-supercollider-37alpha0](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--install-supercollider-37alpha0),
	[start-sc](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--start-sc),
	[get-low-latency-audio](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--get-low-latency-audio),
	[backup](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--backup),
	[loading-files](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--loading-files),
	[extra](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--extra),
	[links](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131121#--links)
- [x] [28nov 14-16](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128): beaglebone black supercollider together with python:
	[copy-files-from-laptop-to-bbb](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--copy-files-from-laptop-to-bbb),
	[sending-osc-from-python-to-sc](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--sending-osc-from-python-to-sc),
	[receiving-osc-in-python](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--receiving-osc-in-python),
	[extra-wlanwifi](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--extra-wlanwifi),
	[links](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131128#--links)
- [x] [05dec 14-16](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205): beaglebone black as a standalone supercollider instrument:
	[fm-algorithms](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205#--fm-algorithms),
	[download-files-to-bbb](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205#--download-files-to-bbb),
	[starting-supercollider](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205#--starting-supercollider),
	[connect-sensors](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205#--connect-sensors),
	[customizing-thursday-sound](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205#--customizing-thursday-sound),
	[customizing-thursday-hardware](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205#--customizing-thursday-hardware),
	[quitting](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205#--quitting),
	[extra-change-password](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131205#--extra-change-password)
- [x] [12dec 14-16](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212): arduino and supercollider together plus sensors, prepare own projects
	[arduino-hardware](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--arduino-hardware),
	[arduino-ide](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--arduino-ide),
	[programming-the-board](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--programming-the-board),
	[serial-communication-arduino---laptop](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--serial-communication-arduino---laptop),
	[digital-inputs](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--digital-inputs),
	[analog-inputs](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--analog-inputs),
	[serial-communication-laptop---arduino](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--serial-communication-laptop---arduino),
	[digital-outputs](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--digital-outputs),
	[pwm-analog-outputs](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--pwm-analog-outputs),
	[reading-sensors-in-sc](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--reading-sensors-in-sc),
	[controlling-leds-from-sc](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--controlling-leds-from-sc),
	[extra-emf](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--extra-emf),
	[extra-ldr](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--extra-ldr),
	[extra-pd](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--extra-pd),
	[links](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131212#--links)
- [x] [19dec 14-16](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219): more about sensors, beaglebone black, twitter, present own project ideas
	[autostart](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219#--autostart),
	[autostart-jack-and-sc](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219#--autostart-jack-and-sc),
	[turning-off-with-a-button](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219#--turning-off-with-a-button),
	[thursday-instrument-autostart](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219#--thursday-instrument-autostart),
	[orfi_twitter](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219#--orfi_twitter),
	[extra-disable-hdmi](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219#--extra-disable-hdmi),
	[extra-hearbeat](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219#--extra-hearbeat),
	[extra-power-consumption](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk131219#--extra-power-consumption)
- [ ] 26dec: **NO CLASS**
- [ ] 02jan: **NO CLASS**
- [x] [09jan 14-17](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140109): own projects
	[arduino-to-supercollider](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140109#--arduino-to-supercollider),
	[relay](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140109#--relay),
	[rotary](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140109#--rotary),
- [x] [16jan 14-17](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140116): own projects
	[using-hid-in-bbb](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140116#--using-hid-in-bbb),
	[rotary-encoder](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140116#--rotary-encoder)
- [x] [23jan 14-17](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140123): own projects
	[start-stop-button](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140123#--start-stop-button),
	[servo-with-bbb](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140123#--servo-with-bbb),
	[reflashing-the-emmc](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140123#--reflashing-the-emmc)
- [x] [30jan 14-17](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140130): own projects
	[11-digital-inputs](https://github.com/redFrik/udk10-Embedded_Systems/tree/master/udk140130#--11-digital-inputs)
- [ ] [06feb 14-17] own projects
- [ ] 13feb: **NO CLASS**

links to previous semesters... <http://redfrik.github.io/udk00-Audiovisual_Programming/>
