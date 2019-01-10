import java.util.Random;
public static class PositionHelper {
   public static PVector randomPosition(int width, int height) {
      Random randomno = new Random();
      if (randomno.nextBoolean()) {
        return new PVector((float)Math.random()*width, height);
      }
      return new PVector(width, (float)Math.random()*height);
  }
}

class Asteroid extends FlyingThing {

  float size;
  ArrayList<AsteroidGeometryPart> geometryParts = new ArrayList<AsteroidGeometryPart>();
  int granularity = 15;
  int minVary = 25;
  int maxVary = 75;  
  
  
  Asteroid() {
    super(PositionHelper.randomPosition(width, height),
    new PVector(random(-1,1), random(-1,1)));
  
    size = random(15,35);
    int minRadius = Math.round(size)-6;
    int maxRadius = Math.round(size)+6;
  
    for (double ang = 0; ang < 2 * PI; ang += 2 * PI / granularity)
    {
        float angleVaryPc = random(minVary, maxVary);
        float angleVaryRadians = (2 * PI / granularity) * (angleVaryPc) / 100;
        float angleFinal = (float) ang + angleVaryRadians - (PI / granularity);
        float radius = random(minRadius, maxRadius);
        geometryParts.add(new AsteroidGeometryPart(angleFinal,radius));
    }    
  }
  
  void render() {
    stroke(255);
    beginShape();
 
    for (AsteroidGeometryPart geometryPart : geometryParts) {
        float x = pos.x + sin(geometryPart.angle) * geometryPart.radius;
        float y = pos.y - cos(geometryPart.angle) * geometryPart.radius;     
        vertex(x, y);
      
    }
    endShape(CLOSE);
  }
  
  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }  
  
  String getSerialization() {
    return "asteroid " + super.getSerialization() + " " + size;
  } 
  
  void deserialize(String[] data) {
    super.deserialize(data);
    size = Float.parseFloat(data[4]);
  }
}
