void setupTextbox() {
  textbox = new Textbox();
}

void displayTextbox() {
  textbox.display();
}

void pressTextbox() {
  textbox.press();
}

class Textbox {
  int duration = 20000;
  float x_dest = 80;
  float y_dest = 80;
  float a = 0.1;
  
  PImage imgTextbox;
  float x_curr, y_curr;
  float x_src, y_src;
  int time;
  boolean show;
  
  Textbox() {
    imgTextbox = loadImage("data/images/textbox.png");
    x_src = -(x_dest + imgTextbox.width);
    y_src = y_dest;
    x_curr = x_src;
    y_curr = y_src;
    time = millis();
    show = false;
  }
  
  void display() {
    if (!show && (mouseX != pmouseX || mouseY != pmouseY)) time = millis();
    if (millis() - time > duration) {
      show = true;
      tint(255, 255);
      image(imgTextbox, x_curr, y_curr);
      if (abs(x_curr - x_dest) < 0.5) return;
      x_curr += (x_dest - x_curr) * a;
    }
    else {
      if (abs(x_curr - x_src) < 0.5) return;
      tint(255, 255);
      image(imgTextbox, x_curr, y_curr);
      x_curr += (x_src - x_curr) * a;
    }
  }
  
  void press() {
    show = false;
    time = millis();
  }
}
