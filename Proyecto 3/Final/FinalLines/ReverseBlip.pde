import processing.video.*;
import processing.sound.*;

// Variables para el control de la animacion de particulas
Particle[] particles;
boolean start = false;
float speed = random(1,3);

// Variables de trackeo de color
color trackColor; 
float threshold = 25;

// Variable para hacer referencia a la camara
Capture cam;

// Variable para hacer referencia a la musica
SoundFile original;
SoundFile metal;

void setup() {
  size(640, 480);
  cam = new Capture(this, 640,480);
  cam.start();
  particles = new Particle [1000];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(speed);
  }
  background(0);
  trackColor = color(0, 255, 0);
  original = new SoundFile(this, "Original-Mono.mp3");
  metal = new SoundFile(this, "Metal-Mono.mp3");

}

void captureEvent(Capture video){
video.read();
}


void draw() {
  if(start){
    cam.loadPixels();
   
    for (int i = 0; i < particles.length; i++) {
      particles[i].display();
      particles[i].move();
    }
    float avgX = 0;
    float avgY = 0;
  
    int count = 0;
  
    // Begin loop to walk through every pixel
    for (int x = 0; x < cam.width; x++ ) {
      for (int y = 0; y < cam.height; y++ ) {
        int loc = x + y * cam.width;
        // What is current color
        color currentColor = cam.pixels[loc];
        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);
        float r2 = red(trackColor);
        float g2 = green(trackColor);
        float b2 = blue(trackColor);
  
        float d = distSq(r1, g1, b1, r2, g2, b2); 
  
        if (d < threshold) {
         
          avgX += x;
          avgY += y;
          count++;
        }
      }
    }
  
    // We only consider the color found if its color distance is less than 10. 
    // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
    if (count > 0) { 
      avgX = avgX / count;
      avgY = avgY / count;
      // Draw a circle at the tracked pixel
      strokeWeight(2.0);
      stroke(trackColor);
      ellipse(width-avgX, avgY, 16, 16);
      for (int i = 0; i < particles.length; i++) {
        speed = 5*((height-avgY)/height);
        particles[i].setSpeed(speed);
      }
      original.rate(2*(height-avgY)/height);
      original.pan(-1*map(width-avgX, 0, width, -1.0, 1.0));
      metal.rate(2*(height-avgY)/height);
      metal.pan(-1*map(width-avgX, 0, width, 1.0, -1.0));
    }
  }
  else {
    cam.loadPixels();
    image(cam, 0, 0);
    pushMatrix();
    scale(-1.0, 1.0);
    image(cam, -cam.width, 0);
    popMatrix();
  } 
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
  if(!start){
    start=true;
    original.play();
    metal.play();
    background(0);
    int loc = width-mouseX + mouseY*cam.width;
    trackColor = cam.pixels[loc];
  }
}
