140130
======

_own projects_


//--11 digital inputs
---------------------
an example of how to read 11 digital inputs with python and send to supercollider via osc.
connect 11 digital sensors to the pins listed under settings and make them go to 3v3 (they are pulled to ground and this program detects high values).

NOTE: it's very important to connect to 3v3 volt (and not 5v)!
see pinout diagram here... <http://www.alexanderhiam.com/blog/beaglebone-pinout/>

* `pico eleven_digital.py`
* paste the following python code and save and exit (ctrl+o, ctrl+x)

```
# reading 11 digital inputs and send over to sc via osc
# not very compact code - written for clarity
import Adafruit_BBIO.GPIO as GPIO
import time
import OSC

# settings - which pins to use
pin00= "P8_13"
pin01= "P8_14"
pin02= "P8_15"
pin03= "P8_16"
pin04= "P8_17"
pin05= "P8_18"
pin06= "P9_23"
pin07= "P9_27"
pin08= "P9_30"
pin09= "P9_41"
pin10= "P9_42"

GPIO.setup(pin00, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin01, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin02, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin03, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin04, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin05, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin06, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin07, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin08, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin09, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(pin10, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

lastpin00= -1
lastpin01= -1
lastpin02= -1
lastpin03= -1
lastpin04= -1
lastpin05= -1
lastpin06= -1
lastpin07= -1
lastpin08= -1
lastpin09= -1
lastpin10= -1

sc= OSC.OSCClient()
sc.connect(('127.0.0.1', 57120)) #send locally to sc

def sendOSC(name, val):
	msg= OSC.OSCMessage()
	msg.setAddress(name)
	msg.append(val)
	try:
		sc.send(msg)
	except:
		pass
	print msg #debug

while True:
	val= GPIO.input(pin00)
	if val!=lastpin00:
		sendOSC("/pin00", val)
		lastpin00= val
	
	val= GPIO.input(pin01)
	if val!=lastpin01:
		sendOSC("/pin01", val)
		lastpin01= val
		
	val= GPIO.input(pin02)
	if val!=lastpin02:
		sendOSC("/pin02", val)
		lastpin02= val
	
	val= GPIO.input(pin03)
	if val!=lastpin03:
		sendOSC("/pin03", val)
		lastpin03= val
	
	val= GPIO.input(pin04)
	if val!=lastpin04:
		sendOSC("/pin04", val)
		lastpin04= val
	
	val= GPIO.input(pin05)
	if val!=lastpin05:
		sendOSC("/pin05", val)
		lastpin05= val
	
	val= GPIO.input(pin06)
	if val!=lastpin06:
		sendOSC("/pin06", val)
		lastpin06= val
	
	val= GPIO.input(pin07)
	if val!=lastpin07:
		sendOSC("/pin07", val)
		lastpin07= val
	
	val= GPIO.input(pin08)
	if val!=lastpin08:
		sendOSC("/pin08", val)
		lastpin08= val
	
	val= GPIO.input(pin09)
	if val!=lastpin09:
		sendOSC("/pin09", val)
		lastpin09= val
	
	val= GPIO.input(pin10)
	if val!=lastpin10:
		sendOSC("/pin10", val)
		lastpin10= val
	
	time.sleep(0.05) # update rate
```

* run the above in the background with `sudo python eleven_digital.py &`
* `pico eleven_digital.scd`
* paste the following supercollider code and save and exit (ctrl+o, ctrl+x)

```
//code for receiving 11 digital inputs
s.waitForBoot{
	Ndef(\snd00, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 11, amp.lag(0.1))!2}).play;
	Ndef(\snd01, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 10, amp.lag(0.1))!2}).play;
	Ndef(\snd02, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 9, amp.lag(0.1))!2}).play;
	Ndef(\snd03, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 8, amp.lag(0.1))!2}).play;
	Ndef(\snd04, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 7, amp.lag(0.1))!2}).play;
	Ndef(\snd05, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 6, amp.lag(0.1))!2}).play;
	Ndef(\snd06, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 5, amp.lag(0.1))!2}).play;
	Ndef(\snd07, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 4, amp.lag(0.1))!2}).play;
	Ndef(\snd08, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 3, amp.lag(0.1))!2}).play;
	Ndef(\snd09, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 2, amp.lag(0.1))!2}).play;
	Ndef(\snd10, {|freq= 0, amp= 0| Blip.ar(freq.lag(1), 1, amp.lag(0.1))!2}).play;
	OSCFunc({|msg| Ndef(\snd00).set(\freq, 400*msg[1], \amp, 0.1*msg[1])}, \pin00);
	OSCFunc({|msg| Ndef(\snd01).set(\freq, 500*msg[1], \amp, 0.1*msg[1])}, \pin01);
	OSCFunc({|msg| Ndef(\snd02).set(\freq, 600*msg[1], \amp, 0.1*msg[1])}, \pin02);
	OSCFunc({|msg| Ndef(\snd03).set(\freq, 700*msg[1], \amp, 0.1*msg[1])}, \pin03);
	OSCFunc({|msg| Ndef(\snd04).set(\freq, 800*msg[1], \amp, 0.1*msg[1])}, \pin04);
	OSCFunc({|msg| Ndef(\snd05).set(\freq, 900*msg[1], \amp, 0.1*msg[1])}, \pin05);
	OSCFunc({|msg| Ndef(\snd06).set(\freq, 1000*msg[1], \amp, 0.1*msg[1])}, \pin06);
	OSCFunc({|msg| Ndef(\snd07).set(\freq, 1100*msg[1], \amp, 0.1*msg[1])}, \pin07);
	OSCFunc({|msg| Ndef(\snd08).set(\freq, 1200*msg[1], \amp, 0.1*msg[1])}, \pin08);
	OSCFunc({|msg| Ndef(\snd09).set(\freq, 1300*msg[1], \amp, 0.1*msg[1])}, \pin09);
	OSCFunc({|msg| Ndef(\snd10).set(\freq, 1400*msg[1], \amp, 0.1*msg[1])}, \pin10);
}
```

* start jack
* `sclang eleven_digital.scd`
