// The Character class
// class for all enemies, neutral npc's, or allies (conjured or otherwise)
// entities need to be able to wander or navigate a set path for any map
// and switch to and from a fighting state

class Entity {
  PVector loc;
  color _color;
  ArrayList<Item> bag;
  
  Entity () {
    loc = new PVector(random(width), random(height));
    _color = color(255, 0, 0);
  }
  
  void display() {
    noStroke();
    fill(_color);
    rectMode(CENTER);
    rect(loc.x, loc.y, 25, 25);
  }
  
  void update() {
  }
}

// close quarters combat, direct contact
// slow but has the most health and defense, can wear heavy armour
// best against rangers, weak against mages
class Melee {
}

// uses an array of projectile, arial, and conjuration attacks
// medium speed with lowest health or defense
// best against melee, weak against rangers
class Mage {
}

// attacks from the longest distance
// can tame wild creatures to make as ally/familiar
// fastest in speed with medium health/defense
// best against mages, weak against melee
class Ranger { 
}