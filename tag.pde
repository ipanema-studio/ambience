void setupTags() {
  tags = new Tag[TAGS.length];
  for (int i = 0; i != tags.length; i++) {
    tags[i] = new Tag(TAGS[i]);
  }
}

void displayTags() {
  for (Tag t : tags) {
    t.display();
  }
}

void selectTag(int type) {
  for (Tag t : tags) {
    if (t.type == type) t.select();
    else t.unselect();
  }
}

void resetTag() {
  for (Tag t : tags) t.unselect();
}

class Tag {
  int duration = 3000;
  int xpos = 80;
  int ypos = 80;
  
  PImage imgTag;
  boolean show;
  int opacity;
  int type;
  int time;
  
  Tag(int t) {
    type = t;
    opacity = 0;
    show = false;
    imgTag = loadImage("data/images/tag/tag_" + type + ".png");
    time = millis();
  }
  
  void display() {
    if (show) {
      if (opacity < 255) opacity += 15;
      tint(255, opacity);
      image(imgTag, xpos, ypos);
      if (millis() - time > duration) show = false;
    }
    else {
      if (opacity != 0) {
        opacity -= 15;
        tint(255, opacity);
        image(imgTag, xpos, ypos);
      }
    }
  }
  
  void select() {
    show = true;
    time = millis();
  }
  
  void unselect() {
    show = false;
  }
}
