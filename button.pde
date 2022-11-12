final int RESET       = 0;
final int LAND_LEFT   = 1;
final int LAND_RIGHT  = 2;
final int SPACE_LEFT  = 3;
final int SPACE_RIGHT = 4;

void setupButtons() {
  buttons = new Button[5];
  buttons[RESET] = new Button(RESET, 79, 935, 78, 939);
  buttons[LAND_LEFT] = new Button(LAND_LEFT, 540, 220, 540, 224);
  buttons[LAND_RIGHT] = new Button(LAND_RIGHT, 1739, 913, 1739, 917);
  buttons[SPACE_LEFT] = new Button(SPACE_LEFT, 562, 648, 562, 652);
  buttons[SPACE_RIGHT] = new Button(SPACE_RIGHT, 1030, 924, 1030, 928);
}

void displayButtons() {
  for (Button b : buttons) b.display();
}

void pressButtons(int x, int y) {
  for (Button b : buttons) b.press(x, y);
}

int releaseButtons(int x, int y) {
  int value = -1;
  for (Button b : buttons) {
    if (b.release(x, y)) value = b.type;
  }
  return value;
}

class Button {
  int type;
  int x_released, y_released, x_pressed, y_pressed;
  PImage imgReleased, imgPressed, imgHover;
  boolean pressed;
  
  Button(int t, int x_r, int y_r, int x_p, int y_p) {
    type = t;
    x_released = x_r;
    y_released = y_r;
    x_pressed = x_p;
    y_pressed = y_p;
    pressed = false;
    imgReleased = loadImage("data/images/button/button_" + type + "_released.png");
    imgPressed = loadImage("data/images/button/button_" + type + "_pressed.png");
    imgHover = loadImage("data/images/button/button_" + type + "_hover.png");
  }
  
  void display() {
    if (pressed) {
      tint(255, 255);
      image(imgPressed, x_pressed, y_pressed);
    }
    else {
      tint(255, 255);
      if (mouseX >= x_released && mouseX <= x_released+imgReleased.width && mouseY >= y_released && mouseY <= y_released+imgReleased.height) {
        image(imgHover, x_released, y_released);
      }
      else {
        image(imgReleased, x_released, y_released);
      }
    }
  }
  
  void press(int x, int y) {
    if (x >= x_released && x <= x_released+imgReleased.width && y >= y_released && y <= y_released+imgReleased.height) {
      pressed = true;
    }
  }
  
  boolean release(int x, int y) {
    if (!pressed) return false;
    pressed = false;
    if (x >= x_pressed && x <= x_pressed+imgPressed.width && y >= y_pressed && y <= y_pressed+imgPressed.height) {
      return true;
    }
    return false;
  }
}
