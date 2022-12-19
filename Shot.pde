class Shot {
  float x, y, dX, dY;

  Shot(float x, float y, float dX, float dY) {
    this.x = x;
    this.y = y;
    this.dX = dX;
    this.dY = dY;
  }
  
  void desenha(){
    fill(255);
    ellipse(this.x, this.y, 10, 10);
    noFill();
    atualiza();
  }
  void atualiza(){
    this.x += this.dX;
    this.y += this.dY;
  }
}
