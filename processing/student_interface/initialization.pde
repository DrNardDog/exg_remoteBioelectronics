import processing.serial.*;
import controlP5.*;
import java.util.*;

Serial port;
PrintWriter output;

ControlP5 cp5;
Textarea valueFld;
Textlabel logFld;

PFont font;
final int fntSize = 11;
final int menuBarW = 65;
color gray = color(0, 160, 100);

String[] data;
String fileName;

String portName;
int baudRate;
int[] baud = {115200};
int itemSelected;

int scalar = 2;
int index = 0;
int counter = 0;
int count = 0;
int inByte = 0;

float yIn;
float x1, y1, x2, y2;
float x3, y3, x4, y4;

color black = color(0,0,0);

boolean connected = false;
boolean showGraph = false;
boolean showText = false;

int[] y = new int[0];

String getDateTime()
{
 int s = second();
 int m = minute();
 int h = hour();
 int day = day();
 int mo = month();
 int yr = year();

// Avoid slashes which create folders
String date = nf(mo,2)+nf(day,2)+yr+"_";
String time = nf(h,2)+nf(m,2)+nf(s,2);
String dateTime = date+time;
return dateTime;
}

public void settings() {
  size(900, 450);
}
