#include <Arduino.h>

#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit)) // macro to clear bit in register
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))  // macro to set bit in register

const int analogInPin = A0;
int sensorValue = 0;

unsigned long LoopTimer = 0;
const int LoopTime = 300; // was 1000

void setup() {

  sbi(ADCSRA, ADPS2);
  cbi(ADCSRA, ADPS1); 
  sbi(ADCSRA, ADPS0); // clear for prescaler = DIV16, set for DIV32

  Serial.begin(115200);

}

void loop(){
  if (micros() > LoopTimer) {

   LoopTimer += LoopTime;
   sensorValue = analogRead(analogInPin);            
   sensorValue = sensorValue >> 2; // 10-bit to byte for transfer
   Serial.write(sensorValue);
   Serial.flush();
  
  }
}