class GameWriter {

  void writeGame(ArrayList<FlyingThing> things, int nextAsteroidWave, int score) {
    ArrayList<FlyingThing> livingThings = new ArrayList<FlyingThing>();
    for (FlyingThing thing: things) {
      if (thing.alive) {
        livingThings.add(thing);
      }
    }
    
    String[] lines = new String[livingThings.size()+1];
    
    int i = 0;
    for (FlyingThing thing: livingThings) {
      lines[i] = thing.getSerialization();
      i++;
    }
    
    lines[i] = "game "+nextAsteroidWave+" "+score;
    
    saveStrings("state-of-the-game.txt", lines);
  }
}
