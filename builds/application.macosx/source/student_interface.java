import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import controlP5.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class student_interface extends PApplet {

/*

ES 53 - ECG / EMG user interface

To get started, press the play button above. A new window will appear that will allow you to (a) see incoming data 
and (b) save data from a session to a .txt file. 

Instructions for connection:

1. From the 'Serial Ports' drop down menu on the top left, select /DEV/CU.USBMODEMXXXXX (for Windows, see bullet below)
    + This is a list that includes all of the things that could connect to your computer
    + If it isn't clear which port to select, refer to the provided guide
    + On Windows, this will appear as a COM port, with appearance COM<n>, where n defines the number of each port
2. From the 'Baud' drop down menu adjacent 'Serial Ports,' select 115200
    + This specifies the transfer rate of information from the Arduino board; it must be set to 115200 to communicate with the board
    
Please do not modify the code in the tabs above. If you happen to, you can always retrieve a fresh copy from Canvas. 

*/
public void draw() {
 
 // **** Menu bar **** // 
 
 fill(128);
 rect(0, 0, width-1, menuBarH);
 
 // **** Graph of data from serial connection **** //
 
 if (connected && showGraph) {
   if (count > width/scalar) {
     
     count = 0;
     background(black);
   }  
   if (count == 0) {
     
     x1 = count;
     y1 = yIn;
   
   }  
   if (count > 0) {
    
     x2 = scalar*count;
     y2 = yIn;
     
     stroke(255);
     line(x1, y1, x2, y2);
     
     x1 = x2;
     y1 = y2; 
     
   } 
    count++;
 }
 
 else { 
   
 // **** Graph of saved file with comma separated values **** // 
   
   if (data != null) {
     if (index < data.length) {
       
       String[] pieces = split(data[index], ",");   
       
       if (counter > width/scalar) {
         
         counter = 0;
         background(black);
       
       }
       if (counter == 0) {
       
         x3 = 0;
         y3 = height - PApplet.parseFloat(pieces[0]);
       
       } 
       if (counter > 0){
 
         x4 = scalar*counter;
         y4 = height - PApplet.parseFloat(pieces[0]);
         
         stroke(255);
         line(x3, y3, x4, y4);
         
         x3 = x4;
         y3 = y4;  
       
       }
       index++;
       counter++;
      }
    }     
  }
}
public void ClrScrn() {
  
 background(black);

}

public void SerialPorts(int n) {
  
  // **** Request selected item from Map based on index n **** //
 
  portName = cp5.get(ScrollableList.class, "SerialPorts").getItem(n).get("name").toString();
  logFld.setText("portSelected: "+portName);
  background(black);

}

public void Baud(int n) {
  
  baudRate = baud[n];
  logFld.setText("baudRate: "+baudRate);
  background(black);

}

public void EmptyArray() {
  
  y.clear();

}

public void Connect() {
  
  // **** Zero out data array **** //
  
  EmptyArray();
  port = new Serial(this, portName, baudRate);
  connected = true;
  logFld.setText("status: connected");

}

public void Disconnect() {
  
  port.stop();
  yIn = 0;
  count = 0;
  connected = false;
  logFld.setText("status: disconnected");

}

public void Save() {
  
  String dateTimeStr = getDateTime();
  String fileToSave = dateTimeStr+".txt";
  String[] data = new String[y.size()];
  
  for (int i = 0; i < y.size(); i++) {
  
    data[i] = y.get(i)+",";
  
  }
  
  saveStrings(fileToSave, data);
  y.clear();
  logFld.setText("data was saved to a file in app folder");

}

public void ScreenShot() {
  
 String dateTimeStr = getDateTime();
 String imageOut = dateTimeStr+".png";
 save(imageOut);
 logFld.setText("screenshot was saved to app folder");

}

public void RescanPorts() {
  
 logFld.setText("ports rescanned");
 cp5.get(ScrollableList.class, "SerialPorts").clear();
 String[] ports = Serial.list();
 List p = Arrays.asList(ports);
 cp5.get(ScrollableList.class, "SerialPorts").addItems(p);
 
}

public void fileSelected(File selection) {
 if (selection != null) {
  // reset required for multiple selections 
  index = 0;
  counter = 0;
  fileName = selection.getAbsolutePath(); 
  logFld.setText("File selected: " + fileName);
  data = loadStrings(selection.getAbsolutePath());
 }
}

public void Open(){
 selectInput("Select a file to process:", "fileSelected");
}

public void Replay(){
 if (fileName == null) {
   logFld.setText("there is no file selected");
   // To avoid null pointer exception
   return;
 } else {
  background(black);
  data = loadStrings(fileName);
  index = 0;
  counter = 0; 
 }
}

public void Radio(int radioID) {
  
  switch(radioID) {
    
    case(0):logFld.setText("graph selected as output");
     showGraph = true;
     showText = false;
     break;
    case(1):logFld.setText("text selected as output");
     showGraph = false;
     showText = true;
     break;  
  
  }
} 

public void Quit() {
  
  exit();

}




ControlP5 cp5;
Textarea valueFld;
Textlabel logFld;
Serial port;

PrintWriter output;
PFont font;

String[] data;
String fileName;

String portName;
int baudRate;
int[] baud = {115200};
int itemSelected;

boolean connected = false;
boolean showGraph = false;
boolean showText = false;

final int fntSize = 10;
final int menuBarH = 65;

int black = color(0,0,0);
int gray = color(0, 160, 100);

int scalar = 2;
int index = 0;
int counter = 0;
int count = 0;
int inByte = 0;

float yIn;
float x1, y1, x2, y2;
float x3, y3, x4, y4;

IntList y;

public String getDateTime() {
  
 int s = second();
 int m = minute();
 int h = hour();
 int day = day();
 int mo = month();
 int yr = year();

 String date = nf(mo,2)+nf(day,2)+yr+"_";
 String time = nf(h,2)+nf(m,2)+nf(s,2);
 String dateTime = date+time;
 
 return dateTime;

}

public void settings() {
  
  size(900, 340);

}
// **** Byte data sent without frame markers **** //

public void serialEvent (Serial port) {
  
 int inByte = port.read();
 y.append(inByte);
 yIn = height - inByte - 10;
 
 if(showText == true) {
   String inStr = str(inByte)+",\n"; 
   valueFld.append(inStr);
 }

}
public void setup() {
 
 y = new IntList(); 
  
 if (frame != null) {
   
   surface.setResizable(true);
 
 }
 
 background(black);
 
 cp5 = new ControlP5(this);
 
 //String[] fontList = PFont.list();
 //printArray(fontList);
 
 font = createFont("Verdana", fntSize);
 
 String[] ports = Serial.list();
 List p = Arrays.asList(ports);
 
 cp5.addScrollableList("SerialPorts")
     .setPosition(10, 3)
     .setSize(230, 90)
     .setCaptionLabel("Serial Ports")
     .setBarHeight(18)
     .setItemHeight(18)
     .setFont(font)
     .addItems(p);
      
 List b = Arrays.asList("115200");      
 cp5.addScrollableList("Baud")    
      .setPosition(250, 3)
      .setSize(60,90)
      .setBarHeight(18)
      .setItemHeight(18)
      .setFont(font)
      .addItems(b); 
   
 cp5.addButton("Connect")
     .setPosition(320, 3)
     .setFont(font)
     .setSize(85,19);
     
 cp5.addButton("Disconnect")
     .setPosition(320,23)
     .setFont(font)
     .setSize(85,19);
           
 cp5.addButton("Save")
     .setPosition(415,3)
     .setFont(font)
     .setSize(70,19)
     .setCaptionLabel("Save Data");
 
 cp5.addButton("Open")
     .setPosition(415,23)
     .setFont(font)
     .setSize(70,19)
     .setCaptionLabel("Open File");
      
 cp5.addButton("ScreenShot")
     .setPosition(495,3)
     .setFont(font)
     .setSize(80,19);
 
 cp5.addButton("ClrScrn")
     .setPosition(495,23)
     .setFont(font)
     .setSize(80,19)
     .setCaptionLabel("Clr Screen");
      
 cp5.addButton("Replay")
     .setPosition(585,3)
     .setFont(font)
     .setSize(90,19)
     .setCaptionLabel("Replay Data");
  
 cp5.addButton("RescanPorts")
     .setPosition(585,23)
     .setFont(font)
     .setSize(90,19)
     .setCaptionLabel("Rescan Ports");
        
 cp5.addTextlabel("Label")
     .setText("Display:")
     .setPosition(680,3)
     .setColorValue(255)
     .setFont(font);
                    
 cp5.addRadioButton("Radio")
     .setPosition(685,25)
     .setFont(font)
     .setSize(15,15)
     .setItemsPerRow(3)
     .setSpacingColumn(34)
     .addItem("Graph", 0)
     .addItem("Text", 1)
     .setColorLabel(color(255))
     .activate(0);
     showGraph = true;
   
 valueFld = cp5.addTextarea("Value")
     .setPosition(780,3)
     .setSize(50, menuBarH - 6)
     .setColorBackground(0)
     .setFont(font)
     .setLineHeight(14);
 
 logFld = cp5.addTextlabel("Log")
     .setPosition(320,45)
     .setSize(360, 18)
     .setFont(font)
     .setLineHeight(14);
 
 cp5.addButton("Quit")
     .setPosition(width-60,3)
     .setFont(font)
     .setSize(50,19);
     
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "student_interface" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
