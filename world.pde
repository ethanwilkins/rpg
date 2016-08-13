// to account for maps of varying arrangement
// all maps and entities (including user)
//   will manifest and interface from World

class World {
  ArrayList<Entity> entities;
  User user;
  
  World () {
    genesis();
  }
  
  void genesis() {
    user = new User();
    entities = new ArrayList<Entity>();
    for (int i=0; i < 2; i++) {
      entities.add(new Entity());
    }
  }
  
  void display() {
    user.display();
    for (int i=0; i < entities.size(); i++) {
      Entity entity = entities.get(i);
      entity.display();
    }
  }
  
  void update() {
  }
}