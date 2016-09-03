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
    
    aStar(nodes.get(0), nodes.get(5));
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
    for (int i=0; i<2; i++) {
      entities.add(new Entity(randomNode().loc));
    }
  }
  
  void aStar(Node start, Node goal) {
    // whats been explored so far
    ArrayList<Node> frontier = new ArrayList<Node>();
    // initializes with starting node
    frontier.add(start); start = frontier.get(0);
    // starting node has no from vector with 0 cost
    start.cameFrom = null; start.costSoFar = 0;
    start.costSoFarSet = true;
    
    while (!frontier.isEmpty()) {
      // needs to get node with the lowest costSoFar
      Node current = getLowestCostNode(frontier);
      
      // ends when goals reached
      if (current.loc == goal.loc) {
        break;
      }
      
      ArrayList<Node> neighbors = neighbors(current);
      for (int i=0; i<neighbors.size(); i++) {
        Node next = neighbors.get(i);
        
        if (next.costSoFarSet) {
          continue;
        }
        
        float newCost = current.costSoFar + graphCost(current, next);
        if (!next.costSoFarSet || newCost < next.costSoFar) {
          next.costSoFar = newCost; next.costSoFarSet = true;
          next.priority = newCost +
            dist(goal.loc.x, goal.loc.y, next.loc.x, next.loc.y);
          // points backwards (bread crumbs)
          next.cameFrom = current.loc;
          frontier.add(next);
        }
      }
      println("x: " + current.loc.x + " y: " + current.loc.y
        + " n: " + neighbors.size());
    }
    println(frontier.size());
  }
  
  ArrayList<Node> neighbors(Node current) {
    ArrayList<Node> neighbors = new ArrayList<Node>();
    for (int i=0; i<nodes.size(); i++) {
      Node node = nodes.get(i);
      if (canWalkHere(node) && dist(node.loc.x, node.loc.y,
        current.loc.x, current.loc.y) <= nodeSize) {
        neighbors.add(node);
      }
    }
    return neighbors;
  }
  
  boolean canWalkHere(Node node) {
    boolean canWalkHere = true;
    for (int i=0; i<obstacles.size(); i++) {
      Obstacle obs = obstacles.get(i);
      if (node.loc.x >= obs.loc.x && node.loc.x <= obs.loc.x+obs.w
        && node.loc.y >= obs.loc.y && node.loc.y <= obs.loc.y+obs.h) {
        canWalkHere = false;
      }
    }
    return canWalkHere;
  }
  
  Node randomNode() {
    return nodes.get(int(random(nodes.size())));
  }
  
  Node getLowestCostNode(ArrayList<Node> frontier) {
    Node lowestNode = frontier.get(0);
    for (int i=1; i<frontier.size(); i++) {
      Node node = frontier.get(i);
      if (node.costSoFar < lowestNode.costSoFar) {
        lowestNode = node;
      }
    }
    return lowestNode;
  }
  
  int graphCost(Node n1, Node n2) {
    float cost, xCost, yCost;
    xCost = abs(n1.loc.x - n2.loc.x);
    yCost = abs(n1.loc.y - n2.loc.y);
    cost = (xCost + yCost) / nodeSize;
    return int(cost);
  }
}

class Node {
  float size, priority, costSoFar;
  // location and from vector
  PVector loc, cameFrom;
  color _color;
  // whether it's been initialized
  boolean costSoFarSet;
  
  Node (PVector _loc, float s, color c, float p) {
    loc = _loc; size = s; _color = c; priority = p;
    costSoFarSet = false;
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