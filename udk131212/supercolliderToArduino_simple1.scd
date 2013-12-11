//--use with supercolliderToArduino_simple.ino
//these examples controls a led from a routine

SerialPort.listDevices;//this will post available ports. copy the name from here to the line below

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
var counter= 0;
Routine.run({
	2.wait;
	inf.do{
		port.put(counter.postln);
		counter= counter+1;
		if(counter>255, {
			counter= 0;
		});
		0.01.wait;
	};
});
CmdPeriod.doOnce({port.close});
)


//--

//note the brightness curvature - there is not much change in the upper values (128-255) as in the lower (0-...)
//to compensate for that and make the led fade better, we can apply our own curvature

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
var counter= 0;
~curve= 4;
Routine.run({
	2.wait;
	inf.do{
		port.put(counter.lincurve(0, 255, 0, 255, ~curve).asInteger.postln);
		counter= counter+1;
		if(counter>255, {
			counter= 0;
		});
		0.01.wait;
	};
});
CmdPeriod.doOnce({port.close});
)

//while the program is running try with different curves
~curve= 10
~curve= 0//same as first example
~curve= -4//worse
~curve= 3//better (i think)
