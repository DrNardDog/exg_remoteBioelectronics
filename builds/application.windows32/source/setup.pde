void setup() {
 
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
