//--use with arduinoToSupercollider_advanced.ino
//supercollider code for reading six 10bit analog sensors
//protocol: 253 254 nn nn nn nn nn nn nn nn nn nn nn nn 255
//nn comes in pairs. first nn are the upper 8bits and the second are the lower 2 bits. A0 to A5 in order.

SerialPort.listDevices;
s.boot;
Ndef(\arduino, {|data= #[0, 0, 0, 0, 0, 0]| Splay.ar(SinOsc.ar(data.lag(0.02)+500, 0, 0.4))}).play;

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 115200, crtscts: true);
var num= 6;//number of analog sensors
Routine.run({
	var byte, index= 0, payload= Array.newClear(num*2), data= Array.newClear(num);
	inf.do{
		while({byte= port.read; byte.notNil}, {
			//byte.postln;	//debug
			if(index==0 and:{byte==253}, {//check if first byte is 253
				index= 1;
			}, {
				if(index==1 and:{byte==254}, {//then check if second byte is 254
					index= 2;
				}, {
					if(index>=2 and:{index<(num*2+2)}, {//ok, now start collecting bytes
						payload[index-2]= byte;
						index= index+1;
					}, {
						if(index==(num*2+2) and:{byte==255}, {//until last data byte
							//payload.postln;	//debug
							//everything seems ok so decode payload
							num.do{|i|
								data[i]= (payload[i*2]<<2)+payload[i*2+1];
							};
							//payload finished decoding
							data.postln;//debug - do something better than posting here!
							Ndef(\arduino).setn(\data, data);

							index= 0;//done. reset index to prepare for new message
						}, {
							//something broke or beginning - restart
							"restart".postln;	//debug
							index= 0;
						});
					});
				});
			});
		});
	};
});
CmdPeriod.doOnce({port.close});
)
