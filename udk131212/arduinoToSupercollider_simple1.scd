//--use with arduinoToSupercollider_simple.ino
//this example controls the frequency of a sawtooth oscillator

(
s.waitForBoot{
	Ndef(\sound).play;
	Ndef(\sound, {|freq= 400| BLowPass4.ar(Saw.ar(freq))});
};
)

//Ndef(\sound).set(\freq, 2550)

SerialPort.listDevices

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
Ndef(\sound).play;
Routine.run({
	var byte;
	inf.do{
		while({byte= port.read; byte.notNil}, {
			byte.postln;
			Ndef(\sound).set(\freq, byte.linexp(0, 255, 50, 5000));
		});
		0.01.wait;
	};
});
CmdPeriod.doOnce({port.close});
)
