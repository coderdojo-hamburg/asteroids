class Bullet extends FlyingThing {

  Bullet(PVector pos, PVector speed) {
    super(pos, speed);
  }
  
  Bullet() {
    super();
  }
  
  void render() {
    strokeWeight(3);
    stroke(255,255,0);
    point(pos.x, pos.y);
    strokeWeight(1);
  }
  
  void update() {
    if (pos.x <= 10 || pos.x >= (width - 10) ||
      pos.y <= 10 || pos.y >= (height - 10)) {
      alive = false;
    }
    super.update();
  }
  
  String getSerialization() {
    return "bullet " + super.getSerialization();
  }  
}
