//a simple beaglebone black instrument, a/v, embedded systems, udk
//see https://github.com/redFrik/udk10-Embedded_Systems

s.waitForBoot{

	//--jingle (customize or remove)
	{LFTri.ar(LFPulse.ar([12,20])*300+600, 0, EnvGen.kr(Env.sine(3, 0.5), doneAction:2))}.play;

	//--osc input
	OSCFunc({|msg| msg.postln}, \ana);
	OSCFunc({|msg| msg.postln}, \dig);

};
