float x = 0;
float y = 0;
float yoff = 0.0;
float grow = 1;
int circles = 0 ;
int totalCircles = 6;
float[] circlesY = new float[totalCircles];
boolean turnBack = false;
float noiseScale = 0.004;
float descent = 0;

void setup(){
  fullScreen(1);
  background(0);
  frameRate(30);
  curveTightness(-3);
  y=height/2;
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
      stroke(255);
      fill(0,0);
      curve(0, height/2, x, y+150*grow/2, width, 0, width, 0);
      //curve(100, 100, x+150*grow/2, y, 0, 0, 300, 500);
      //curve(100, 100, x, y-150*grow/2, 0, height, 300,500);
      //curve(100, 100, x-150*grow/2, y, width, height, 300,500);
      x-=5;   
      fill(255);
    stroke(0);
    ellipse(x, y, 150*grow, 150*grow);
    }
    else if(grow>=2){
      stroke(255);
      fill(0,0);
      curve(0, height/2, x, y+150*grow/2, width, 0, width, 0);
      fill(255);
      stroke(0);
      ellipse(x, y, 150*grow, 150*grow);
      blood();
      
      //curve(100, 100, x+150*grow/2, y, 0, 0, 300,500);
      //curve(100, 100, x, y-150*grow/2, 0, height, 300,500);
      //curve(100, 100, x-150*grow/2, y, width, height, 300,500);
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
for (int x=0; x < width; x++) {
    float noiseVal = noise((x)*noiseScale, noiseScale);
    stroke(255,0,0,90);
    line(x, 0, x, noiseVal*200+descent);
  }
  descent+=20;
}
