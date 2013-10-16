131017
======

* links previous semesters... <http://redfrik.github.io/udk00-Audiovisual_Programming/>
* and dates + times for this course... <https://github.com/redFrik/udk10-Embedded_Systems>
* this first time we will play with raspberry pi, but then concentrate on beaglebone black
* no need to buy any hardware - the mini computers and other stuff will be provided as a loan

_raspberry pi overview, introduction, ssh login, getting around and making sound_

* cheap linux computer
* really good video playback
* ok for connecting sensors and controlling leds+motors etc.
* sound support is not so good
* lots of material online - books, reference projects, blogs, forums

====================

//--4 channel video player
--------------------
for the dance piece Ich(a) by Zufit Simon
<http://tanzforumberlin.de/trailer369.php>
<http://www.fredrikolofsson.com/f0blog/?q=node/593>
i needed a way to send out 4 separate hi-quality video streams.  the videos didn't need to play back in frame sync, but they had to have a manual trigger to go to black and start the next video.
on the board is a small python program that starts automatically.  it reads a button and uses omxplayer to cycle between mp4 files.  the black out is just a short mp4 with only black frames.
see link for the python code and schematics.

//--32 channel pwm led driver
--------------------
for the piece redAlert.
here i used model A because it is cheaper but mainly because it requires less current.  without the leds the rpi + wlan + driver circuit draws 360mA.  with all the 32*3 leds turned on it's 1000mA total.

====================

//--operating systems
there are many different ones.  i can recommend the standard raspbian <http://www.raspberrypi.org/downloads>

or for a minimal headless (no windows, gui etc - only terminal) install you can try moebius <http://moebiuslinux.sourceforge.net>

and another system with preinstalled music software is satellite <https://ccrma.stanford.edu/wiki/Satellite_CCRMA_First_Steps>

====================

//--minimum requirements
--------------------
below is what's required for booting up and logging in via ssh.
* a raspberry pi.  i recommend a model B to start with.  this is the most common one and easiest to get started with.  model A lacks ethernet and that makes it harder to install new software and communicate with (can be solved with a wlan usb dongle).  often i use a model B for developing and then when the system/code is finished, i move the sd card over to a model A.  just watch out for the ram memory difference (512 vs 256mb).
* a power 5v supply with micro usb connector that can provide >700mA.  it might work to power it from your laptop (max 500mA) but that's not a good idea.  maybe you already have an usb charger that can be used.
* ethernet cable
* sd card of 4gb or more.  4gig is plenty and very rarely will you need a bigger one.  also don't care much about different sd card classes and speeds (extreme, 2, 4, 6, 10 etc).  write speed won't make such a big difference.  instead it's better to get a card from a good brand - stay away from cheap no-name brands.

additional stuff if you want to use it like a standalone computer...
* usb keyboard and usb mouse
* hdmi cable and screen/projector (also works with rca composite video)
* usb hub
* usb soundcard

//--basic preparation and startup
--------------------
you will need to do a few things before booting the pi for the first time...
* download an operating system (here we will use Raspbian)
* put the os on a sd card (on osx it is easiest with Pi Filler <http://ivanx.com/raspberrypi/>)
* connect ethernet and 5v power to the pi
* find the ip address of the rpi (on osx it is easy with the free app lanscan <http://www.iwaxx.com/lanscan/>), or look in your router settings (web admin/settings pages).
* (on osx you can also connect the pi directly to you mac via ethernet and turn internet sharing on.  then figure out the ip with lanscan or ping broadcast.)

logging in for the first time:
* `ssh pi@192.168.1.53`
* default password for raspbian is `raspberry`
* `sudo raspi-config` and select expand file system and optionally change password.  then select finish and let the rpi reboot.
* after reboot log in again with ssh
* `sudo apt-get update` to go online and check for software updates
* `sudo apt-get upgrade` to install any software updates (these two are good to run once in a while)

ssh troubleshooting:
* if you get...
`ssh: connect to host 192.168.1.11 port 22: Operation timed out`
then likely the ip is wrong or the rpi isn't powered.
* if you get...
`@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@`
`@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @`
`@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@`
`IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!`
`Someone could be eavesdropping on you right now (man-in-the-middle attack)!`
`It is also possible that a host key has just been changed.`
`The fingerprint for the RSA key sent by the remote host is`
`xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx.`
`Please contact your system administrator.`
`Add correct host key in /Users/Stirling/.ssh/known_hosts to get rid of this message.`
`Offending RSA key in /Users/Stirling/.ssh/known_hosts:35`
`RSA host key for 192.168.1.53 has changed and you have requested strict checking.`
`Host key verification failed.`
on your laptop while trying to log in then no worries.  just reset the ssh key with the following command.
* `ssh-keygen -R 192.168.1.53`

//--running sc on rpi raspbian
--------------------
2013-09-25-wheezy-raspbian.img comes with sc3.4.5 installed.
* `$ ssh pi@192.168.1.53`
* `$ jackd -P 95 -p 32 -d dummy -C 1 &`
* `$ alsa_out -d hw:1 2>&1 > /dev/null &` use hw:1 for usb soundcard, and hw:0 for internal onboard sound
* `$ sclang`
* `> s.boot`
* `> "jack_connect SuperCollider:out_1 alsa_out:playback_1 &".unixCmd`
* `> "jack_connect SuperCollider:out_2 alsa_out:playback_2 &".unixCmd`
* `> a={SinOsc.ar([400,404],0,0.1)}.play`
* `> a.release`
* `> 0.exit`
* `$ pkill jackd`

note:
* lines beginning with a $ means terminal
* lines beginning with a > means it's within sclang and should be executed with a ^L+return in the end (ctrl+L on osx).

//--links
--------------------
some random projects...
* <http://www.gundersen.net/raspberry-pi-making-it-slimmer/>
* <http://www.makeuseof.com/tag/how-to-build-a-raspberry-pi-twitter-bot/>
* <http://www.youtube.com/watch?v=KYO9N4kDK_o> (sonic pi is a simplified supercollider)
