// to account for maps of varying arrangement
// all maps and entities (including user) will manifest from World

class World {
  Map map;
  
  World () {
    genesis();
  }
  
  void genesis() {
    map = new Map();
  }
  
  void display() {
    map.display();
  }
  
  void update() {
  }
}