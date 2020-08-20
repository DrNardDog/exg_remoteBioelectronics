#include <Arduino.h>

const int analogInPin = A0;
unsigned long LoopTimer = 0;

int sensorValue = 0;

const int LoopTime = 1000;

void setup() 
{
   Serial.begin(115200);
}

void loop()
{
  if (micros() > LoopTimer)
  {
   LoopTimer += LoopTime;
   sensorValue = analogRead(analogInPin);            
   sensorValue = sensorValue >> 2;
   Serial.write(sensorValue);
   Serial.flush();
  }
}