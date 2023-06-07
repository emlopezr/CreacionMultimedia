class Particle {
  float x;
  float y;
  
  float vx;
  float vy;

  Particle(float initSpeed) {
    x = width/2;
    y = height/2;
    float a = random(TWO_PI);
    float speed = initSpeed;
    vx = cos(a)*speed;
    vy = sin(a)*speed;
  }
  
  void setSpeed(float speed){
    float a = random(TWO_PI);
    this.vx = cos(a)*speed;
    this.vy = sin(a)*speed;
  }

  void display() {
    noStroke();
    color c = cam.get(int(x),int(y));
    fill(c,25);
    ellipse(width-x, y, 12, 12);
    

  }

  void move() {
    x = x + vx;//random(-5, 5);
    y = y + vy;//random(-5, 5);
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
