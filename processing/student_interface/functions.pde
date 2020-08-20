void ClrScrn() {
 background(black);
}

void SerialPorts(int n ) {
 /* request selected item from Map based on index n */
 portName = cp5.get(ScrollableList.class, "SerialPorts").getItem(n).get("name").toString();
 logFld.setText("portSelected: "+portName);
 background(black);
}

void Baud(int n ) {
  baudRate = baud[n];
  logFld.setText("baudRate: "+baudRate);
  background(black);
}

void EmptyArray(){
  y = new int[0];
}

void Connect() {
 // **** Zero out data array **** //
 EmptyArray();
 port = new Serial(this, portName, baudRate);
 connected = true;
 logFld.setText("Connect btn was hit.");
}

void Disconnect() {
  port.stop();
  yIn = 0;
  count = 0;
  connected = false;
  logFld.setText("Disconnect button was hit.");
}

void Save() {
  String dateTimeStr = getDateTime();
  String fileToSave = dateTimeStr+".txt";
  String[] data = new String[y.length];
  for (int i = 0; i < y.length; i++) {
    data[i] = y[i]+",";
  }
  saveStrings(fileToSave, data);
  logFld.setText("Data was saved to a file in app folder.");
}

void ScreenShot() {
 String dateTimeStr = getDateTime();
 String imageOut = dateTimeStr+".png";
 save(imageOut);
 logFld.setText("Screenshot was saved to app folder.");
}

void RescanPorts() {
 logFld.setText("Rescan ports.");
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
   logFld.setText("There is no file selected.");
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
    case(0):logFld.setText("Graph selected as output.");
     showGraph = true;
     showText = false;
     break;
    case(1):logFld.setText("Text selected as output.");
     showGraph = false;
     showText = true;
     break;  
  }
} 

void Quit() {
  exit();
}
