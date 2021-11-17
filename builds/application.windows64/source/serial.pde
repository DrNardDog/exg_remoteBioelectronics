// **** Byte data sent without frame markers **** //

void serialEvent (Serial port) {
  
 int inByte = port.read();
 y.append(inByte);
 yIn = height - inByte - 10;
 
 if(showText == true) {
   String inStr = str(inByte)+",\n"; 
   valueFld.append(inStr);
 }

}
