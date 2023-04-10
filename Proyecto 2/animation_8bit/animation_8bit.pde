int currentFrame = 0;
int currentSprite = 0;
PImage[] marioSprites = new PImage[4];

void setup() {
  size(480, 480);
  background(0);
  frameRate(5); // 1 frame cada 200ms
  
  // Cargar los sprites de Mario y reescarlarlos
  for (int i = 0; i < marioSprites.length; i++) {
    marioSprites[i] = loadImage("sprites/mario" + (i+1) + ".png");
    
    int newWidth = marioSprites[i].width * 10;
    int newHeight = marioSprites[i].height * 10;
    marioSprites[i] = resizePixelArt(marioSprites[i], newWidth, newHeight);
  }
}

void draw() {
  image(marioSprites[currentSprite], 0, 0);
  currentSprite = (currentSprite+1) % marioSprites.length;
  
  currentFrame++;
}

// Algoritmo para agrandar los pixel arts sin perder calidad (Nearest-neighbor interpolation)
PImage resizePixelArt(PImage pixelArt, int newWidth, int newHeight) {
  PImage resizedImage = createImage(newWidth, newHeight, ARGB);
  
  pixelArt.loadPixels();
  resizedImage.loadPixels();
  
  for (int x = 0; x < newWidth; x++) {
    for (int y = 0; y < newHeight; y++) {
      int oldX = (int) map(x, 0, newWidth, 0, pixelArt.width);
      int oldY = (int) map(y, 0, newHeight, 0, pixelArt.height);
      int oldIndex = oldY * pixelArt.width + oldX;
      int newIndex = y * newWidth + x;
      resizedImage.pixels[newIndex] = pixelArt.pixels[oldIndex];
    }
  }
  resizedImage.updatePixels();
  return resizedImage;
}
