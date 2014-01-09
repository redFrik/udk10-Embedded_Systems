//https://www.sparkfun.com/products/11040

/*
 GND (ground)                  GND
 RED (Encoder Red LED)         5 - PWM enabled
 BLU (Encoder Blue LED)        6 - PWM enabled
 GRN (Encoder Green LED)       9 - PWM endabled
 DAT (shift data)              8
 CLR (shift clear)             10
 CLK (shift clock)             11
 LATCH (shift latch)           12
 EN (shift enable)             13
 VCC (power)                   5V
 */

int redPin= 5;  // Encoder's red LED - D5 is PWM enabled
int bluPin= 6;  // Encoder's blue LED- D6 is PWM enabled
int grnPin= 9;  // Encoder's green LED - D9 is PWM enabled
int enPin= 13;  // Shift registers' Output Enable pin
int latchPin= 12;  // Shift registers' rclk pin
int clkPin= 11;  // Shift registers' srclk pin
int clrPin= 10;  // shift registers' srclr pin
int datPin= 8;  // shift registers' SER pin

byte ledPins[3] = {
  redPin, bluPin, grnPin};
int cnt= 0;
void setup() {
  pinMode(redPin, OUTPUT);
  pinMode(grnPin, OUTPUT);
  pinMode(bluPin, OUTPUT);
  pinMode(enPin, OUTPUT);
  digitalWrite(enPin, LOW);
  pinMode(latchPin, OUTPUT);
  digitalWrite(latchPin, LOW);
  pinMode(clkPin, OUTPUT);
  digitalWrite(clkPin, LOW);
  pinMode(clrPin, OUTPUT);
  digitalWrite(clrPin, HIGH);
  pinMode(datPin, OUTPUT);
  digitalWrite(datPin, LOW);
}
void loop() {
  ledOut(1<<cnt);
  cnt--;  //direction. change to cnt++ to go the other way
  if(cnt>=16) {
    cnt= 0;
  } 
  else if(cnt<0) {
    cnt= 15;
  }
  delay(50);  //speed
}
void ledOut(uint16_t data) {
  digitalWrite(latchPin, LOW);
  shiftOut(datPin, clkPin, MSBFIRST, (data>>8)&0xff);
  shiftOut(datPin, clkPin, MSBFIRST, data&0xff);
  digitalWrite(latchPin, HIGH);
}

