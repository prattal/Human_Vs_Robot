/* 
  glove_capture.pde
  Authored by Shay Merley merleyst@rose-hulman.edu
  This code reads comma-delimited data from an arduino through the serial port, and writes it to a table
  Based on example code found at http://www.hackerscapes.com/2014/11/how-to-save-data-from-arduino-to-a-csv-file-using-processing/ by Elaine Laguerta
*/
 
import processing.serial.*;
import java.lang.*;
Serial myPort; //creates a software serial port on which you will listen to Arduino
Table table=new Table(); //create table object

//-----------change variable 'com' to the correct com number (found in the Arduino IDE)----------//
String com = "COM15";
int numReadings = 25; //how many readings to take before writing to file
int readingCounter = 0; //counts each reading to compare to numReadings. 

String fileName = "C:\\Users\\Administrator\\Desktop\\temp_dir\\glove_data.csv";
String val;
void setup()
{
  myPort = new Serial(this,com, 9600); //set to listen to the serial port
   
  table.addColumn("id"); //uniqe identifier for each sample
  
  //adds a column for time.
  table.addColumn("time");
  
  //incoming data from arduino. note the order must match the order coming from arduino
  table.addColumn("thumb");
  table.addColumn("index_finger");
  table.addColumn("index_knuckle");
  table.addColumn("middle_finger");
  table.addColumn("middle_knuckle");
  table.addColumn("ring_finger");
  table.addColumn("ring_knuckle");
  table.addColumn("pinky_finger");
  table.addColumn("accel_x");
  table.addColumn("accel_y");
  table.addColumn("accel_z");
  table.addColumn("gyro_x");
  table.addColumn("gyro_y");
  table.addColumn("gyro_z");
  
}
 
void serialEvent(Serial myPort){
  val = myPort.readStringUntil('\n'); //The newline separator separates each Arduino loop. we parse the data by each newline separator. 
  if (val!= null) { 
    val = trim(val); //gets rid of any whitespace or Unicode nonbreakable space
    //println(val); //Optional, useful for debugging
    //println(System.currentTimeMillis());
    float sensorVals[] = float(split(val, ',')); //parses the packet from Arduino and places the values into the sensorVals array 
    TableRow newRow = table.addRow(); //add a row for this new reading
    newRow.setInt("id", table.lastRowIndex());//record row's index
    
    //record time stamp
    newRow.setLong("time", System.currentTimeMillis());
    
    
    //record sensor information
    newRow.setFloat("thumb", sensorVals[7]);
    newRow.setFloat("index finger", sensorVals[6]);
    newRow.setFloat("index knuckle", sensorVals[5]);
    newRow.setFloat("middle finger", sensorVals[4]);
    newRow.setFloat("middle knuckle", sensorVals[3]);
    newRow.setFloat("ring finger", sensorVals[2]);
    newRow.setFloat("ring knuckle", sensorVals[1]);
    newRow.setFloat("pinky finger", sensorVals[0]);
    newRow.setFloat("accel x", sensorVals[8]);
    newRow.setFloat("accel y", sensorVals[9]);
    newRow.setFloat("accel z", sensorVals[10]);
    newRow.setFloat("gyro x", sensorVals[11]);
    newRow.setFloat("gyro y", sensorVals[12]);
    newRow.setFloat("gyro z", sensorVals[13]);
    
    readingCounter++; 
    
    //saves the table as a csv in the filepath given by fileName every x samples according to numReadings
    if (readingCounter % numReadings ==0)
    {
      saveTable(table, fileName);
     println("saved to file");
    }
   }
}
 
void draw()
{ 
   //this part is just kind of here
}