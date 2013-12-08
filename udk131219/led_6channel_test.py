# simple program to fade 6 leds (pwm) on a beaglebone black
# note: must use transistors or uln2803a to protect the pins

import Adafruit_BBIO.PWM as PWM
import time

# settings
led1= "P9_14"
led2= "P9_16"
led3= "P9_21"
led4= "P9_22"
led5= "P8_13"
led6= "P8_19"
speed= 0.01

PWM.start(led1, 0)
PWM.start(led2, 0)
PWM.start(led3, 0)
PWM.start(led4, 0)
PWM.start(led5, 0)
PWM.start(led6, 0)

for j in range(4): # do 4 times
        time.sleep(2) # wait 2sec
        for i in range(100, -1, -1): # count from 100 to 0
                PWM.set_duty_cycle(led1, i) # set led brightness
                time.sleep(speed) # wait a little
        for i in range(100, -1, -1):
                PWM.set_duty_cycle(led2, i)
                time.sleep(speed)
        for i in range(100, -1, -1):
                PWM.set_duty_cycle(led3, i)
                time.sleep(speed)
        for i in range(100, -1, -1):
                PWM.set_duty_cycle(led4, i)
                time.sleep(speed)
        for i in range(100, -1, -1):
                PWM.set_duty_cycle(led5, i)
                time.sleep(speed)
        for i in range(100, -1, -1):
                PWM.set_duty_cycle(led6, i)
                time.sleep(speed)

PWM.stop(led1)
PWM.stop(led2)
PWM.stop(led3)
PWM.stop(led4)
PWM.stop(led5)
PWM.stop(led6)
PWM.cleanup()
