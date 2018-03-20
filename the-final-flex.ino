/***************************************************
Runs 8 Flex sensors using a multiplexer and an Accelerometer/Gyroscope
Authors: Avery Pratt and Shay Merley
Built upon code by
Carter Nelson (MCP3008), Jim Lindblom (https://www.sparkfun.com/products/10264)
Jeff Rowberg (https://github.com/jrowberg/i2cdevlib)
License: Public Domain
****************************************************/
//Import needed libraries
#include <Adafruit_MCP3008.h>
#include "I2Cdev.h"
#include "MPU6050.h"
//Assign MPU6050 a simple variable name 
MPU6050 accelgyro;
//Assign Adafruit_MCP3008 a simple variable name (ADC means Analog to Digital Converter)
Adafruit_MCP3008 adc;

int count = 0;
int16_t ax, ay, az;
int16_t gx, gy, gz;

const float VCC = 4.98; // Measured voltage of Ardunio 5V line

//CHANGE THIS IF YOU USE A DIFFERENT RESISTOR!!
const float R_DIV = 10000.0; // Measured resistance of 10k resistor

#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
    #include "Wire.h"
#endif

bool blinkState = false;

void setup() {

  #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
        Wire.begin();
  #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
        Fastwire::setup(400, true);
  #endif
  Serial.begin(9600);
  while (!Serial);

   accelgyro.initialize(); //initialize accelerometer


    accelgyro.setXAccelOffset(3);
    accelgyro.setYAccelOffset(11);
    accelgyro.setZAccelOffset(0);
    accelgyro.setXGyroOffset(1);
    accelgyro.setYGyroOffset(0);
    accelgyro.setZGyroOffset(0);

  // Software SPI (specify all, use any available digital)
  // (sck, mosi, miso, cs);
  adc.begin(13, 11, 12, 10);
}

void loop() {
  accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);

  //print flex sensor values through multiplexer
  for (int chan=0; chan<8; chan++) {
    int flexADC = adc.readADC(chan);
    float flexV = flexADC * VCC / 1023.0;
    float flexR = R_DIV * (VCC / flexV - 1.0);
    Serial.print(flexR);
    Serial.print(",");
   
  }

  //print accelerometer values
  Serial.print(ax); Serial.print(",");
  Serial.print(ay); Serial.print(",");
  Serial.print(az); Serial.print(",");
  Serial.print(gx); Serial.print(",");
  Serial.print(gy); Serial.print(",");
  Serial.println(gz);
  
  delay(10);
}
