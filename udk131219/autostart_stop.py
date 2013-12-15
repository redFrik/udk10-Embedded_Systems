import Adafruit_BBIO.GPIO as GPIO
import time
import os

GPIO.setup("P9_23", GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

while True:
	val= GPIO.input("P9_23")
	if val==1:
		os.system("sudo halt")
		exit()
	time.sleep(0.5)
