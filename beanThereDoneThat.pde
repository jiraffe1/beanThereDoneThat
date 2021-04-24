ArrayList<button> buttons;
PImage milkImage;
PImage orangeJuiceImage;
PVector camPos;
String GUIState = "main menu";
level currentLevel;
player player;

void setup() {
  buttons = new ArrayList<button>();
  currentLevel = null;
  fullScreen();
  currentLevel = new level(50, 50);
  player = new player(new PVector(200, 200));
  camPos = new PVector(0, 0);
  initMainMenu();
}

void draw() {
  background(30, 150, 255);
  moveCamera();
  if (GUIState == "main menu") {
    if(getPressed("Play")) {
      initLevelSelect();
    }
    if(getPressed("Exit Game")) {
      exit();
    }
    if(getPressed("Level Editor")) {
      initLevelEditor();  
    }
    
    showTitle();
  } 
  else if (GUIState == "level editor") {
    if(getPressed("back")) {
      initMainMenu();
    }
  } 
  else if(GUIState == "level select") {
    if(getPressed("back")) {
      initMainMenu();
    }
  }
  else if (GUIState == "play") {
    
    if (currentLevel != null)currentLevel.display();
  }
  displayButtons();
  showFrameRate();
  if (currentLevel != null)currentLevel.display();
  if (player != null && currentLevel != null) player.display();
}

void showFrameRate() {
  fill(0);
  stroke(0);
  textSize(18);
  text(round(frameRate), 40, 40);
}

void displayButtons() {
  for (int i = buttons.size() - 1; i >= 0; i--) {
    buttons.get(i).display();
  }
}

void clearButtons() {
  for (int i = buttons.size() - 1; i >= 0; i--) {
    buttons.remove(i);
  }
}

boolean getPressed(String button) {
  for (int i = buttons.size() - 1; i >= 0; i--) {
    button b = buttons.get(i);
    boolean bP = b.isPressed;

    if (bP && b.text == button) {
      return true;
    }
  }

  return false;
}

void moveCamera() {
  if (player != null) {
    PVector playerPos = player.pos;
    camPos = PVector.lerp(camPos, new PVector(playerPos.x-width/2, playerPos.y-height/2), 0.1);
  }
}

void keyPressed() {
  if (player != null) {
    switch(key) {
    case 'd':
      player.right = true;
      break;
    case 'a':
      player.left = true;
      break;
    case 'w':
      player.jump = true;
      break;
    }
  }
}

void keyReleased() {
  if (player != null) {
    switch(key) {

    case 'd':
      player.right = false;
      break;
    case 'a':
      player.left = false;
      break;
    case 'w':
      player.jump = false;
      break;
    }
  }
}  

void showTitle() {
  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(96);
  text("Bean There, Done That", width/2, height*0.3);  
}

void initMainMenu() {
  GUIState = "main menu";
  clearButtons();
  buttons.add(new button(new PVector(width/2, height/2), new PVector(400, 70), "Play"));  
  buttons.add(new button(new PVector(width/2, height/2+120), new PVector(400, 70), "Controls"));
  buttons.add(new button(new PVector(width/2, height/2+240), new PVector(400, 70), "Settings"));  
  buttons.add(new button(new PVector(width/2, height/2+360), new PVector(400, 70), "Level Editor"));  
  buttons.add(new button(new PVector(width/2, height/2+480), new PVector(400, 70), "Exit Game"));  
}

void initLevelEditor() {
  GUIState = "level editor";
  clearButtons();
  buttons.add(new button(new PVector(100, 100), new PVector(100, 50), "back"));
  buttons.add(new button(new PVector(100, 160), new PVector(100, 50), "platform-milk"));
  buttons.add(new button(new PVector(100, 220), new PVector(100, 50), "platform-oj"));
  buttons.add(new button(new PVector(100, 280), new PVector(100, 50), "platform-lava"));
  buttons.add(new button(new PVector(100, 340), new PVector(100, 50), "milk"));
  buttons.add(new button(new PVector(100, 400), new PVector(100, 50), "orange juice"));
}

void initLevelSelect() {
  clearButtons();
  GUIState = "level select";
  buttons.add(new button(new PVector(50, 100), new PVector(100, 50), "back"));
}

void initControls() {
  
}

void loadLevel(File file) {
  if(file != null) {
    String[] nfile = loadStrings(file);
    String fileContents = join(nfile, "");
  
    int w = int(fileContents.substring(0, 3));
    int h = int(fileContents.substring(4, 7));
  
    int[][] loaded = new int[w][h];
    
    for(int i = 0; i < fileContents.length(); i++) {
      int x = i%w;
      int y = round((i%w)/h);
      char c = fileContents.charAt(i+8);
      int cc = int(c);
      
      if(x > 0 && x < w && y > 0 && y < h) {
        loaded[x][y] = cc;
      }
    }
  }
}

void saveLevel(level file) {
  if(file != null) {
    int[][] l = file.level;
    int w = file.w;
    int h = file.h;
    String output = new String();
  }
}

String formatForSave(int n) {
  int d1 = n%1000;
  int d2 = n%100;
  int d3 = n%10;
  int d4 = n%1;
  
  String[] output = {str(d1), str(d2), str(d3) ,str(d4)};
  
  String o = join(output, "");
  
  return o;
}
