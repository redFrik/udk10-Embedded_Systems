#this sends an osc message to sc every second
#start it with 'python osctest.py &'

import time
import OSC

sc= OSC.OSCClient()
sc.connect(('127.0.0.1', 57120))
while True:
        msg= OSC.OSCMessage()
        msg.setAddress("/ping")
        msg.append(111)
        try:
                sc.send(msg)
        except:
                1+1 # dummy
        time.sleep(1)