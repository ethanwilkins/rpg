// Very Abstract RPG

World world;
Gui gui;

void setup() {
  // sets main settings
  size(550, 700); smooth();
  // create main obj's
  world = new World();
  gui = new Gui();
}

void draw() {
  background(0);
  world.display();
  gui.display();
}