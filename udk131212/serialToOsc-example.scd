//reads one analog input (A0) on an arduino
//here A0 controls both frequency and amplitude
//use together with serialToOsc-example.pd and the standardfirmata

s.waitForBoot{
	Ndef(\snd, {|freq= 400, amp= 0.5| SinOsc.ar([freq, freq+4].lag(0.08), 0, amp.lag(0.08)).tanh}).play;
	OSCFunc({|msg|
		msg.postln;//debug;
		Ndef(\snd).set(\amp, msg[2]);
		Ndef(\snd).set(\freq, msg[2].linexp(0, 1, 400, 800));
	}, \analog);
};
