void oscEvent(OscMessage message) {
  if(message.checkAddrPattern("/note1")) {
    println("nota1");
    
    currentMarioSprite = (currentMarioSprite+1) % marioSprites.length;
    currentMarioX = currentMarioX + (marioSprites[0].width/3);
    
    if(currentMarioX >= width) {
      currentMarioX = -marioSprites[0].width;
    }
    
    return;
  }
  
  if(message.checkAddrPattern("/note2")) {
    println("nota2");
    return;
  }
  
  if(message.checkAddrPattern("/note3")) {
    println("nota3");
    return;
  }
  
  if(message.checkAddrPattern("/note4")) {
    println("nota4");
    
    currentWorld = (currentWorld+1) % worlds.length;
    
    return;
  }
}
