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
