abstract class FlyingThing {
  PVector pos;
  PVector speed;
  boolean alive = true;
  
  FlyingThing(PVector pos, PVector speed) {
    this.pos = pos.get();
    this.speed = speed.get();
  }
  
  FlyingThing() {
  }
  
  void update()  {
    pos.add(speed);
    if (pos.x > width) {
      pos.x = 0;
    }
    if (pos.y > height) {
      pos.y = 0;
    }
    if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y < 0) {
      pos.y = height;
    }
  }
  
  String getSerialization() {
    return pos.x + " " + pos.y + " " + speed.x + " " + speed.y;
  }
  
  void deserialize(String[] data) {
    pos = new PVector(Float.parseFloat(data[0]),Float.parseFloat(data[1]));
    speed = new PVector(Float.parseFloat(data[2]),Float.parseFloat(data[3]));
    System.out.println("deserialize with pos: "+pos.x+" "+pos.y+" speed: "+speed.x+" "+speed.y);
  }  
  
  abstract void render();
}
