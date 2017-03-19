#include <Servo.h>

Servo servoLeft;          // Define left servo
Servo servoRight;         // Define right servo

long OnTime1 = 15000;           // milliseconds of on-time
long OnTime2 = 15000;
unsigned long previousMillis1 = 0; 
unsigned long previousMillis2 = 0; 
void setup() 
{
 servoLeft.attach(10);  // Set left servo to digital pin 10
 servoRight.attach(9);  // Set right servo to digital pin 9   
}
 
void loop()
{
  // check to see if it's time to change the state of the LED
  unsigned long currentMillis = millis();
 
  if (currentMillis - previousMillis1 >= OnTime1)
  {
   previousMillis1 = currentMillis;
   forwardLeft();
  }
  
 
  if(currentMillis - previousMillis2 >= OnTime2)
  {
    previousMillis2 = currentMillis;
    forwardRight();
  }
 
}


void forwardLeft() {
  servoLeft.writeMicroseconds(1600);
}

void forwardRight() {
  servoRight.writeMicroseconds(1600);
}

