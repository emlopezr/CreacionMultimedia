int i = 100;
float x = 0;
int frame = 0;
int circles = 0 ;
int totalCircles = 6;
boolean turnBack = false;

void setup(){
  //size(width, height)
  fullScreen(1);
  background(0);
  frameRate(30);
  curveTightness(-3);
}

void draw(){
  fill(255);
    background(0);

  
  stroke(255);
  fill(0);
  curve(100, 100,x,height/2+75, width/3, 0 ,300,500);
  refresh();
  fill(255);
  stroke(0);
  ellipse(x, height/2, 150, 150);
  
  if(frameCount%30==0 && circles<totalCircles-1){
    circles++;
  }
  if(x<= width/totalCircles*5 && turnBack==false){
    x+=10.6;
  }else{
    turnBack=true;
    if(frame==0){
      frame = frameCount;
    }
    if(x>=width/2 && (frameCount-frame)/30>=2){
          x-=5;    
    }
  }
}

void refresh(){
  stroke(0);
  for(int i= 1; i <= circles; i++){
    float cColor = 255-(frameCount*5)+i*160;
    if(cColor > 0){
      fill(cColor);
    } else{ 
      fill(0);
    }
    ellipse((width/totalCircles*i) , height/2, 150, 150);  
    
    }
    
    
  
}
