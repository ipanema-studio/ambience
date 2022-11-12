int curSpaceIdx;

void setupSpaces() {
  spaces = new Space[SPACES.length];
  for (int i = 0; i != spaces.length; i++) {
    spaces[i] = new Space(SPACES[i]);
    if (spaces[i].type == INITIAL) {
      spaces[i].select();
      curSpaceIdx = i;
    }
  }
}

void displaySpacesSpace() {
  for (Space s : spaces) {
    s.displaySpace();
  }
}

void displaySpacesDeco() {
  for (Space s : spaces) {
    s.displayDeco();
  }
}

int nextSpace() {
  spaces[curSpaceIdx].unselect();
  curSpaceIdx++;
  if (curSpaceIdx == spaces.length) curSpaceIdx = 0;
  spaces[curSpaceIdx].select();
  return spaces[curSpaceIdx].type;
}

int prevSpace() {
  spaces[curSpaceIdx].unselect();
  curSpaceIdx--;
  if (curSpaceIdx < 0) curSpaceIdx = spaces.length-1;
  spaces[curSpaceIdx].select();
  return spaces[curSpaceIdx].type;
}

void resetSpace() {
  spaces[curSpaceIdx].unselect();
  for (int i = 0; i != spaces.length; i++) {
    if (spaces[i].type == INITIAL) {
      curSpaceIdx = i;
      break;
    }
  }
  spaces[curSpaceIdx].select();
}

class Space {
  AudioPlayer sound;
  int volume;
  PImage imgSpace, imgDeco;
  boolean show;
  int opacity;
  int type;
  int ypos;
  
  Space(int t) {
    type = t;
    opacity = 0;
    show = false;
    ypos = -16;
    imgSpace = loadImage("data/images/space/space_" + type + ".png");
    imgDeco = loadImage("data/images/space/space_" + type + "_deco.png");
    if (type != INITIAL) {
      sound = minim.loadFile("data/sounds/" + type + ".mp3");
      volume = -40;
      sound.setGain(volume);
    }
  }
  
  void displaySpace() {
    if (show) {
      if (opacity < 255) opacity += 15;
      tint(255, opacity);
      image(imgSpace, 0, 0);
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
        image(imgSpace, 0, 0);
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
  
  void displayDeco() {
    if (show) {
      tint(255, opacity);
      image(imgDeco, 0, ypos);
      if (ypos < 0) ypos += 1;
    }
    else {
      if (opacity != 0) {
        tint(255, opacity);
        image(imgDeco, 0, ypos);
        if (ypos > -16) ypos -= 1;
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
