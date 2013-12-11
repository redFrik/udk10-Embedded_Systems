//scEMF
//use with sc code scEMF.scd
//reads one analog sensor input from A0 and send via serial (baudrate 38400)

byte last= 123;  //temp storage for last reading

void setup() {
  Serial.begin(38400);
}
void loop() {
  byte val= constrain(analogRead(A0), 0, 255);  //read a 10bit value (0-1024) and clip it to 0-255
  if(val!=last) {  //filter out repetitions
    Serial.write(val);  //write a byte (0-255) to the serial port
    last= val;
  }
  delay(10);  //10millisec pause between each reading
}

