void draw() {
 // **** Menu Bar **** // 
 fill(128);
 rect(0, 0, width-1, menuBarW);
 // **** Graph of data from serial connection **** //
 if (connected && showGraph){
   if (count > width) {
    count = 0;
    background(black);
    }  
   if (count == 0) {
     x1 = count;
     y1 = yIn;
    }  
   if (count > 0) {
     x2 = count;
     y2 = yIn;
     stroke(255);
     line(x1, y1, x2, y2);
     x1 = x2;
     y1 = y2; 
     } 
    count++;
 }else { 
 // **** Graph of saved file with comma separated values **** // 
 if (data != null){
  if (index < data.length){
    String[] pieces = split(data[index], ",");   
    if (counter > width){
     counter = 0;
     background(black);
    }
    if (counter == 0) {
      x3 = 0;
      y3 = height - float(pieces[0]);
    } 
    if (counter > 0){
    // println("["+index+"] "+pieces[0]);   
     x4 = counter;
     y4 = height - float(pieces[0]);
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
