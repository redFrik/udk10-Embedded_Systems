//a simple beaglebone black instrument, a/v, embedded systems, udk
//see https://github.com/redFrik/udk10-Embedded_Systems

s.waitForBoot{

	//--jingle (customize or remove)
	{LFTri.ar(LFPulse.ar([12,20])*300+600, 0, EnvGen.kr(Env.sine(3, 0.5), doneAction:2))}.play;

	//--osc input
	OSCFunc({|msg|
		//msg.postln;//debug
		Ndef(\thursday).set(msg[1].asString.toLower.asSymbol, msg[2]);
	}, \ana);
	OSCFunc({|msg|
		//msg.postln;//debug
		Ndef(\thursday).set(msg[1].asString.toLower.asSymbol, msg[2]);
	}, \dig);

	//--main synth
	Ndef(\thursday).play;
	Ndef(\thursday, {
		|p9_39= 100, p9_40= 900, p9_41= 0, p9_42= 0| //arguments - add more

		//--make variables from arguments - add more below
		var a0= p9_39;//analog 0
		var a1= p9_40;//analog 1
		var d0= p9_41;//digital 0
		var d1= p9_42;//digital 1

		//--map controllers - customize here
		var freq0= 400;
		var amp0= a1.lag(0.1);
		var freq1= 500;
		var amp1= 200;
		var freq2= 600;
		var amp2= (d0+0.1).lag2(0.1)*300;
		var freq3= a0.lag(1);
		var amp3= 800;
		var amp= d1.lagud(0.01, 0.5);

		//--fm modulation patch
		var a= SinOsc.ar(freq0, 0, amp0);
		var b= SinOsc.ar(freq1, 0, amp1);
		var c= SinOsc.ar(b+freq2, 0, amp2);
		var d= SinOsc.ar(a+c+freq3, 0, amp3);
		var z= SinOsc.ar(d, 0, amp*0.5);
		z!2;
	});

	//Ndef(\thursday).gui //for testing on laptop
};
