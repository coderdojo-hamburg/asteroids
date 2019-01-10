class Ship extends FlyingThing {

  float angle = 0;
  
  Ship(PVector pos, PVector speed) {
    super(pos, speed);
  }
  
  Ship() {
    super();
  }
  
  void render() {
    pushMatrix();
    
    translate(pos.x, pos.y);
    rotate(angle);
    stroke(255);
    triangle(-10, 10, 0, -20, 10, 10);
    
    popMatrix();
  }
  
  void thrustForward(float amount) {
    PVector thrust = new PVector(0, -amount);
    thrust.rotate(angle);
    speed.add(thrust);
  }
  
  boolean checkCollision(Asteroid ast) {
    if (pos.dist(ast.pos) < (ast.size/2 + 20)) {
      return true;
    } 
    return false;
  }
  
  Bullet fire() {
    PVector sp = new PVector(0, -4);
    sp.rotate(angle);
    PVector firingDistance = new PVector(0, -20);
    firingDistance.rotate(angle);
    Bullet b = new Bullet(pos.get().add(firingDistance), sp);
    return b;
  }  
  
  String getSerialization() {
   return "ship " + super.getSerialization() + " " + angle;
  }
  
  void deserialize(String[] data) {
    super.deserialize(data);
    angle = Float.parseFloat(data[4]);
  }
}
