//this program can run standalone and will turn on/off relays (or leds) following a pattern score
//each relay will play the score but with variation in timing.  after a while the relays will be out of sync.
//see this as an example of how to balance randomness versus order

//--setup
//* connect 8 relays to arduino pins 2, 3, 4, 5, 6, 7, 8, 9.  if you have less then just leave the pins unconnected
//* edit the time variation for each pin under settings/variation - must be same number as number of pins
//* edit the score - can be any length. time is in milliseconds

//--settings (edit here)
byte pins[]= {
  2, 3, 4, 5, 6, 7, 8, 9};
int variations[]= {
  30, 10, 100, 0, 13, 200, 30, 30};//random time variation for each pin
int score[]= {
  100, 200, 300, 400, 400, 500, 600, 5000, 5000, 50, 1000, 2000, 3000};//score pattern for all pins

//--variables (do not touch)
int counters[sizeof(pins)];
byte indices[sizeof(pins)];
byte states[sizeof(pins)];
int times[sizeof(pins)];

//--init
void setup() {
  for(byte i= 0; i<sizeof(pins); i++) {
    pinMode(pins[i], OUTPUT);
    counters[i]= 0;
    indices[i]= 0;
    states[i]= 0;
    times[i]= 0;
  }
}

//--main program
void loop() {
  byte resolution= 10;
  for(byte i= 0; i<sizeof(pins); i++) {
    if(counters[i]>=times[i]) {
      states[i]= 1-states[i];  //change on/off state
      digitalWrite(pins[i], states[i]);
      counters[i]= 0;  //reset counter
      times[i]= score[indices[i]]+random(0-variations[i], variations[i]);//set new time to next
      indices[i]= (indices[i]+1)%sizeof(pins);
    } 
    {
      counters[i]= counters[i]+resolution;
    }
  }
  delay(resolution);  //updaterate
}



