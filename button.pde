class button {
  PVector pos;
  PVector size;
  PVector currSize;
  boolean isPressed;
  String text;
  
  button(PVector pos_, PVector size_, String text_) {
    this.pos = pos_;
    this.size = size_;
    this.currSize = this.size;
    this.text = text_;
  }
  
  boolean pressed() {
    if(this.withinBoundaries() && mousePressed) {
      this.isPressed = true;
      return true;
    }
    this.isPressed = false;
    return false;
  }
  
  boolean withinBoundaries() {
    if(mouseX > this.pos.x-this.size.x/2 && mouseX < this.pos.x+this.size.x/2 && mouseY > this.pos.y-this.size.y/2 && mouseY < this.pos.y + this.size.y/2) {
      this.currSize = new PVector(this.size.x*1.2, this.size.y*1.2);
      return true;
    }
    else {
      this.currSize = this.size;
    }
    return false;
  }
  
  void display() {
        this.withinBoundaries();
    this.isPressed = this.pressed();
    rectMode(CENTER);
    fill(200);
    stroke(50);
    rect(this.pos.x /*- ((this.currSize.x - this.size.x)/2)*/, this.pos.y /*- ((this.currSize.y - this.size.y)/2)*/, this.currSize.x, this.currSize.y);
    fill(0);
    textSize(24);
    textAlign(CENTER);
    text(this.text, this.pos.x, this.pos.y);

  }
}
