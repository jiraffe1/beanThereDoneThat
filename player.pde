class player {
  PVector pos;
  PVector vel;
  boolean right;
  boolean left;
  boolean jump;
  float jumpHeight = -15;
  int state=1;
  
  player(PVector pos_) {
    this.pos = pos_;
    this.vel = new PVector(0, 0);
  }
  
  void physicsEffect() {
    if(this.getSquareLeft() == 1 || this.getSquareRight() == 1 && this.state == 1) {
      this.vel.x *= -0.75;
    }
    
    if(this.getSquare() == 0) {
      this.vel.y+= 0.5;
    }
    else if(this.getSquare() == 1 && this.state == 1) {
      if(this.vel.y > 0) {
        this.vel.y *= -0.25;
      }
    }
    else if(this.getSquare() == 2&& this.state == 2) {
      if(this.vel.y > 0) {
        this.vel.y *= -0.25;
      }
    }
    else if(this.getSquare() == 6) {
      this.vel.y = -30;
    }
    else if(this.getSquare() == 3 && this.state != 3) {
      this.kill();
    }
    else if(this.getSquare() == 4) {
      this.state = 1;
    }
    else if(this.getSquare() == 5) {
      this.state = 2;
    }
    if(this.right) {
      this.vel.x += 0.8;
    }
    if(this.left) {
      this.vel.x -= 0.8;
    }
    if(this.jump && this.onGround()) {
      this.vel.y += this.jumpHeight;
      this.vel.y = max(this.vel.y, this.jumpHeight);
    }
    this.vel.x *= 0.95;
    this.pos.add(this.vel);
  }
  
  int getSquare() {
    if(currentLevel != null) {
      int x = floor(this.pos.x/currentLevel.size);
      int y = floor(this.pos.y/currentLevel.size)+1;
      
      if(x >= 0 && x < currentLevel.w && y >= 0 && y < currentLevel.h)return currentLevel.level[x][y];
    }
    return 0;
  }
  
  int getSquareRight() {
    if(currentLevel != null) {
      int x = floor(this.pos.x/currentLevel.size)+1;
      int y = floor(this.pos.y/currentLevel.size) -1;
      
      if(x >= 0 && x < currentLevel.w && y >= 0 && y < currentLevel.h)return currentLevel.level[x][y];
    }
    return 0;
  }
  
  int getSquareLeft() {
    if(currentLevel != null) {
      int x = floor(this.pos.x/currentLevel.size) - 1;
      int y = floor(this.pos.y/currentLevel.size) - 1;
      
      if(x >= 0 && x < currentLevel.w && y >= 0 && y < currentLevel.h)return currentLevel.level[x][y];
    }
    return 0;
  }  
  
  void display() {
    ellipseMode(CENTER);
    this.physicsEffect();
    fill(255);
    ellipse(this.pos.x - camPos.x, this.pos.y - camPos.y, 50, 50);
    fill(0);
    ellipse((this.pos.x+this.vel.x - 10) - camPos.x, (this.pos.y+this.vel.y - 3) - camPos.y, 8,8);
    ellipse((this.pos.x+this.vel.x + 10) - camPos.x, (this.pos.y+this.vel.y - 3) - camPos.y, 8,8);
    
    line((this.pos.x+this.vel.x - 10) - camPos.x, (this.pos.y+this.vel.y +10 ) - camPos.y, (this.pos.x+this.vel.x) - camPos.x, (this.pos.y+this.vel.y + 15) - camPos.y);
    line((this.pos.x+this.vel.x) - camPos.x, (this.pos.y+this.vel.y +15 ) - camPos.y, (this.pos.x+this.vel.x+10) - camPos.x, (this.pos.y+this.vel.y + 10) - camPos.y);
    stroke(255, 0, 0);
    noFill();
    rect(pos.x - camPos.x, pos.y - camPos.y, currentLevel.size, currentLevel.size);
  }
   
  boolean onGround() {
    if(this.getSquare() == 1 || this.getSquareLeft() == 1 || this.getSquareRight() == 1) {
      return true;
    }
    return false;
  }
  
  void kill() {
    
  }
}
