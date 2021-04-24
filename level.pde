class level {
  int w;
  int h;
  int[][] level;
  final int groundMilk = 1;
  final int groundOJ = 2;
  final int lava = 3;
  final int milk = 4;
  final int oj = 5;
  float size = 50;

  level(int w_, int h_) {
    this.w = w_;
    this.h = h_;
    this.level = new int[this.w][this.h];
    this.addBoundaries(6);
  }

  void display() {
    rectMode(CENTER);
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        if (this.level[i][j] != 0) {
          int val = this.level[i][j];
          PVector pos = new PVector(i*this.size, j*this.size);

          switch(val) {
            case 1:
              fill(255);
              rect(pos.x - camPos.x, pos.y - camPos.y, this.size, this.size);
              break;
            case 2:
              fill(255, 200, 0);
              rect(pos.x - camPos.x, pos.y - camPos.y, this.size, this.size);
              break;
            case 3:
              fill(255, 0, 0);
              rect(pos.x - camPos.x, pos.y - camPos.y, this.size, this.size);
              break;
            case 4:
              fill(100);
              rect(pos.x, pos.y, this.size, this.size);
              image(milkImage, pos.x - camPos.x, pos.y - camPos.y);
              break;
            case 5:
              fill(100);
              rect(pos.x, pos.y, this.size, this.size);
              image(orangeJuiceImage, pos.x - camPos.x, pos.y - camPos.y);
              break;
            case 6:
              fill(255, 255, 0);
              rect(pos.x, pos.y, this.size, this.size);
          }
        }
      }
    }
  }

  void add(int type, int x, int y) {
    this.level[x][y] = type;
  }
  
  void addBoundaries(int t) {
    for(int i = 0; i < this.w; i++) {
      for(int j = 0; j < this.h; j++) {
        if(i == 0) {
          this.add(t, i, j);
        }
        else if(j == 0) {
          this.add(t, i, j);
        }
        else if(i == w-1) {
          this.add(t, i, j);
        }
        else if(j == h-1) {
          this.add(t, i, j);
        }
      }
    }
  }
}
