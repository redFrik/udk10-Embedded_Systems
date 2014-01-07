//--use with arduinoToSupercollider_twoAnalog.ino
//this example controls the playback speed and volume of a soundfile

(
s.waitForBoot{
	b.free;
	b= Buffer.read(s, "/Applications/SuperCollider344/sounds/chaos.aiff");//edit
	s.sync;
	Ndef(\file).play;
	Ndef(\file, {|rate= 1, amp= 0, lag= 0.1|
		Splay.ar(PlayBuf.ar(b.numChannels, b.bufnum, rate.lag(lag)*(amp.abs>0), loop:1)*amp.lag(lag))
	});
};
)

//Ndef(\file).set(\rate, 1.5, \amp, 0.4))


SerialPort.listDevices

(
var port= SerialPort("/dev/tty.usbserial-A101NB79", 115200, crtscts: true);//edit
var num= 2;//number of sensors
Ndef(\file).play;
Routine.run({
	var byte, index= 0, data= Array.newClear(num);
	inf.do{
		while({byte= port.read; byte.notNil}, {
			//byte.postln;//debug
			if(index==0 and:{byte==253}, {//check if first byte is 253
				index= 1;
			}, {
				if(index==1 and:{byte==254}, {
					index= 2;
				}, {
					if(index>=2 and:{index<(num+2)}, {
						data[index-2]= byte;
						index= index+1;
					}, {
						if(index==(num+2) and:{byte==255}, {
							//data.postln;//debug
							Ndef(\file).set(\rate, data[0].linlin(0, 255, 0.25, 4));
							Ndef(\file).set(\amp, data[1].linlin(0, 255, 0, 1));
						});
						index= 0;
					});
				});
			});
		});
		0.009.wait;
	};
});
CmdPeriod.doOnce({port.close});
)
