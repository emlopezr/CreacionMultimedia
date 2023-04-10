// Recibir mensajes en formato OSC de PureData
import netP5.*;
import oscP5.*;
OscP5 oscP5;

int currentMarioX = 0;
int currentMarioSprite = 0;
PImage[] marioSprites = new PImage[4];

int currentWorld = 0;
PImage[] worlds = new PImage[6];

void setup() {
  size(1200, 800); // Ratio 3:2
  frameRate(5); // 1 frame = 200ms
  background(0); // Fondo en negro
  
  // Conectarse al puerto 3434 para recibir mensajes
  oscP5 = new OscP5(this, 3434);
  
  // Cargar los sprites de Mario y reescarlarlos
  for (int i = 0; i < marioSprites.length; i++) {
    marioSprites[i] = loadImage("sprites/mario" + (i+1) + ".png");
    marioSprites[i] = resizePixelArt(marioSprites[i], marioSprites[i].width * 3, marioSprites[i].height * 3);
  }
  
  // Poner la posición de Mario fuera de la pantalla al inicio
  currentMarioX = -marioSprites[0].width;
  
  // Cargar los niveles y reescarlarlos
  for (int i = 0; i < worlds.length; i++) {
    worlds[i] = loadImage("worlds/world" + (i+1) + ".png");
    worlds[i] = resizePixelArt(worlds[i], width, height);
  }
}

void draw() {
  image(worlds[currentWorld], 0, 0);
  image(marioSprites[currentMarioSprite], currentMarioX, height-2*(marioSprites[currentMarioSprite].height)-10);
}
