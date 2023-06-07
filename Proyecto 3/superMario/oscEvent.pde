void oscEvent(OscMessage message) {
  // El tiempo sube en una unidad en cada mensaje OSC
  timeElapsed++;
  
  if(message.checkAddrPattern("/note1")) {
    // Mover a mario y cambiar el sprite de su animación
    marioSprite = (marioSprite+1) % marioSprites.length;
    marioX += marioSprites[0].width/3;
    
    if(marioX >= width) {
      marioX = -marioSprites[0].width;
    }
    
    return;
  }
  
  if(message.checkAddrPattern("/note2")) {
    // Cambiar el sprite de cada objeto
    for(int i = 0; i < objectSprites.length; i++) {
      objectSprite[i] = (objectSprite[i]+1) % objectSprites[i].length;
    }
    
    // Mover los objetos 1 y 2 hacia la izquierda
    objectPositions[0][0] -= objectSprites[0][0].width;
    objectPositions[1][0] -= objectSprites[1][0].width;
    
    // Mover los objetos 3 y 4 hacia abajo
    objectPositions[2][1] += objectSprites[2][0].height/2;
    objectPositions[3][1] += objectSprites[3][0].height/2;
    
    // Cuando salgan de la pantalla, volver a su posición inicial
    if (objectPositions[0][0] < 0) {
      objectPositions[0][0] = (int) random(width , width + 150);
      objectPositions[0][1] = (int) random(0, height-2*(marioSprites[marioSprite].height) - 150);
    }
    
    if (objectPositions[1][0] < 0) {
      objectPositions[1][0] = (int) random(width, width + 150);
      objectPositions[1][1] = (int) random(0, height-2*(marioSprites[marioSprite].height)-10);
    }
    
    if (objectPositions[2][1] > height) {
      objectPositions[2][0] = (int) random(150, width - 150);
      objectPositions[2][1] = (int) random(-150, 0);
    }
    
    if (objectPositions[3][1] > height) {
      objectPositions[3][0] = (int) random(150, width - 150);
      objectPositions[3][1] = (int) random(-150, 0);
    }
    
    return;
  }
  
  if(message.checkAddrPattern("/note3")) {
    // Cambiar el estado de Mario (Sprite normal/de fuego)
    marioState = !marioState;
    marioChanges++;
    
    return;
  }
  
  if(message.checkAddrPattern("/note4")) {
    // Cambiar el fondo actual
    world = (world+1) % worlds.length;
    
    return;
  }
}
