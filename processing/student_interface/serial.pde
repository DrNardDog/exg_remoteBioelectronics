// **** Byte data sent without frame markers **** //

void serialEvent (Serial port) {
  
 int inByte = port.read();
 y = append(y,inByte);

 String inStr = str(inByte)+",\n"; // aommas added if data displayed and/or saved to file

 yIn = height - inByte;
 if(showText == true) {valueFld.append(inStr);}

}
