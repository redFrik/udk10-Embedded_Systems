//redFrik
//fm synths with 4 modulating oscillators

//note: there is a big difference if using integer vs floats: Pwhite(0, 9999.9, inf) vs Pwhite(0, 9999, inf)

//try to replace .add with .draw to see the schematics
//you'll need the rd_dot quark (+ Graphviz)
//Quarks.gui

s.boot

/////////////// fm algo 000
(
SynthDef(\fm000, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(b+freq2, 0, amp2);
	var d= SinOsc.ar(c+freq3, 0, amp3);
	var z= SinOsc.ar(d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm000, \fm000).play.gui(9)
(
a= Pbind(
	\instrument, \fm000,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 001
(
SynthDef(\fm001, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(freq1, 0, amp1);
	var c= SinOsc.ar(a+b+freq2, 0, amp2);
	var d= SinOsc.ar(c+freq3, 0, amp3);
	var z= SinOsc.ar(d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm001, \fm001).play.gui(9)
(
a= Pbind(
	\instrument, \fm001,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 002
(
SynthDef(\fm002, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(freq1, 0, amp1);
	var c= SinOsc.ar(b+freq2, 0, amp2);
	var d= SinOsc.ar(a+c+freq3, 0, amp3);
	var z= SinOsc.ar(d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm002, \fm002).play.gui(9)
(
a= Pbind(
	\instrument, \fm002,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)

/////////////// fm algo 003
(
SynthDef(\fm003, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(a+freq2, 0, amp2);
	var d= SinOsc.ar(b+c+freq3, 0, amp3);
	var z= SinOsc.ar(d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm003, \fm003).play.gui(9)
(
a= Pbind(
	\instrument, \fm003,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 004
(
SynthDef(\fm004, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(b+freq2, 0, amp2);
	var d= SinOsc.ar(b+freq3, 0, amp3);
	var z= SinOsc.ar(c+d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm004, \fm004).play.gui(9)
(
a= Pbind(
	\instrument, \fm004,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 005
(
SynthDef(\fm005, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(b+freq2, 0, amp2);
	var d= SinOsc.ar(freq3, 0, amp3);
	var z= SinOsc.ar(c+d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm005, \fm005).play.gui(9)
(
a= Pbind(
	\instrument, \fm005,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 006
(
SynthDef(\fm006, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(freq1, 0, amp1);
	var c= SinOsc.ar(freq2, 0, amp2);
	var d= SinOsc.ar(a+b+c+freq3, 0, amp3);
	var z= SinOsc.ar(d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm006, \fm006).play.gui(9)
(
a= Pbind(
	\instrument, \fm006,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 007
(
SynthDef(\fm007, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(freq2, 0, amp2);
	var d= SinOsc.ar(c+freq3, 0, amp3);
	var z= SinOsc.ar(b+d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm007, \fm007).play.gui(9)
(
a= Pbind(
	\instrument, \fm007,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 008
(
SynthDef(\fm008, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(a+freq2, 0, amp2);
	var d= SinOsc.ar(a+freq3, 0, amp3);
	var z= SinOsc.ar(b+c+d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm008, \fm008).play.gui(9)
(
a= Pbind(
	\instrument, \fm008,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 009
(
SynthDef(\fm009, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(freq2, 0, amp2);
	var d= SinOsc.ar(freq3, 0, amp3);
	var z= SinOsc.ar(b+c+d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm009, \fm009).play.gui(9)
(
a= Pbind(
	\instrument, \fm009,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 010
(
SynthDef(\fm010, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp3= 800, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(freq1, 0, amp1);
	var c= SinOsc.ar(freq2, 0, amp2);
	var d= SinOsc.ar(freq3, 0, amp3);
	var z= SinOsc.ar(a+b+c+d, 0, amp);
	Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)
Ndef(\fm010, \fm010).play.gui(9)
(
a= Pbind(
	\instrument, \fm010,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop
