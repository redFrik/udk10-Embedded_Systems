#redFrik dec2013
import Adafruit_BBIO.GPIO as GPIO
import Adafruit_BBIO.PWM as PWM
import time
import OSC
import os
from twython import TwythonStreamer
import threading

#-- settings
off= "P9_23"
sw1= "P9_27"
sw2= "P9_30"
led1= "P9_14"
led2= "P9_16"
led3= "P9_21"
led4= "P9_22"
led5= "P8_13"
led6= "P8_19"
speed= 0.05
term= '@MFF_f0' # what to track on twitter
app_key= '<Your Consumer Key>' # edit
app_secret= '<Your Consumer Secret>' # edit
oauth_token= '<Your Access Token>' # edit
oauth_token_secret= '<Your Access Token Secret>' # edit

#-- setup
sc= OSC.OSCClient()
sc.connect(('127.0.0.1', 57120)) # send locally to sc
server= OSC.OSCServer(('0.0.0.0', 15555)) # receive osc
server.addDefaultHandlers()

GPIO.setup(off, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(sw1, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(sw2, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
PWM.start(led1, 0)
PWM.start(led2, 0)
PWM.start(led3, 0)
PWM.start(led4, 0)
PWM.start(led5, 0)
PWM.start(led6, 0)
offLast= -1
sw1Last= -1
sw2Last= -1

class OrfiStreamer(TwythonStreamer):
	def on_success(self, data):
		if 'text' in data:
			text= data['text'].encode('utf-8')
			#print text # debug
			sendOSC("/text", text)
class OrfiThread(threading.Thread):
	def run(self):
		print "tracking: "+term
		print "starting twitter streamer..."
		stream= OrfiStreamer(app_key, app_secret, oauth_token, oauth_token_secret)
		stream.statuses.filter(track=term)

def oscInput(addr, tags, stuff, source):
	led= [led1, led2, led3, led4, led5, led6][stuff[0]]
	PWM.set_duty_cycle(led, stuff[1]) # set led brightness (0-100)

server.addMsgHandler("/fromSC", oscInput)
server_thread= threading.Thread(target= server.serve_forever)
server_thread.start()

def test_digital():
	global offLast
	global sw1Last
	global sw2Last
	val= GPIO.input(off)
	if offLast!=val:
		offLast= val
		if val==1:
			sendOSC("/off", 1)	# send osc to turn off sound
			server.close()	# turn off osc input
			os.system("sudo halt") # turn off the bbb
			exit() # exit this python program
	val= GPIO.input(sw1)
	if sw1Last!=val:
		sw1Last= val
		sendOSC("/sw1", val) # send changed state to sc
	val= GPIO.input(sw2)
	if sw2Last!=val:
		sw2Last= val
		sendOSC("/sw2", val) # send changed state to sc

def sendOSC(address, val):
	msg= OSC.OSCMessage()
	msg.setAddress(address)
	msg.append(val)
	try:
		sc.send(msg) # send out osc
	except:
		pass # do nothing if seding failed
	#print msg # debug

def main():
	t= OrfiThread()
	t.start()
	sendOSC("/on", 1) # notify sc that python is running
	while True:
		test_digital()
		time.sleep(speed) # wait a little

if __name__=='__main__':
	try:
		main()
	except KeyboardInterrupt:
		server.close()
		server_thread.join()
