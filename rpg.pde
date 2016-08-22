// Very Abstract RPG

// global for use by Entity
float nodeSize;

World world;
Gui gui;

void setup() {
  // sets main settings
  size(500, 500); smooth();
  // create main obj's
  world = new World();
  gui = new Gui();
}

void draw() {
  background(0);
  world.display();
  gui.display();
}