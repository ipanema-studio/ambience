import ddf.minim.*;

Minim minim;
Tag[] tags;
Land[] lands;
Space[] spaces;
Objet[] objets;
Button[] buttons;
Textbox textbox;

void setup() {
  //fullScreen();
  size(1920, 1080);
  minim = new Minim(this);
  setupTags();
  setupLands();
  setupSpaces();
  setupObjets();
  setupButtons();
  setupTextbox();
}

void draw() {
  background(255);
  displayLandsLand();
  displayLandsDecoBack();
  displaySpacesSpace();
  displaySpacesDeco();
  displayButtons();
  displayLandsDecoFore();
  displayObjets();
  displayTags();
  displayTextbox();
}

void mousePressed() {
  pressButtons(mouseX, mouseY);
  pressObjets(mouseX, mouseY);
  pressTextbox();
}

void mouseDragged() {
  dragObjet(mouseX, mouseY);
}

void mouseReleased() {
  int type = -1;
  int value = releaseButtons(mouseX, mouseY);
  if (value == LAND_LEFT) type = prevLand();
  else if (value == LAND_RIGHT) type = nextLand();
  else if (value == SPACE_LEFT) type = prevSpace();
  else if (value == SPACE_RIGHT) type = nextSpace();
  else if (value == RESET) {
    resetTag();
    resetLand();
    resetSpace();
    resetObjet();
  }
  if (type != -1) selectTag(type);
  releaseObjet();
}
