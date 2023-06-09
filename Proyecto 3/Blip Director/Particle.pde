class Particle {
  // Variables de clase
  float x;
  float y;
  float vx;
  float vy;
  float trackDistance;
  
  // Constructor
  Particle(float initSpeed) {
    // Posicion inicial
    x = width/2;
    y = height/2;
    float a = random(TWO_PI);
    float speed = initSpeed;
    // Variacion con base en la dirección y la velocidad
    vx = cos(a)*speed;
    vy = sin(a)*speed;
  }
  
  // Cambiamos la velocidad de movimiento
  void setSpeed(float speed){
    float a = random(TWO_PI);
    this.vx = cos(a)*speed;
    this.vy = sin(a)*speed;
  }
  
  // Renderiza la particula en la posición dada, 
  // con la opacidad con base en la particula trackeada 
  // y con el color de la camara en esa misma posicion de la particula.
  void display(float xTrack) {
    if(xTrack>x){
      trackDistance = xTrack-x;
    }
    else{
      trackDistance = x-xTrack;
    }
    noStroke();
    color c = cam.get(int(x),int(y));
    fill(c,100-100*(trackDistance/width));
    ellipse(width-x, y, 12, 12);
  }

  // Movemos la particula dentro de los limites de la pantalla
  void move() {
    x = x + vx;
    y = y + vy;
    if (y < 0) {
      y = height;
    } 

    if (y > height) {
      y = 0;
    }
    if (x < 0) {
      x = width;
    } 

    if (x > width) {
      x = 0;
    }
  }
}
