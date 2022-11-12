int curObjetIdx;

void setupObjets() {
  objets = new Objet[OBJETS.length];
  curObjetIdx = -1;
  
  objets[0] = new Objet(OBJETS[0], 1012, 55);
  objets[1] = new Objet(OBJETS[1], 1219, 32);
  objets[2] = new Objet(OBJETS[2], 1161, 119);
  objets[3] = new Objet(OBJETS[3], 1706, 99);
  objets[4] = new Objet(OBJETS[4], 1639, 25);
  objets[5] = new Objet(OBJETS[5], 1556, 297);
  objets[6] = new Objet(OBJETS[6], 1656, 318);
  objets[7] = new Objet(OBJETS[7], 1621, 201);
  objets[8] = new Objet(OBJETS[8], 1719, 213);
  objets[9] = new Objet(OBJETS[9], 1760, 288);
  objets[10] = new Objet(OBJETS[10], 1685, 475);
  objets[11] = new Objet(OBJETS[11], 1404, 189);
  objets[12] = new Objet(OBJETS[12], 1523, 131);
  objets[13] = new Objet(OBJETS[13], 1329, 112);
  objets[14] = new Objet(OBJETS[14], 1414, 34);
}

void displayObjets() {
  for (int i = objets.length - 1; i >= 0; i--) {
    objets[i].display();
  }
}

void pressObjets(int x, int y) {
  for (int i = 0; i != objets.length; i++) {
    if (objets[i].press(x, y)) {
      curObjetIdx = i;
      return;
    }
  }
  curObjetIdx = -1;
}

void dragObjet(int x, int y) {
  if (curObjetIdx == -1) return;
  objets[curObjetIdx].drag(x, y);
}

void releaseObjet() {
  if (curObjetIdx == -1) return;
  objets[curObjetIdx].release();
  curObjetIdx = -1;
}

void resetObjet() {
  for (Objet o : objets) o.reset();
}

class Objet {
  float a = 0.1;
  
  AudioPlayer sound;
  int volume;
  PImage imgObjet;
  int opacity;
  int type;
  boolean pressed;
  boolean initialized;
  int x_src, y_src;
  float x_curr, y_curr;
  float x_dis, y_dis;
  
  Objet(int t, int x, int y) {
    type = t;
    opacity = 0;
    pressed = false;
    initialized = false;
    x_src = x;
    y_src = y;
    x_curr = x_src;
    y_curr = y_src;
    imgObjet = loadImage("data/images/objet/objet_" + type + ".png");
    sound = minim.loadFile("data/sounds/" + type + ".mp3");
    volume = -40;
    sound.setGain(volume);
  }
  
  void display() {
    tint(255, 255);
    image(imgObjet, x_curr, y_curr);
    if (y_curr > map(x_curr, 882, 1861, 98, 663)) {
      if (volume == -40) {
        sound.loop();
        selectTag(type);
      }
      if (volume < 0) {
        volume += 1;
        sound.setGain(volume);
      }
    }
    else {
      if (volume > -40) {
        volume -= 1;
        sound.setGain(volume);
      }
      if (volume == -40) {
        sound.pause();
        sound.rewind();
      }
    }
    
    if (initialized) {
      if (abs(x_curr - x_src) + abs(y_curr - y_src) < 1) {
        x_curr = x_src;
        y_curr = y_src;
        initialized = false;
        return;
      }
      x_curr += (x_src - x_curr) * a;
      y_curr += (y_src - y_curr) * a;
    }
  }
  
  boolean press(int x, int y) {
    if (x >= x_curr && x <= x_curr+imgObjet.width && y >= y_curr && y <= y_curr+imgObjet.height) {
      pressed = true;
      x_dis = x - x_curr;
      y_dis = y - y_curr;
      return true;
    }
    return false;
  }
  
  void drag(int x, int y) {
    if (!pressed) return;
    x_curr = x - x_dis;
    y_curr = y - y_dis;
  }
  
  void release() {
    pressed = false;
  }
  
  void reset() {
    initialized = true;
  }
}
