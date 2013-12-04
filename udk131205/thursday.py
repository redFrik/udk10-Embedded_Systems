#a simple beaglebone black instrument, a/v, embedded systems, udk
#see https://github.com/redFrik/udk10-Embedded_Systems

#this will read analog and digital sensors and send osc data locally to sc
#start it with 'sudo python thursday.py'

import Adafruit_BBIO.ADC as ADC
import Adafruit_BBIO.GPIO as GPIO
import time
import OSC

#-- settings
update_rate= 0.05 # time in seconds between each reading
analog_sensors= ["P9_39", "P9_40"]
digital_sensors= ["P9_41", "P9_42"]

ADC.setup()
for sensor in digital_sensors:
	GPIO.setup(sensor, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
sc= OSC.OSCClient()
sc.connect(('127.0.0.1', 57120)) # send locally to sc

def sendOSC(address, name, val):
	msg= OSC.OSCMessage()
	msg.setAddress(address)
	msg.append(name)
	msg.append(val)
	try:
		sc.send(msg) # send out osc
	except:
		pass # do nothing if seding failed
	#print msg # debug

def main():
	while True:
		for sensor in analog_sensors:
			val= int(ADC.read_raw(sensor)) # 0-1799
			sendOSC("/ana", sensor, val)
		for sensor in digital_sensors:
			val= GPIO.input(sensor)
			sendOSC("/dig", sensor, val)
		time.sleep(update_rate)

if __name__=='__main__':
	main()
