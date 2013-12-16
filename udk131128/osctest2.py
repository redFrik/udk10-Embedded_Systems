#this receives osc messages "/toPython" on port 10000 from anywhere and prints
#start it with 'python osctest2.py' and stop with ctrl+c
#test sending from sc with n= NetAddr(bbb_ip, 10000); n.sendMsg(\toPython, 123)

import time
import OSC
import threading

server= OSC.OSCServer(('0.0.0.0', 10000))
server.addDefaultHandlers()
def oscInput(addr, tags, stuff, source):
	print str(stuff)

server.addMsgHandler("/toPython", oscInput)
server_thread= threading.Thread(target= server.serve_forever)
server_thread.start()

try:
	while True:
		time.sleep(1)

except KeyboardInterrupt:
	pass

server.close()
server_thread.join()
