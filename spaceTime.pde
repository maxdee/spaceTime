  import oscP5.*;
import netP5.*;

//import processing.opengl.*;

/** 
* Title: a4_4<br>
* Name: Max D <br>
* Date: 13/11/11<br>
* Description: Create an interactive and dynamic composition that gives me a feeling of exhileration. (This might be easier to achieve after the lecture on arrays. Or maybe not.) <br> 
**/
OscP5 oscP5;
//Hyperdrive test
//I am not that big of a star wars fan, but I find hyperDrive very exhilerating.

//bunch of stars
Star[] star = new Star[1000];
//speed of ship
float speed = 1;
//if your people fixed the hyperdrive
boolean hyperDrive = false;
boolean rev = false;
boolean roty =false;
//focal length
float zoom = 700;

void setup() {
    oscP5 = new OscP5(this,8888);
  //cinematic
  size(1024, 768);
  //size(1280, 800);
  smooth(); 
  noCursor();
  //instantiate the stars
  for (int i = 0; i < star.length; i++) {
    star[i] = new Star();
  }
  strokeWeight(4);
}
float flt =0;
void draw() {
  //work with center 0,0
  
 translate(width/2, height/2);
if(roty)rotate(radians(flt));

if(!rev)flt+=speed/10;
if(rev)flt-=speed/10;
  if (!hyperDrive) {
    background(0);
         speed = 20*(float(mouseY)/width);
  }

  //update position in space
  for (int i = 0; i < star.length; i++) {
    star[i].draw();
  }
  noStroke();
  fill(0);

 // ellipse(0,0,200,200);
}

//punch it!  the 'space' button
void keyPressed() {
  //funny bug witht he space bar when exported...
  if (key==32 && !hyperDrive) {
    hyperDrive = true;
    speed+=speed;
  }
  if(key=='r')rev=!rev;
  if(key=='t')roty=!roty;
}
//back to normal
void keyReleased() {
  hyperDrive = false;
  speed=1;
}





void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/stars")==true) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("if")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      hyperDrive = boolean(theOscMessage.get(0).intValue());  
      speed = theOscMessage.get(1).floatValue(); 
      return;
    }  
  } 
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
