131212
======

_arduino and supercollider together plus sensors, prepare own projects_

This time we'll do a little detour and look at [arduino](http://arduino.cc). This to learn more about basic electronics (analog vs digital, sensors, pulse-width modulation (pwm), voltage divider etc).

//--arduino hardware
--------------------
The arduino hardware is a small microcontroller (computer) that you can program to do simple tasks like reading sensors, controls motors, set timers, do simple logic, lo-fi sound etc. Normally it's built with an 8bit atmel mega chip and run off 5 volts, but there are boards with other chips and other voltages.
Actually there are very many versions, variants, clones, ripoffs and hacks. From minimal and small (like [trinket](http://www.adafruit.com/products/1501) and [gemma](http://www.adafruit.com/products/1222)) and big (like [mega](http://arduino.cc/en/Main/ArduinoBoardMega2560)), old, new, cheap and expensive arduinos. See [products](http://arduino.cc/en/Main/Products), [hardware index](http://arduino.cc/en/Main/Boards) and (similar boards)[http://playground.arduino.cc/Main/SimilarBoards]. You can also build one yourself (see [last semester](https://github.com/redFrik/udk09-Bits_and_Pieces/tree/master/udk130516)).

//--arduino ide
---------------
To program the board you'll normally use the arduino ide. Download and install it from <http://arduino.cc/en/Main/Software>.
You can also program arduino boards from the terminal, xcode or eclipse or even in your [browser](http://codebender.cc), but the official ide is by far the easiest to get started with.

//--programming the board
-------------------------

* plug in the arduino board via usb and start the arduino ide
* select your type of board in the menu Tools/Board (for the RedBoard i have is of type `Arduino Uno`)
* select the serial port in the menu Tools/Serial Port (mine is called `/dev/tty.usbserial-A101NB76`)
* type in the following and press the upload button...

```
void setup() {
}
void loop() {
  //this program does nothing - just loops forever
  delay(50);  //wait 50 milliseconds
}
```

* leds should flash when uploading
* check that it says `Done uploading.` and not error something.

//--serial communication (arduino -> laptop)
--------------------------------------------
To send data from and to the arduino board we use a serial port. Type in the following arduino program and upload again.

```
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
* set the baudrate to 38400 in the popup and you should see something like this being printed...
`!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_` etc.

This is the ascii representation of the numbers 0-255.

//--digital inputs
------------------
Reading digital sensors is easy with the digitalRead() command. 

```
void setup() {
  Serial.begin(38400);  //open port and set baudrate - must match in laptop
  pinMode(7, INPUT_PULLUP);  //make it 1 if nothing connected
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

`AAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBAA`

//--analog inputs
-----------------

```
void setup() {
  Serial.begin(38400);  //open port and set baudrate - must match in laptop
}
void loop() {
  int val= analogRead(A0);
  byte chr= map(val, 0, 1023, 65, 90);
  Serial.write(chr);
  delay(50);  //wait 100 milliseconds
}
```

//--serial communication (laptop -> arduino)
--------------------------------------------

//--digital outputs
-------------------

//--pwm ("analog") outputs
--------------------------

//--arduino with supercollider
==============================

//--reading sensors in sc
-------------------------

//--controlling leds from sc
----------------------------

//--preparation for own project
===============================

