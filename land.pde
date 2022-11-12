int curLandIdx;

void setupLands() {
  lands = new Land[LANDS.length];
  for (int i = 0; i != lands.length; i++) {
    lands[i] = new Land(LANDS[i]);
    if (lands[i].type == INITIAL) {
      lands[i].select();
      curLandIdx = i;
    }
  }
}

void displayLandsLand() {
  for (Land l : lands) {
    l.displayLand();
  }
}

void displayLandsDecoBack() {
  for (Land l : lands) {
    l.displayDecoBack();
  }
}

void displayLandsDecoFore() {
  for (Land l : lands) {
    l.displayDecoFore();
  }
}

int nextLand() {
  lands[curLandIdx].unselect();
  curLandIdx++;
  if (curLandIdx == lands.length) curLandIdx = 0;
  lands[curLandIdx].select();
  return lands[curLandIdx].type;
}

int prevLand() {
  lands[curLandIdx].unselect();
  curLandIdx--;
  if (curLandIdx < 0) curLandIdx = lands.length-1;
  lands[curLandIdx].select();
  return lands[curLandIdx].type;
}

void resetLand() {
  lands[curLandIdx].unselect();
  for (int i = 0; i != lands.length; i++) {
    if (lands[i].type == INITIAL) {
      curLandIdx = i;
      break;
    }
  }
  lands[curLandIdx].select();
}

class Land {
  AudioPlayer sound;
  int volume;
  PImage imgLand, imgDecoFore, imgDecoBack;
  boolean show;
  int opacity;
  int type;
  int ypos;
  
  Land(int t) {
    type = t;
    opacity = 0;
    show = false;
    ypos = -32;
    imgLand = loadImage("data/images/land/land_" + type + ".png");
    imgDecoFore = loadImage("data/images/land/land_" + type + "_deco_fore.png");
    imgDecoBack = loadImage("data/images/land/land_" + type + "_deco_back.png");
    if (type != INITIAL) {
      sound = minim.loadFile("data/sounds/" + type + ".mp3");
      volume = -40;
      sound.setGain(volume);
    }
  }
  
  void displayLand() {
    if (show) {
      if (opacity < 255) opacity += 15;
      tint(255, opacity);
      image(imgLand, 0, 0);
      if (type != INITIAL) {
        if (volume == -40) sound.loop();
        if (volume < 0) {
          volume += 1;
          sound.setGain(volume);
        }
      }
      
    }
    else {
      if (opacity != 0) {
        opacity -= 15;
        tint(255, opacity);
        image(imgLand, 0, 0);
      }
      if (type != INITIAL) {
        if (volume > -40) {
          volume -= 1;
          sound.setGain(volume);
        }
        if (volume == -40) {
          sound.pause();
          sound.rewind();
        }
      }
    }
  }
  
  void displayDecoFore() {
    if (show) {
      tint(255, opacity);
      image(imgDecoFore, 0, ypos);
      if (ypos < 0) ypos += 1;
    }
    else {
      if (opacity != 0) {
        tint(255, opacity);
        image(imgDecoFore, 0, ypos);
        if (ypos > -32) ypos -= 1;
      }
    }
  }
  
  void displayDecoBack() {
    if (show) {
      tint(255, opacity);
      image(imgDecoBack, 0, ypos);
      if (ypos < 0) ypos += 1;
    }
    else {
      if (opacity != 0) {
        tint(255, opacity);
        image(imgDecoBack, 0, ypos);
        if (ypos > -32) ypos -= 1;
      }
    }
  }
  
  void select() {
    show = true;
  }
  
  void unselect() {
    show = false;
  }
}
