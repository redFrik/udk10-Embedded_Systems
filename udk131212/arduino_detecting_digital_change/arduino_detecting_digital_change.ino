//open serial monitor and set baudrate 38400
//connect pin 4 to ground and it should say 'falling edge' in the monitor

int lastReading= -1;

void setup() {
  Serial.begin(38400);
  pinMode(4, INPUT_PULLUP);
}
void loop() {
  
  int reading= digitalRead(4);
  if((reading==1)&&(lastReading==0)) {
    Serial.println("rising edge");
  }
  if((reading==0)&&(lastReading==1)) {
    Serial.println("falling edge");
  }
  lastReading= reading;
  
  delay(10);
}

