float x = 0;
float y = 0;
float yoff = 0.0;
float grow = 1;
int circles = 0 ;
int totalCircles = 6;
float[] circlesY = new float[totalCircles];
boolean turnBack = false;
float noiseScale = 0.0035;
float descent = -100;
int numberSpirals = 3;
float alphaColor = 0;

void setup(){
  fullScreen(1);
  background(0);
  frameRate(30);
  y=height/2;
  strokeWeight(4);
}

void draw(){
  
  // Actualización de colores al inicio de cada frame
  background(0);  
  fill(255);
  
  // Desplazamiento inicial hacioa la izquierda
  if(turnBack==false){
    
    // Render de las sombras de los circulos y desvanecimiento
    refresh();
    fill(255);
    
    // Posición aleatoria vertical
    yoff = yoff + .01;
    y = noise(1,yoff) * height;
    
    // Render del circulo principal
    ellipse(x, y, 150, 150);
  }
  
  // Aumento de las sombras del ciculo y se guarda la posición para el desvanecimiento
  if(frameCount%30==0 && circles<totalCircles-1){
    circles++;
    circlesY[circles]=y;
  }
  
  // Factor movimiento en X
  if(x<= width/totalCircles*5 && turnBack==false){
    x+=10.6;
  }
  
  // Segunda parte de la animación
  else
  {
    
    turnBack=true;
    
    // Factor de movimiento a la izquierda
    if(x>=width/2 && grow>=2){
      stroke(255, alphaColor);
      fill(0,0);
      
      for (int s = -numberSpirals; s <= numberSpirals; s++) {
        drawSpiral(1200*s, 500, x, y);
      }
      
      alphaColor += 25;
      x-=5;   
      fill(255);
    stroke(0);
    ellipse(x, y, 150*grow, 150*grow);
    }
    else if(grow>=2){
      stroke(255);
      fill(0,0);
      
      for (int s = -numberSpirals; s <= numberSpirals; s++) {
        drawSpiral(1200*s, 500, x, y);
      }
      
      fill(255);
      stroke(0);
      ellipse(x, y, 150*grow, 150*grow);
      blood();
    }
    //Factor de crecimiento
    else if(grow<2)
    {
      grow+=0.025;
      fill(255);
    stroke(0);
    ellipse(x, y, 150*grow, 150*grow);
    } 
  }
}

// Metodo para el render de las sombras y desvanecimiento
void refresh(){
  for(int i= 1; i <= circles; i++){
    float cColor = 255-(frameCount*5)+i*160;
    if(cColor > 0){
      fill(cColor);
    } else{ 
      fill(0);
    }
    ellipse((width/totalCircles*i) , circlesY[i], 150, 150);  
    
    }
      
}

void blood(){
  strokeWeight(4);
  for (int x=0; x < width; x += 4) {
      float noiseVal = noise((x)*noiseScale, noiseScale);
      stroke(255,0,0,90);
      line(x, 0, x, noiseVal*200+descent);
    }
    descent+=10;
}

// Espiral hiperbólica
void drawSpiral(float a, int totalPoints, float centerX, float centerY){
  // Para guardar coordenadas de la curva polar
  float[][] pointsSpiral = new float[totalPoints][2];
  float theta = 0;
  float x, y;
  
  // Generar coordenadas usando la formula: https://en.wikipedia.org/wiki/Hyperbolic_spiral
  for (int i=0; i<totalPoints; i++){
    theta += 0.5;
    x = centerX + a* cos(theta)/theta;
    y = centerY + a* sin(theta)/theta;
    
    // Guardar las coordenadas
    pointsSpiral[i][0] = x;
    pointsSpiral[i][1] = y;
  }

  // Dibujar la curva generada
  noFill();
  beginShape();
  curveVertex(pointsSpiral[0][0],  pointsSpiral[0][1]);
  for (int j=0; j<totalPoints; j++){
    curveVertex(pointsSpiral[j][0],  pointsSpiral[j][1]);
  }
  curveVertex(pointsSpiral[totalPoints-1][0],  pointsSpiral[totalPoints-1][1]);
  endShape();
}
