// Very Abstract RPG
// classes: entity, user, combat style, world, quest, map, gui

ArrayList<Entity> entites;
World world;
User user;
Gui gui;

void setup() {
  // sets main settings
  size(600, 600);
  ellipseMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  smooth();
  // create main obj's
  world = new World();
  user = new User();
  gui = new Gui();
}

void draw() {
  background(0);
}