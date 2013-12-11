//supercolliderToArduino_simple - simple example
//use with sc code supercolliderToArduino_simple1.scd or supercolliderToArduino_simple2.scd
//controls one led via pwm (baudrate 38400)

void setup() {
  Serial.begin(38400);  //open port and set baudrate - must match in laptop
  pinMode(6, OUTPUT);  //make it an output
}
void loop() {
  if(Serial.available()) {
    byte val= Serial.read();
    analogWrite(6, val);  //set led brightness (0-255)
  }
  delay(1);  //wait 1 millisecond
}

