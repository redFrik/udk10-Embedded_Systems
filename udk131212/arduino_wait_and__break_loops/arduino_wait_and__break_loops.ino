//open serial monitor and set baudrate 38400
//connect pin 4 to ground

//this example pauses and waits for user input

void setup() {
  Serial.begin(38400);
  pinMode(4, INPUT_PULLUP);
}
void loop() {
  
  while(digitalRead(4)==1) {}  //wait until down
  
  Serial.println("entering loop");
  for(int i= 0; i<50; i++) {  //5sec in total (50*100) if not break earlier
    delay(100);
    if(digitalRead(4)==1) {
      i= 50;
      Serial.println("jumping out of loop");
    }
    Serial.println("waiting");
  }
  
  Serial.println("now here at the end");
}

