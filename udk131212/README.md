131212
======

_arduino and supercollider together plus sensors, prepare own projects_

This time we'll do a little detour and look at [arduino](http://arduino.cc). This to learn more about basic electronics (analog vs digital, sensors, pulse-width modulation (pwm), voltage divider etc).

Note: all the things we do with the arduino you can also do with the beaglebone black. It is just simpler and quicker to use the arduino+laptop combo for these experiments.

//--arduino hardware
--------------------
The arduino hardware is a small microcontroller (computer) that you can program to do simple tasks like reading sensors, controls motors, set timers, do simple logic, lo-fi sound etc. Normally it's built with an 8bit atmel mega chip and run off 5 volts, but there are boards with other chips and other voltages.
Actually there are very many versions, variants, clones, ripoffs and hacks. From minimal and small (like [trinket](http://www.adafruit.com/products/1501) and [gemma](http://www.adafruit.com/products/1222)) to big (like [mega](http://arduino.cc/en/Main/ArduinoBoardMega2560)), old, new, cheap, expensive, improved, fake arduinos. See [products](http://arduino.cc/en/Main/Products), [hardware index](http://arduino.cc/en/Main/Boards) and [similar boards](http://playground.arduino.cc/Main/SimilarBoards). You can also build one yourself (see [last semester](https://github.com/redFrik/udk09-Bits_and_Pieces/tree/master/udk130516)).

//--arduino ide
---------------
To program the board you'll normally use the arduino ide. Download and install it from <http://arduino.cc/en/Main/Software>.

(You can also program arduino boards from the terminal, xcode or eclipse or even in your [browser](http://codebender.cc), but the official ide is by far the easiest to get started with.)

//--programming the board
-------------------------

* plug in the arduino board via usb and start the arduino ide (i recommended to use version 1.0.5)
* select your type of board in the menu Tools/Board (the [RedBoard](https://www.sparkfun.com/products/11575) i have is of type `Arduino Uno`)
* select the serial port in the menu Tools/Serial Port (mine is called `/dev/tty.usbserial-A101NB76`)
* type in the following code and press the upload button...

```
void setup() {
}
void loop() {
  //this program does nothing - just loops forever
  delay(50);  //wait 50 milliseconds
}
```

* leds should flash on the board during upload.
* check that it says `Done uploading.` and no errors.

Troubleshooting / common mistakes:

* wrong serial port or board selected
* serial port is already in use by another application in the background (quit sc, pd, max or whatever)
* missing ftdi driver <http://arduino.cc/en/Guide/Howto>
* <http://arduino.cc/en/Guide/Troubleshooting>

//--serial communication (arduino -> laptop)
--------------------------------------------
To send data from (and to) the arduino board we normally use the serial port. Type in the following arduino program and click upload again.

```
//simple serial counter example
byte cnt= 0;
void setup() {
  Serial.begin(38400);  //open port and set baudrate - must match in laptop
}
void loop() {
  Serial.write(cnt);  //writes a byte (0-255) to the port
  cnt= cnt+1;  //counts 0-255 forever in a loop
  delay(50);  //wait 50 milliseconds
}
```

* if that uploaded without errors, then open the serial monitor (under menu Tools).
* set the baudrate to 38400 in the popup and you should see something like this...

![simple_serial_counter](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/simple_serial_counter.png)

This is the ascii representation of the (8bit) numbers 0-255.

//--digital inputs
------------------
Reading digital sensors is easy with the digitalRead() command. 

```
//simple digital read
void setup() {
  Serial.begin(38400);  //open port and set baudrate - must match in laptop
  pinMode(7, INPUT_PULLUP);  //make it 1 if nothing connected (no wire to gnd)
}
void loop() {
  if(digitalRead(7)==1) {
    Serial.write(65);  //ascii A
  } else {
    Serial.write(66);  //ascii B
  }
  delay(100);  //wait 100 milliseconds
}
```

* connect a wire between pin 7 and GND.

![simple_digital_read](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/simple_digital_read.jpg)

* again open the serial monitor and when you connect / disconnect the wire at pin 7 you should see the character change...

`AAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBAA`

Note: A and B are really the numbers 65 and 66. Compare in supercollider: `65.asAscii`.

//--analog inputs
-----------------
On the standard arduino board there are 6 analog inputs (A0-A5). They read voltage at 10bit resolution (values 0-1023).

```
//simple analog read
void setup() {
  Serial.begin(38400);  //open port and set baudrate - must match in laptop
}
void loop() {
  int val= analogRead(A0);
  byte chr= map(val, 0, 1023, 65, 90);  //scale from 10bit down to A-Z
  Serial.write(chr);
  delay(50);  //wait 100 milliseconds
}
```

* connect a potentiometer.  Middle pot pin to A0, outer pot pins to 5V and GND (order doesn't matter).

![simple_analog_read](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/simple_analog_read.jpg)

* the serial monitor should now display characters from the english alphabet depending on what the voltage is on A0.

`AAAAAAAAAAAAAAAAABBBBBBCCCCCDDDEEFFGIJKMNPTVWYYZZZZZZZZZZZZZZZZZZZZZZYXXVUSRQQONMLLKJJI`

//--serial communication (laptop -> arduino)
--------------------------------------------
We can also send serial data to the arduino board. Here is a simple example that makes the arduino board just add one and send back all the data bytes it receives.

```
//simple serial receive and send example
void setup() {
  Serial.begin(38400);  //open port and set baudrate - must match in laptop
}
void loop() {
  if(Serial.available()) {
    byte val= Serial.read();
    Serial.write(val+1);  //increase the value and send it back
  }
  delay(1);  //wait 1 millisecond
}
```

Again open the serial monitor, set baudrate 38400 and type something in the upper textview. When you press return the arduino should answer back:

`abc` -> `bcd`

//--digital outputs
-------------------
The pins 2-13 on a standard arduino can also act as outputs (more pins are available on other models, and you can also use 0-1 but that's often used by the serial port).
So here we will use pin 7 again but change direction and make it blink a led.

```
//simple digital output from serial commands
void setup() {
  Serial.begin(38400);  //open port and set baudrate - must match in laptop
  pinMode(7, OUTPUT);  //make it an output
}
void loop() {
  if(Serial.available()) {
    byte val= Serial.read();
    if(val==65) {  //match 'A'
      digitalWrite(7, 1);  //turn on led
    }
    if(val==66) {  //match 'B'
      digitalWrite(7, 0);  //turn off led
    }
  }
  delay(1);  //wait 1 millisecond
}
```

Open serial port and type capital `A` and the led should start to shine. Type `B` to turn it off.

//--pwm ("analog") outputs
--------------------------
PWM stands for pulse-width modulation and this can be used to fade leds in an analog fashion. But it's not really correct to call it analog. It is more like pulsating on/off so quickly that it looks like it's half on. See <http://arduino.cc/en/Tutorial/PWM> for a better explanation.

Note that we can only use the pins marked with `~`. So connect a resistor (between 100 and 1K) and a led in series to pin 6.

```
//simple analog (pwm) output from serial commands
void setup() {
  Serial.begin(38400);  //open port and set baudrate - must match in laptop
  pinMode(6, OUTPUT);  //make it an output
}
void loop() {
  if(Serial.available()) {
    byte val= Serial.read();
    if(val==65) {  //match 'A'
      for(byte i= 0; i<255; i++) {
        analogWrite(6, i);  //fade in led
        delay(10);
      }
    }
    if(val==66) {  //match 'B'
      for(byte i= 255; i>0; i--) {
        analogWrite(6, i);  //fade in led
        delay(10);
      }
    }
  }
  delay(1);  //wait 1 millisecond
}
```

In serial monitor you can now type `A` to fade in the led (over 10*255= 2550 milliseconds), and `B` to fade out.

Note: serial data is put in a buffer or cue. Try to type something like `ABABABBBBB` and then press return. As you can see the arduino will play through all these characters in order - like a little sequencer. This is why it is sometimes important to not flood the serial port with too much data, and make sure you (if a port is opened) read faster than you send data to it. Else programes can crash or your computer slow down to a halt.

//--arduino with supercollider
==============================
Instead of the serial monitor used above we can do the same with supercollider. Or any program that can open a serialport like python, max, pd, processing etc.

So with the last sketch loaded (simple analog (pwm) output from serial commands), try the following in supercollider...

```
SerialPort.listDevices;//this will post available ports. copy the name from here to the line below

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
Routine.run({
	2.wait;
	inf.do{
		"fading in...".postln;
		port.put(65);
		3.wait;
		"fading out...".postln;
		port.put(66);
		3.wait;
	};
});
CmdPeriod.doOnce({port.close});
)
```

That should make the led fade in and out repeatedly.

//--reading sensors in sc
-------------------------
Upload the [arduinoToSupercollider_simple.ino](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/arduinoToSupercollider_simple.ino), connect something to A0 (or just connect a bare cable to get noise input) and try the two sc programs [arduinoToSupercollider_simple1.scd](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/arduinoToSupercollider_simple1.scd) and [arduinoToSupercollider_simple2.scd](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/arduinoToSupercollider_simple2.scd).

A more advanced example with serial error checking is shown in arduinoToSupercollider_advanced. Upload [arduinoToSupercollider_advanced.ino](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/arduinoToSupercollider_advanced.ino) and run [arduinoToSupercollider_advanced.scd](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/arduinoToSupercollider_advanced.scd) in sc.

//--controlling leds from sc
----------------------------
Upload the [supercolliderToArduino_simple.ino](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/supercolliderToArduino_simple.ino), and connect an led with resistor to pin 6 and test [supercolliderToArduino_simple1.scd](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/supercolliderToArduino_simple1.scd) and [supercolliderToArduino_simple2.scd](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/supercolliderToArduino_simple2.scd) in supercollider.

Upload the [supercolliderToArduino_advanced.ino](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/supercolliderToArduino_advanced.ino), and connect 6 leds with resistor to pins 3, 5, 6, 9, 10, 11 and run the examples in [supercolliderToArduino_advanced.ino](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/supercolliderToArduino_advanced.scd).

//--preparation for own project
===============================
Start to think of a project you want to realize and work in jan-feb. Be prepared to present it next time.

//--extra
---------
Last a small little arduino project that would actually fit very well on a beaglebone black (there it's easier to run it standalone on batteries and no laptop needed).

* first see <http://www.aaronalai.com/emf-detector>
* then upload the `scEMF.ino` to your arduino
* connect a big resistor (3.3M ohm) between A0 and GND
* connect an antenna also to A0 (around 16cm long solid wire)
* run the `scEMF.scd` code in supercollider
* disconnect your laptop charger. this makes the readings better but preferably you should run you arduino on batteries to reduce interference (and then use a bluetooth or wifi module to send data to the laptop).

![emf](https://raw.github.com/redFrik/udk10-Embedded_Systems/master/udk131212/scEMF.jpg)
