//--use with supercolliderToArduino_advanced.ino
//these examples controls six pwm channels

//(examples taken from last semester (udkPwm, udk130523))


SerialPort.listDevices;	//run this and see post window for name of serial device


//--gui
(
var name= "/dev/tty.usbserial-A101NB76";	//edit to match your serial device
var port= SerialPort(name, 38400, crtscts: true);
var pwm= [10, 0, 0, 0, 0, 0, 0, 11];
var win= Window("pwm", Rect(99, 99, 260, 200), false);
Slider(win, Rect(10, 10, 30, 170)).action_{|view| pwm.put(1, (view.value*255).asInteger); port.putAll(pwm.postln)};
Slider(win, Rect(50, 10, 30, 170)).action_{|view| pwm.put(2, (view.value*255).asInteger); port.putAll(pwm.postln)};
Slider(win, Rect(90, 10, 30, 170)).action_{|view| pwm.put(3, (view.value*255).asInteger); port.putAll(pwm.postln)};
Slider(win, Rect(130, 10, 30, 170)).action_{|view| pwm.put(4, (view.value*255).asInteger); port.putAll(pwm.postln)};
Slider(win, Rect(170, 10, 30, 170)).action_{|view| pwm.put(5, (view.value*255).asInteger); port.putAll(pwm.postln)};
Slider(win, Rect(210, 10, 30, 170)).action_{|view| pwm.put(6, (view.value*255).asInteger); port.putAll(pwm.postln)};
win.front;
CmdPeriod.doOnce({port.putAll([10, 0, 0, 0, 0, 0, 0, 11]); port.close; win.close});
//press cmd+. to stop and close window and serial port
)






//--live code
(
var name= "/dev/tty.usbserial-A101NB76";	//edit to match your serial device
var port= SerialPort(name, 38400, crtscts: true);
~pwm= [0, 0, 0, 0, 0, 0];
Routine.run({
	inf.do{|i|
		port.putAll([10]++~pwm.clip(0, 255).asInteger++[11]);
		(1/25).wait;
	};
});
CmdPeriod.doOnce({port.putAll([10, 0, 0, 0, 0, 0, 0, 11]); port.close});
)

~pwm= [255, 0, 255, 0, 255, 0]
~pwm= ~pwm.reverse
~pwm= ~pwm.scramble
~pwm= [64, 32, 16, 8, 4, 2]
~pwm= ~pwm.rotate(-1)
fork{20.do{~pwm= ~pwm.rotate(-1); 0.1.wait}}
~pwm= {256.linrand}!6
fork{65.do{|i| ~pwm= i.asBinaryDigits(6)*128; 0.04.wait}}

//now press cmd+. to stop livecoding



//--cycle
(
var name= "/dev/tty.usbserial-A101NB76";	//edit to match your serial device
var port= SerialPort(name, 38400, crtscts: true);
var pwm;
Routine.run({
	inf.do{|i|
		var pwm= [10, 0, 0, 0, 0, 0, 0, 11];
		pwm.put(1, sin(i*0.10).lincurve(-1, 1, 0, 255, 4).asInteger);
		pwm.put(2, sin(i*0.11).lincurve(-1, 1, 0, 255, 4).asInteger);
		pwm.put(3, sin(i*0.12).lincurve(-1, 1, 0, 255, 4).asInteger);
		pwm.put(4, sin(i*0.13).lincurve(-1, 1, 0, 255, 4).asInteger);
		pwm.put(5, sin(i*0.14).lincurve(-1, 1, 0, 255, 4).asInteger);
		pwm.put(6, sin(i*0.15).lincurve(-1, 1, 0, 255, 4).asInteger);
		port.putAll(pwm);
		(1/25).wait;
	};
});
CmdPeriod.doOnce({port.putAll([10, 0, 0, 0, 0, 0, 0, 11]); port.close});
)


//--audio input
(
var name= "/dev/tty.usbserial-A101NB76";	//edit to match your serial device
var port= SerialPort(name, 38400, crtscts: true);
OSCFunc({|msg|
	var pwm;
	//msg.postln;	//debug
	pwm= [10]++msg[3..8].round++[11];
	port.putAll(pwm);
}, "/pwm");
s.waitForBoot{
	SynthDef(\pwm, {|rate= 30|
		var src= SoundIn.ar;
		var amp= Amplitude.kr(src).lincurve(0, 1, -1, 255, -3).clip(0, 255);
		var data= [amp.lag(3.2), amp.lag(1.6), amp.lag(0.8), amp.lag(0.4), amp.lag(0.2), amp.lag(0.1)];
		SendReply.kr(Impulse.kr(rate), '/pwm', data);
	}).add;
	s.sync;
	Synth(\pwm);
};
CmdPeriod.doOnce({port.putAll([10, 0, 0, 0, 0, 0, 0, 11]); port.close});
)
