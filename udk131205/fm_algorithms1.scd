//redFrik
//fm synths with 3 modulating oscillators

//note: there is a big difference if using integer vs floats: Pwhite(0, 9999.9, inf) vs Pwhite(0, 9999, inf)

//try to replace .add with .draw to see the schematics
//you'll need the rd_dot quark (+ Graphviz)
//Quarks.gui

s.boot

/////////////// fm algo 00
(
SynthDef(\fm00, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(b+freq2, 0, amp2);
	var d= SinOsc.ar(c+freq3, 0, amp);
	Out.ar(out, Pan2.ar(d*e, pan));
}).add;
)
Ndef(\fm00, \fm00).play.gui(8)
(
a= Pbind(
	\instrument, \fm00,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 1
(
SynthDef(\fm01, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(freq1, 0, amp1);
	var c= SinOsc.ar(a+b+freq2, 0, amp2);
	var d= SinOsc.ar(c+freq3, 0, amp);
	Out.ar(out, Pan2.ar(d*e, pan));
}).add;
)
Ndef(\fm01, \fm01).play.gui(8)
(
a= Pbind(
	\instrument, \fm01,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 2
(
SynthDef(\fm02, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(freq1, 0, amp1);
	var c= SinOsc.ar(b+freq2, 0, amp2);
	var d= SinOsc.ar(a+c+freq3, 0, amp);
	Out.ar(out, Pan2.ar(d*e, pan));
}).add;
)
Ndef(\fm02, \fm02).play.gui(8)
(
a= Pbind(
	\instrument, \fm02,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 3
(
SynthDef(\fm03, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(a+freq2, 0, amp2);
	var d= SinOsc.ar(c+freq3, 0, amp);
	Out.ar(out, Pan2.ar(d*e, pan));
}).add;
)
Ndef(\fm03, \fm03).play.gui(8)
(
a= Pbind(
	\instrument, \fm03,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 4
(
SynthDef(\fm04, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(b+freq2, 0, amp);
	var d= SinOsc.ar(b+freq3, 0, amp);
	Out.ar(out, Pan2.ar((c+d)*e, pan));
}).add;
)
Ndef(\fm04, \fm04).play.gui(8)
(
a= Pbind(
	\instrument, \fm04,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 5
(
SynthDef(\fm05, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(b+freq2, 0, amp);
	var d= SinOsc.ar(freq3, 0, amp);
	Out.ar(out, Pan2.ar((c+d)*e, pan));
}).add;
)
Ndef(\fm05, \fm05).play.gui(8)
(
a= Pbind(
	\instrument, \fm05,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 6
(
SynthDef(\fm06, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(freq1, 0, amp1);
	var c= SinOsc.ar(freq2, 0, amp2);
	var d= SinOsc.ar(a+b+c+freq3, 0, amp);
	Out.ar(out, Pan2.ar(d*e, pan));
}).add;
)
Ndef(\fm06, \fm06).play.gui(8)
(
a= Pbind(
	\instrument, \fm06,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\amp1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 7
(
SynthDef(\fm07, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, freq2= 600, amp2= 300, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp);
	var c= SinOsc.ar(freq2, 0, amp2);
	var d= SinOsc.ar(b+freq3, 0, amp);
	Out.ar(out, Pan2.ar((b+d)*e, pan));
}).add;
)
Ndef(\fm07, \fm07).play.gui(8)
(
a= Pbind(
	\instrument, \fm07,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\amp2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 8
(
SynthDef(\fm08, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, freq2= 600, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp);
	var c= SinOsc.ar(a+freq2, 0, amp);
	var d= SinOsc.ar(a+freq3, 0, amp);
	Out.ar(out, Pan2.ar((b+c+d)*e, pan));
}).add;
)
Ndef(\fm08, \fm08).play.gui(8)
(
a= Pbind(
	\instrument, \fm08,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 9
(
SynthDef(\fm09, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, freq2= 600, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp);
	var c= SinOsc.ar(freq2, 0, amp);
	var d= SinOsc.ar(freq3, 0, amp);
	Out.ar(out, Pan2.ar((b+c+d)*e, pan));
}).add;
)
Ndef(\fm09, \fm09).play.gui(8)
(
a= Pbind(
	\instrument, \fm09,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\amp0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop

/////////////// fm algo 10
(
SynthDef(\fm10, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp);
	var b= SinOsc.ar(freq1, 0, amp);
	var c= SinOsc.ar(freq2, 0, amp);
	var d= SinOsc.ar(freq3, 0, amp);
	Out.ar(out, Pan2.ar((a+b+c+d)*e, pan));
}).add;
)
Ndef(\fm10, \fm10).play.gui(8)
(
a= Pbind(
	\instrument, \fm10,
	\dur, 2,
	\freq0, Pwhite(0, 9999.9, inf),
	\freq1, Pwhite(0, 9999.9, inf),
	\freq2, Pwhite(0, 9999.9, inf),
	\freq3, Pwhite(0, 9999.9, inf),
	\amp, 0.5
).play
)
a.stop
