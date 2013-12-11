//--use with supercolliderToArduino_simple.ino
//these examples controls a led from a pbind and from sound

SerialPort.listDevices;//this will post available ports. copy the name from here to the line below

//this will make the led use the same amp values as the synth
(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
s.latency= 0.05;
s.waitForBoot{
	Pbind(
		\dur, 0.125,
		\legato, 0.25,
		\degree, Pseq([0, 4, 2, 2, 3, 1, 2, 1], inf),
		\amp, Prand([0, 0, 0, 0.25, 0.5, 1], inf),
		\dummy, Pfunc({|ev| port.put(ev.amp.postln.lincurve(0, 1, 0, 255, 3).asInteger)})
	).play;
};
CmdPeriod.doOnce({port.close});
)


//--

//this will make the led fade smoothly depending on how loud sound coming in

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
s.latency= 0.05;
s.waitForBoot{
	SynthDef(\tracker, {|lag= 0.3, atk= 0.01, rel= 0.1|
		var src= SoundIn.ar(0);
		var trk= Amplitude.kr(src, atk, rel);
		SendReply.kr(Impulse.kr(60), '/micamp', trk.lag(lag));
	}).add;
	s.sync;
	Synth(\tracker);
	OSCFunc({|msg|
		msg.postln;//debug
		port.put(msg[3].lincurve(0, 1, 0, 255, 3).asInteger);
	}, \micamp);
};
CmdPeriod.doOnce({port.close});
)
