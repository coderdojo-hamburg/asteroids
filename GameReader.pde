import java.util.Arrays;

class GameReader {
  ArrayList<FlyingThing> flyingThings  = new ArrayList<FlyingThing>();
  Ship ship;
  int nextAsteroidWave;
  int score;
  
  void readGame() {
    String[] lines = loadStrings("state-of-the-game.txt");
    for (int i = 0 ; i < lines.length; i++) {
      String[] splitStr = lines[i].trim().split("\\s+");
      String type = splitStr[0];
      String[] data = Arrays.copyOfRange(splitStr, 1,splitStr.length);
      
      switch (type) {
        case "ship":
          Ship ship = new Ship();
          ship.deserialize(data);
          flyingThings.add(ship);
          this.ship = ship;
        break;
        case "asteroid":
          Asteroid asteroid = new Asteroid();
          asteroid.deserialize(data);
          flyingThings.add(asteroid);         
        break;
        case "bullet":
          Bullet bullet = new Bullet();
          bullet.deserialize(data);
          flyingThings.add(bullet);          
        break;
        case "game":
          nextAsteroidWave = Integer.parseInt(data[0]);
          score = Integer.parseInt(data[1]);
        break;
      }
    }
  }
}
