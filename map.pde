// to algorithmically generate some map components or even some entire maps
// sets number of entities, set paths for navigating obstacles
// paths able to be analyzed for getting quickest route to dest

// once all nodes around the obstacle(s) are known
// can calculate best path by looping through different directions,
// breaking when an obstacle or wall is hit
// going direction of least possible weight: distance from starting point

class Map {
  ArrayList<Node> nodes;
  float nodeSize;
  int gridSize;
  
  Map () {
    gridSize = 100;
    nodeSize = ((width+height)/2)/gridSize;
    nodes = new ArrayList<Node>();
    buildGrid();
  }
  
  void display() {
    grid();
  }
  
  void update() {
  }
  
  void grid() {
    for (int i=0; i<nodes.size(); i++) {
      Node node = nodes.get(i);
      node.display();
    }
  }
  
  void buildGrid() {
    boolean checker = true; int c = 0;
    for (float y=0; y<height; y+=nodeSize) {
      for (float x=0; x<width; x+=nodeSize) {
        // sets color pattern
        if (checker) {
          c = 150;
        } else {
          c = 0;
        }
        nodes.add(new Node(x, y, nodeSize, color(c)));
        checker = !checker;
      } checker = !checker;
    }
  }
}

class Node {
  float size;
  PVector loc;
  color _color;
  
  Node (float x, float y, float s, color c) {
    loc = new PVector(x, y);
    size = s; _color = c;
  }
  
  void display() {
    fill(_color);
    rectMode(CORNER);
    rect(loc.x, loc.y, size, size);
  }
}