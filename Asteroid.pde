class Asteroid {
  float x, y, dX, dY, raio, e;
  Asteroid(float x, float y) {
    this.x = x;
    this.y = y;
    this.dX = random(-1, 1);
    this.dY = random(-1, 1);
    this.raio = 20;
    this.e=1.001;
  }

  void atualiza() {
    this.x += this.dX;
    this.y += this.dY;
    if (this.x >= 580) {
      this.dX = -abs(this.dX);
    } else if (this.x <= 20) {
      this.dX = abs(this.dX);
    }
    if (this.y >= 580) {
      this.dY = -abs(this.dY);
    } else if (this.y <= 20) {
      this.dY = abs(this.dY);
    }
    this.dX*=e;
    this.dY*=e;
    circle(this.x, this.y, raio*2);
  }
}
