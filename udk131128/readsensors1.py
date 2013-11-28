#this will read 2 analog sensors and 2 digital and send locally to sc
#start it with 'sudo python readsensors1.py &'

import Adafruit_BBIO.ADC as ADC
import Adafruit_BBIO.GPIO as GPIO
import time
import OSC

ADC.setup()
lastadc0= -1
lastadc1= -1
GPIO.setup("P9_41", GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup("P9_42", GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
lastdig0= -1
lastdig1= -1
sc= OSC.OSCClient()
sc.connect(('127.0.0.1', 57120)) #send locally to sc

def sendOSC(name, val):
	msg= OSC.OSCMessage()
	msg.setAddress(name)
	msg.append(val)
	try:
		sc.send(msg)
	except:
		1+1 # dummy
	#print msg

while True:
	val= int(ADC.read_raw("P9_39")) # 0-1799
	if val!=lastadc0:
		sendOSC("/adc0", val)
		lastadc0= val
	val= int(ADC.read_raw("P9_40")) # 0-1799
	if val!=lastadc1:
		sendOSC("/adc1", val)
		lastadc1= val
	val= GPIO.input("P9_41")
	if val!=lastdig0:
		sendOSC("/dig0", val)
		lastdig0= val
	val= GPIO.input("P9_42")
	if val!=lastdig1:
		sendOSC("/dig1", val)
		lastdig1= val
	
	time.sleep(0.05) # update rate
