// to algorithmically generate some map components or even some entire maps
// sets number of entities, set paths for navigating obstacles
// paths able to be analyzed for getting quickest route to dest

// once all nodes around the obstacle(s) are known
// can calculate best path by looping through different directions,
// breaking when an obstacle or wall is hit
// going direction of least possible weight: distance from starting point

class Map {
  ArrayList<Node> nodes;
  int gridSize;
  
  ArrayList<Entity> entities;
  User user;
  
  ArrayList<Obstacle> obstacles;
  
  Map () {
    buildGrid();
    buildObstacles();
    assembleEntities();
  }
  
  void display() {
    grid();
    obstacles();
    entities();
  }
  
  void update() {
  }
  
  void entities() {
    for (int i=0; i<entities.size(); i++) {
      Entity entity = entities.get(i);
      entity.display();
    }
    user.display();
  }
  
  void obstacles() {
    for (int i=0; i<obstacles.size(); i++) {
      Obstacle obstacle = obstacles.get(i);
      obstacle.display();
    }
  }
  
  void grid() {
    for (int i=0; i<nodes.size(); i++) {
      Node node = nodes.get(i);
      node.display();
    }
  }
  
  void buildGrid() {
    // for dimensions and density of grid
    gridSize = 100; nodeSize = ((width+height)/2)/gridSize;
    // initializes array of nodes for grid
    nodes = new ArrayList<Node>();
    // primitives to only be used locally
    boolean checker = true; int c = 0;
    for (float y=0; y<height; y+=nodeSize) {
      for (float x=0; x<width; x+=nodeSize) {
        // sets color pattern
        if (checker) {
          c = 150;
        } else {
          c = 0;
        }
        nodes.add(new Node(new PVector(x, y), nodeSize, color(c), 0));
        checker = !checker;
      } checker = !checker;
    }
  }
  
  void buildObstacles() {
    obstacles = new ArrayList<Obstacle>();
    for (int i=0; i<1; i++) {
      obstacles.add(new Obstacle(randomNode().loc));
    }
  }
  
  void assembleEntities() {
    user = new User(randomNode().loc);
    entities = new ArrayList<Entity>();
    for (int i=0; i < 2; i++) {
      entities.add(new Entity(randomNode().loc));
    }
  }
  
  Node randomNode() {
    return nodes.get(int(random(nodes.size())));
  }
  
  void aStar(Node start, Node goal) {
    // whats been explored so far
    ArrayList<Node> frontier = new ArrayList<Node>();
    // initializes with starting node
    frontier.add(new Node(start.loc, 0,0,0)); start = frontier.get(0);
    // starting node has no from vector with 0 cost
    start.cameFrom = null; start.costSoFar = 0;
    
    while (!frontier.isEmpty()) {
      Node current = frontier.get(frontier.size()-1);
      
      if (current.loc == goal.loc) {
        break;
      }
      
      for (int i=0; i<neighbors(current).size(); i++) {
        
      }
    }
  }
  
  ArrayList<Node> neighbors(Node current) {
    ArrayList<Node> neighbors = new ArrayList<Node>();
    for (int i=0; i<nodes.size(); i++) {
      Node node = nodes.get(i);
      
    }
    return neighbors;
  }
}

class Node {
  float size, priority, costSoFar;
  // location and from vector
  PVector loc, cameFrom;
  color _color;
  
  Node (PVector _loc, float s, color c, float p) {
    loc = _loc; size = s; _color = c; priority = p;
  }
  
  void display() {
    fill(_color);
    rectMode(CORNER);
    rect(loc.x, loc.y, size, size);
  }
}

class Obstacle {
  PVector loc; float w, h;
  color _color;
  
  Obstacle (PVector l) {
    loc = l; w = h = nodeSize*10;
    _color = color(0, 0, 255);
  }
  
  void display() {
    fill(_color);
    rectMode(CORNER);
    rect(loc.x, loc.y, w, h);
  }
}