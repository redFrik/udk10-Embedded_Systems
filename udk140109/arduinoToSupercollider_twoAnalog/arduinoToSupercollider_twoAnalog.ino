//arduinoToSupercollider_twoAnalog - for reading 2 analog sensors
//use with sc code arduinoToSupercollider_twoAnalog.scd
//connect analog sensors to A0 and A1

void setup() {
  Serial.begin(115200);
}
void loop() {
  Serial.write(253);
  Serial.write(254);
  Serial.write(analogRead(A0)>>2);
  Serial.write(analogRead(A1)>>2);
  Serial.write(255);
  delay(10);  //10millisec pause between each reading
}

