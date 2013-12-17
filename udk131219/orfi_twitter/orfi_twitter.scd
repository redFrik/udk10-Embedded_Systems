//redFrik dec2013
s.waitForBoot{
	var syn1, syn2, syn3, cnt= 0, log, net, pfunc, rout;
	syn1= {|freq= 400, amp= 0, t_trig= 0|
		SinOsc.ar(
			freq.lag(0.01)+[0, 4],
			SinOsc.ar(freq.lag(4), 0, EnvGen.ar(Env.perc(0.05, 0.5, 2pi), t_trig)),
			amp.lagud(0.01, 0.05)
		);
	}.play;
	syn2= {|t_trig= 0|
		HPF.ar(WhiteNoise.ar(EnvGen.kr(Env.perc(0.01, 0.05, 0.5), t_trig)!2), 4000)
	}.play;
	syn3= {|t_trig= 0|
		LPF.ar(ClipNoise.ar(EnvGen.kr(Env.perc(0.01, 0.05), t_trig)!2), 1000)
	}.play;
	s.sync;
	log= Object.readArchive("/home/debian/orfi_twitter_log.txt");
	if(log.isNil, {log= List.newClear(5)});
	net= NetAddr("127.0.0.1", 15555);
	OSCFunc({|msg|
		var n;
		//msg.postln;	//debug
		if(msg[1]==1, {
			n= log[0];	//play back last twitter text
			pfunc.value(log[0], 0.01, 1, #[0, 1, 2]);
			cnt= 0;		//reset counter
		});
	}, \sw1);
	OSCFunc({|msg|
		var n;
		//msg.postln;	//debug
		if(msg[1]==1, {
			n= log.copyToEnd(1).wrapAt(cnt);//play back notes in history log
			pfunc.value(n, cnt+2*0.01, 0.95.pow(cnt+1), #[3, 4, 5]);
			cnt= cnt+1;
		});
	}, \sw2);
	OSCFunc({|msg|
		var notes= msg[1].ascii;
		log.pop;
		log.addFirst(notes);
		log.writeArchive("/home/debian/orfi_twitter_log.txt");
		pfunc.value(notes);	//play back new twitter text
	}, \text);
	OSCFunc({|msg|
		{Line.kr(0.5, 0, 0.2, doneAction:2)*SinOsc.ar([400, 404]*XLine.kr(1, 4, 0.2))}.play;
	}, \on);
	OSCFunc({|msg|
		{Line.kr(0.5, 0, 0.2, doneAction:2)*SinOsc.ar([400, 404]*XLine.kr(4, 1, 0.2))}.play;
		{s.quit}.defer(1);	//quit brutally
	}, \off);
	pfunc= {|notes, dur= 0.01, rate= 1, channels= #[0, 1, 2, 3, 4, 5]|
		rout.stop;	//stop previous routine if any
		6.do{|i| net.sendMsg(\fromSC, i, 0)};	//zero all pwm
		rout= Routine.run({
			notes.do{|x, i|
				var pwm= i.lincurve(0, notes.size-1, 100, 0, -3).asInteger;
				case
				{x==32 or:{x>127}} {syn1.set(\amp, 0)}	//space or >127
				{x==46} {syn2.set(\t_trig, 1)}	//dot
				{x==44} {syn3.set(\t_trig, 1)}	//comma
				{x==64} {syn1.set(\t_trig, 1)}	//at
				{syn1.set(\amp, 0.1, \freq, x.midicps*rate)};
				channels.do{|i| net.sendMsg(\fromSC, i, pwm)};
				//x.asAscii.post;	//debug
				dur.wait;	//melody speed
			};
			syn1.set(\amp, 0);
			channels.do{|i| net.sendMsg(\fromSC, i, 0)};
		});
	};
};
