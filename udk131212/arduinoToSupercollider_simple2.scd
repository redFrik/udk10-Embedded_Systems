//--use with arduinoToSupercollider_simple.ino
//this example controls the playback speed of a soundfile

(
s.waitForBoot{
	b.free;
	b= Buffer.read(s, "/Applications/SuperCollider344/sounds/chaos.aiff");//edit
	s.sync;
	Ndef(\file).play;
	Ndef(\file, {|rate= 1| Splay.ar(PlayBuf.ar(b.numChannels, b.bufnum, rate, loop:1))});
};
)

//Ndef(\file).set(\rate, 1.5)

SerialPort.listDevices

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
Ndef(\file).play;
Routine.run({
	var byte;
	inf.do{
		while({byte= port.read; byte.notNil}, {
			byte.postln;
			Ndef(\file).set(\rate, byte.linlin(0, 255, 0.25, 4));
		});
		0.01.wait;
	};
});
CmdPeriod.doOnce({port.close});
)
