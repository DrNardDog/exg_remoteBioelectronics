// **** Byte data sent without frame markers **** //
// **** Commas added if data displayed and/or saved to file. **** //
void serialEvent (Serial port) {
 int inByte = port.read();
 y = append(y,inByte);
 String inStr = str(inByte)+",\n";
 yIn = height - inByte;
 if(showText == true) {valueFld.append(inStr);}
}
