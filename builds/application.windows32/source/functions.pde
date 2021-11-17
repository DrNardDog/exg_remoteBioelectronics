void ClrScrn() {
  
 background(black);

}

void SerialPorts(int n) {
  
  // **** Request selected item from Map based on index n **** //
 
  portName = cp5.get(ScrollableList.class, "SerialPorts").getItem(n).get("name").toString();
  logFld.setText("portSelected: "+portName);
  background(black);

}

void Baud(int n) {
  
  baudRate = baud[n];
  logFld.setText("baudRate: "+baudRate);
  background(black);

}

void EmptyArray() {
  
  y.clear();

}

void Connect() {
  
  // **** Zero out data array **** //
  
  EmptyArray();
  port = new Serial(this, portName, baudRate);
  connected = true;
  logFld.setText("status: connected");

}

void Disconnect() {
  
  port.stop();
  yIn = 0;
  count = 0;
  connected = false;
  logFld.setText("status: disconnected");

}

void Save() {
  
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

void ScreenShot() {
  
 String dateTimeStr = getDateTime();
 String imageOut = dateTimeStr+".png";
 save(imageOut);
 logFld.setText("screenshot was saved to app folder");

}

void RescanPorts() {
  
 logFld.setText("ports rescanned");
 cp5.get(ScrollableList.class, "SerialPorts").clear();
 String[] ports = Serial.list();
 List p = Arrays.asList(ports);
 cp5.get(ScrollableList.class, "SerialPorts").addItems(p);
 
}

void fileSelected(File selection) {
 if (selection != null) {
  // reset required for multiple selections 
  index = 0;
  counter = 0;
  fileName = selection.getAbsolutePath(); 
  logFld.setText("File selected: " + fileName);
  data = loadStrings(selection.getAbsolutePath());
 }
}

void Open(){
 selectInput("Select a file to process:", "fileSelected");
}

void Replay(){
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

void Radio(int radioID) {
  
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

void Quit() {
  
  exit();

}
