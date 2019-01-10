import java.util.function.Predicate;
Ship ship;
ArrayList<FlyingThing> flyingThings  = new ArrayList<FlyingThing>();
boolean keyLeft, keyRight, keyUp, keyDown;
GameState state = GameState.START;;
int minAsteroids = 1;
int nextAsteroidWave;
int score;

void setup() {
  size(500, 500);
}

void initGame() {
  flyingThings = new ArrayList<FlyingThing>();
  ship = new Ship(new PVector(width/2, height/2),
             new PVector());
  flyingThings.add(ship);
  nextAsteroidWave = 3;
  score = 0;
  genAsteroids(nextAsteroidWave);
  state = GameState.PLAYING;  
}

void draw() {
  background(0);
  noFill();
  stroke(255);
  
  switch (state) {
    case GAMEOVER:
      textAlign(CENTER);
      textSize(40);
      text("GAME OVER!\n(press enter)", width/2, height/2);   
    break;
    case START:
      textAlign(CENTER);
      textSize(60);
      text("ASTEROIDS", width/2, 100); 
      textSize(30);
      text("Press (Enter) to start a new game", width/2, height/2);      
      text("(O) To open saved game", width/2, height/2+80);      
      text("(S) To save game", width/2, height/2+110);   
      text("(ARROWS) for movement", width/2, height/2+140);   
      text("(SPACE) to fire", width/2, height/2+170);  
      text("(P) to pause", width/2, height/2+200);  
    break;
    case PAUSE:
      textAlign(CENTER);
      textSize(60);
      text("ASTEROIDS", width/2, 100); 
      textSize(30);
      text("Press (P) to unpause game", width/2, height/2);            
    break;
    case PLAYING:
      textAlign(LEFT);
      textSize(18);
      text("SCORE: "+score, 5, 20);  
      
      for (FlyingThing thing: flyingThings) {
        if (thing.alive) {
          thing.update();
          thing.render();
        }
      }
      checkKeys();
      checkCollision();
      if (countAsteroids() < minAsteroids) {
        nextAsteroidWave += 1;
        genAsteroids(nextAsteroidWave);
      }        
    break;
    
  }
}

int countAsteroids() {
  int count = 0;
  for (FlyingThing thing: flyingThings) {
    if (thing instanceof Asteroid) count++;
  }
  return count;
}

void checkCollision() {
  for (FlyingThing thing: flyingThings) {
    if (thing.alive) {
      if (thing instanceof Asteroid && ship.checkCollision((Asteroid)thing)) {
        state = GameState.GAMEOVER;
      }
      if (thing instanceof Bullet) {
        for (FlyingThing thing2: flyingThings) {
          if (thing2.alive && thing2 instanceof Asteroid) {
            Bullet b = (Bullet)thing;
            Asteroid a = (Asteroid)thing2;
            
            if (b.pos.dist(a.pos) < (a.size+10)/2) {
              a.alive = false;
              score += Math.round(a.size);
            }
          }
        }
      }      
    }
  }
  flyingThings.removeIf((new Predicate<FlyingThing>() {
   public boolean test(FlyingThing thing) {
      return !thing.alive;
   }
  }));
}

public void genAsteroids(int numAsteroids) {
  for (int i = 0; i < numAsteroids; i++) {
    flyingThings.add(new Asteroid());
  }
}

void checkKeys() {
  if (keyLeft) {
    ship.angle -= radians(2);
  }
  if (keyRight) {
    ship.angle += radians(2);
  }
  if (keyUp) {
    ship.thrustForward(.05);
  }
  if (keyDown) {
    ship.thrustForward(-.05);
  }
}

void keyPressed() {
  if (key == CODED) {
   switch (keyCode) {
    case UP:
      keyUp = true;
      break;
    case DOWN:
      keyDown = true;
      break;
    case LEFT:
      keyLeft = true;
      break;
    case RIGHT:
      keyRight = true;
      break;   
   }   
  } else {
    if (key == ' ') {
      Bullet b = ship.fire();
      flyingThings.add(b);
    } else if ((key == ENTER || key == RETURN) && (state==GameState.GAMEOVER || state==GameState.START)) {
      initGame();
    } else if (key == 'p'  && state!=GameState.GAMEOVER && state==GameState.PAUSE) {
        state = GameState.PLAYING;
    } else if (key == 'p'  && state!=GameState.GAMEOVER && state==GameState.PLAYING) {
        state = GameState.PAUSE;    
    } else if (key == 's') {
      saveGame();
    } else if (key == 'o') {
      loadGame();
    }
  }
}

void keyReleased() {
  switch (keyCode) {
    case UP:
      keyUp = false;
      break;
    case DOWN:
      keyDown = false;
      break;
    case LEFT:
      keyLeft = false;
      break;
    case RIGHT:
      keyRight = false;
      break;
  }
}

void saveGame() {
  System.out.println("saving...");
  GameWriter writer = new GameWriter();
  writer.writeGame(flyingThings, nextAsteroidWave, score);
}

void loadGame() {
  System.out.println("loading...");
  GameReader reader = new GameReader();
  reader.readGame();
  flyingThings = reader.flyingThings;
  ship = reader.ship;
  nextAsteroidWave = reader.nextAsteroidWave;
  score = reader.score;
}
