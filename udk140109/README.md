140109
======

_own projects_

in this folder just some various arduino + supercollider examples we wrote.

//--arduino to supercollider
----------------------------
Using two analog sensors to control the speed and volume of a soundfile.
Upload the `arduinoToSupercollider_twoAnalog.ino` to the arduino, connect sensors in A0 and A1, run the code in `arduinoToSupercollider_twoAnalog.scd` (replace buffer with your own soundfile).

//--relay
---------
An example of using 5v relays to control 220v mains power. This arduino sketch works on its own turning relays on/off in a custom sequence. Example relays... <http://dx.com/p/8-channel-relay-module-board-w-optocoupler-isolation-blue-works-with-official-arduino-boards-224064>
Upload the `relays.ino` and test with low voltage leds first. Then turn off everything, connect 220v wires to relay. Make sure no loose wires - tape or tie down on a table.

//--rotary
----------
A simple example for some leds in a circle... <https://www.sparkfun.com/products/11040>
