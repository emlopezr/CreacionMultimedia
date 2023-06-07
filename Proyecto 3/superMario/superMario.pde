// Recibir mensajes en formato OSC de PureData
import netP5.*;
import oscP5.*;
OscP5 oscP5;

int marioX = 0;
int marioSprite = 0;
boolean marioState = false;
PImage[] marioSprites = new PImage[4];
PImage[] miniSprites = new PImage[4];

int[][] objectPositions = new int[4][2];
int [] objectSprite = {0, 0, 0, 0};
int[] objectQuantity = {1, 4, 2, 6};
PImage[][] objectSprites = new PImage[objectQuantity.length][];

int world = 0;
PImage[] worlds = new PImage[7];

PFont marioFont;
int timeElapsed = 0;
int marioChanges = 0;

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
  
  // Cargar los sprites de Mario y reescarlarlos
  for (int i = 0; i < miniSprites.length; i++) {
    miniSprites[i] = loadImage("sprites/mini" + (i+1) + ".png");
    miniSprites[i] = resizePixelArt(miniSprites[i], miniSprites[i].width * 3, miniSprites[i].height * 3);
  }
  
  // Cargar los sprites de los objetos y reescalarlos
  for (int i = 0; i < objectQuantity.length; i++) {
    objectSprites[i] = new PImage[objectQuantity[i]];
    
    for (int j = 0; j < objectQuantity[i]; j++) {
      objectSprites[i][j] = loadImage("objects/object" + (i + 1) + "_" + (j+1) + ".png");
      objectSprites[i][j] = resizePixelArt(objectSprites[i][j], objectSprites[i][j].width * 3, objectSprites[i][j].height * 3);
    }
  }
  
  // Cargar los niveles y reescarlarlos al tamaño de pantalla
  for (int i = 0; i < worlds.length; i++) {
    worlds[i] = loadImage("worlds/world" + (i+1) + ".png");
    worlds[i] = resizePixelArt(worlds[i], width, height);
  }
  
  // Poner la posición de Mario fuera de la pantalla al inicio
  marioX = -marioSprites[0].width;
  
  // Posiciones iniciales alatorias de los objetos (1 y 2 horizontal, 3 y 4 vertical)
  objectPositions[0][0] = (int) random(width , width + 150);
  objectPositions[0][1] = (int) random(0, height-2*(marioSprites[marioSprite].height) - 150);
  
  objectPositions[1][0] = (int) random(width, width + 150);
  objectPositions[1][1] = (int) random(0, height-2*(marioSprites[marioSprite].height)-10);
  
  objectPositions[2][0] = (int) random(50, width - 50);
  objectPositions[2][1] = (int) random(-150, -objectSprites[2][0].height);
  
  objectPositions[3][0] = (int) random(50, width - 50);
  objectPositions[3][1] = (int) random(-150, -objectSprites[3][0].height);
  
  // Configurar la fuente
  marioFont = createFont("marioFont.ttf", 16);
  textFont(marioFont);
}

void draw() {
  // Pintar el color de fondo para limpiar la pantalla
  if(world == 1 || world == 3) {
    background(0);
  } else {
    background(96, 148, 252);
  }
  
  // Dibujar los objetos con su sprite y posición actual
  for(int i = 0; i < objectSprites.length; i++) {
    image(objectSprites[i][objectSprite[i]], objectPositions[i][0], objectPositions[i][1]);
  }
  
  // Dibujar el fondo actual
  image(worlds[world], 0, 0);
  
  // Dibujar el sprite actual, en la posición actual y en su estado actual (pequeño/grande)
  if(marioState) {
    image(marioSprites[marioSprite], marioX, height-2*(marioSprites[marioSprite].height)-10);
  } else {
    image(miniSprites[marioSprite], marioX, height-2*(miniSprites[marioSprite].height)-10);
  }
  
  // Escribir información del nivel
  textAlign(LEFT, CENTER);
  text("Mario\n" + marioChanges, 50, 50);
  
  textAlign(CENTER, CENTER);
  text("World\n1-"+ (world+1), width/2, 50);
  
  textAlign(RIGHT, CENTER);
  text("Time\n"+ timeElapsed, width-50, 50);
}
