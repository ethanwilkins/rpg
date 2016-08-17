// to account for maps of varying arrangement
// all maps and entities (including user) will manifest from World

class World {
  ArrayList<Entity> entities;
  User user;
  Map map;
  
  World () {
    genesis();
  }
  
  void genesis() {
    map = new Map();
    user = new User();
    entities = new ArrayList<Entity>();
    for (int i=0; i < 2; i++) {
      entities.add(new Entity());
    }
  }
  
  void display() {
    map.display();
    user.display();
    for (int i=0; i < entities.size(); i++) {
      Entity entity = entities.get(i);
      entity.display();
    }
  }
  
  void update() {
  }
}