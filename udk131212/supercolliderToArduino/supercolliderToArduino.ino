//supercolliderToArduino_advanced - controlling 6 pwm channels
//use with sc code supercolliderToArduino_advanced.scd
//connect 6 leds with resistors or an uln2803 to drive 6 motors

//--serial protocol
// pwm:      10 nn nn nn nn nn nn 11 (nn bytes 1-6= pwm channels 0-5)

//--settings
byte pwmPins[]= {5, 3, 9, 6, 11, 10};

//--variables
byte val, cnt= 0;
byte data[]= {0, 0, 0, 0, 0, 0, 0, 0};

void setup() {
  Serial.begin(38400);    //baudrate must match in sc
  for(byte i= 0; i<6; i++) {
    pinMode(pwmPins[i], OUTPUT);
  }
}
void loop() {
  while(Serial.available()) {
    val= Serial.read();
    if(cnt==0) {
      if(val==10) {  //beginning of message found
        cnt= 1;  //start counter
      }
    } else if(cnt<7) {  //between 1 and 6 means message started and that bytes should be saved
      data[cnt-1]= val;  //saving incoming bytes in temporary data array
      cnt++;
    } else {
      if(val==11) {
        for(byte i= 0; i<6; i++) {
          analogWrite(pwmPins[i], data[i]);  //output read message to pwm pins
        }
      } else {
        //serial read error
      }
      cnt= 0;  //reset byte counter
    }
  }
  delay(1);  //wait 1 millisecond
}

