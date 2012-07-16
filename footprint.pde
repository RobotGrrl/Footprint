/*
Creating a footprint picture on the solder layer of a pcb! (in gEDA)

Pretty simple example- and no GUI here.

CC BY-SA
robotgrrl.com

This is a good document to read about the structure of the .pcb file:
http://www.brorson.com/gEDA/land_patterns_20050129.pdf

This sketch is based off of this example:

// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 15-7: Displaying the pixels of an image

*/

PImage img;

PrintWriter output;

int x1 = 0;
int y1 = 0;

int t = 200; // thickness of line segment (aka pixel) 100
int c = t/4; // 2000

void setup() {
  
  img = loadImage("brrd.png"); // our input file (in the sketch data dir)
  
  size(img.width, img.height);
  
  output = createWriter("processing.fp"); // our output footprint
  
  output.println("\nElement[\"\" \"\" \"\" \"\" 1003 1003 0 0 0 100 \"\"]\n(");
  
  loadPixels();

  // We must also call loadPixels() on the PImage since we are going to read its pixels.
  img.loadPixels();
  for (int y = 0; y < height; y++ ) {
    for (int x = 0; x < width; x++ ) {
      int loc = x + y*width;
      // The functions red(), green(), and blue() pull out the three color components from a pixel.
      float r = red(img.pixels [loc]); 
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      
      if(x == 0) {
        x1 = 0;
      }
      
      if(r < 255.0 && g < 255.0 && b < 255.0) {
        
        output.println("\tPad["+x1+" "+y1+" "+x1+" "+y1+" "+t+" "+c+" 0 \"\" \"1\" \"square\"]");
        
        println("(" + x +", " + y + ")");
        
      }

      pixels[loc] = color(r,g,b);
      x1+=t;
      
    }
    
    y1+=t;
  
  }
  
  updatePixels();
  
  output.println("\n\t)");
  
  output.flush(); // Write the remaining data
  output.close(); // Finish the file
  println("done");
  exit(); // Stop the program
  
}

void draw() {
  
}

