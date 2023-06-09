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
  
  // Intanciamos la captura por camara
  cam = new Capture(this, 640,480);
  // Iniciamos la captura
  cam.start();
  
  // Creamos las particulas
  particles = new Particle [1000];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(speed);
  }
  
  background(0);
  
  // Instanciamos los audios
  original = new SoundFile(this, "Original-Mono.mp3");
  metal = new SoundFile(this, "Metal-Mono.mp3");
}

void captureEvent(Capture cam){
  // Cada que haya un evento de captura leemos la información capturada
  cam.read();
}


void draw() {
  if(start){
    
    // Cargamos los pixeles de la grabación
    cam.loadPixels();
    
    // Variabes auxiliares para la posición del color trackeado
    float avgX = 0;
    float avgY = 0;
    int count = 0;
  
    // Loop para recorrer todos los pixeles captados por la camara pixel
    for (int x = 0; x < cam.width; x++ ) {
      for (int y = 0; y < cam.height; y++ ) {
        int loc = x + y * cam.width;
        // Color actual que esta siendo renderizado en cada pixel
        color currentColor = cam.pixels[loc];
        
        // Valores de color del pixel actual y el pooxel trackeado
        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);
        float r2 = red(trackColor);
        float g2 = green(trackColor);
        float b2 = blue(trackColor);
        
        // Distancia entre el color del pixel actual y el pixel trackeado
        float d = distSq(r1, g1, b1, r2, g2, b2); 
  
         // Si la distancia es menor al margen lo incluimos en el conteo
        if (d < threshold) {
          avgX += x;
          avgY += y;
          count++;
        }
      }
    }
    
    // Si ya hemos encontrado al menos un pixel calculamos el promedio de las coordenadas de todos los pixeles encontrados
    // Pintamos un circulo en la posicion del color trackeado
    if (count > 0) { 
      avgX = avgX / count;
      avgY = avgY / count;
      strokeWeight(2.0);
      stroke(trackColor);
      ellipse(width-avgX, avgY, 16, 16);
     
      // Cambiamos la velocidad y el panneo de los audios con base en la posicion del color trackeado
      original.rate(2*(height-avgY)/height);
      original.pan(-1*map(width-avgX, 0, width, -1.0, 1.0));
      metal.rate(2*(height-avgY)/height);
      metal.pan(map(width-avgX, 0, width, -1.0, 1.0));
      
    
      // Cambiamos la velocidad de movimiento de las particulas con base en la altura del color trackeado
      for (int i = 0; i < particles.length; i++) {
        speed = 5*((height-avgY)/height);
        particles[i].setSpeed(speed);
      }
      
    }
   
   // Movemos cada particula
   for (int i = 0; i < particles.length; i++) {
      particles[i].display(avgX);
      particles[i].move();
    }
  }
  
  else {
    // Se cargan los pixeles del la infromación de la camara y se renderizan en pantalla
    cam.loadPixels();
    image(cam, 0, 0);
    
    // Correción del reflejo de grabación
    pushMatrix();
    scale(-1.0, 1.0);
    image(cam, -cam.width, 0);
    popMatrix();
  } 
}

// Calcula la distancia entre dos puntos
float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

// Ejecuta la animacion y los audios cuando se de clic 
void mousePressed() {
  if(!start){
    start=true;
    original.play();
    metal.play();
    background(0);
    // Saca la localización del pixel seleccionado por clic
    int loc = width-mouseX + mouseY*cam.width;
    trackColor = cam.pixels[loc];
  }
}
