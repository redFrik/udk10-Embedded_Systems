//open serial monitor and set baudrate 38400
//connect pin 4 to ground to test

//this example keeps on looping but keeps track of button presses

int cnt= 0;

void setup() {
  Serial.begin(38400);
  pinMode(4, INPUT_PULLUP);
}
void loop() {
  if(cnt==0 && (digitalRead(4)==1)) {
    cnt= 1;
  }
  if(cnt==1 && (digitalRead(4)==0)) {
    Serial.println("button pressed!");
    cnt= 2;
  }
  if(cnt==2 && (digitalRead(4)==1)) {
    cnt= 3;
  }
  if(cnt==3 && (digitalRead(4)==0)) {
    Serial.println("button pressed a second time!");
    cnt= 0;
  }
  
  delay(10);
}

