//arduinoToSupercollider_simple - simple example
//use with sc code arduinoToSupercollider_simple1.scd or arduinoToSupercollider_simple2.scd
//reads one analog sensor input from A0 and send via serial (baudrate 38400)

void setup() {
  Serial.begin(38400);
}
void loop() {
  byte val= analogRead(A0)>>2;  //read a 10bit value (0-1024) and scale to byte (0-255)
  Serial.write(val);  //write a byte (0-255) to the serial port
  delay(10);  //10millisec pause between each reading
}

