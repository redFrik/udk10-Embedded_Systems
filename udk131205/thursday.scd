//a simple beaglebone black instrument, a/v, embedded systems, udk
//see https://github.com/redFrik/udk10-Embedded_Systems

s.waitForBoot{

	//--jingle (customize or remove)
	{LFTri.ar(LFSaw.ar([18,20])*100+500,0,Line.kr(0.5, 0, 3, doneAction:2))}.play;

	//--osc input
	OSCFunc({|msg| msg.postln}, \ana);
	OSCFunc({|msg| msg.postln}, \dig);

};
