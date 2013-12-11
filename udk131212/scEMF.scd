//--use with the scEMF.ino arduino sketch
//connect a 3.3M resistor between A0 and GND + an antenna to A0
//this example makes sound out of electromagnetic fields

(
s.waitForBoot{
	Ndef(\noise).play;
	Ndef(\noise, {|amp= 0| BLowPass.ar(ClipNoise.ar(amp.lag(0.01)!2))});
};
)

//Ndef(\noise).set(\amp, 0.1)

SerialPort.listDevices

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
Ndef(\noise).play;
Routine.run({
	var byte;
	inf.do{
		while({byte= port.read; byte.notNil}, {
			byte.postln;
			Ndef(\noise).set(\amp, byte.linlin(0, 255, 0, 1));
		});
		0.009.wait;//read a little bit faster than the 10ms delay
	};
});
CmdPeriod.doOnce({port.close});
)
