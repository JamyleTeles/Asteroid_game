class PowerUpJ {
  float x, y, dX, dY, raio;
  boolean desenha, colidiu;
  int efeito = 0;
  PowerUpJ(float x, float y, int decisao) {
    this.x = x;
    this.y = y;
    this.dX = random(-1, 1);
    this.dY = random(-1, 1);
    this.raio = 10;
    desenha = true;
    colidiu = false;
    this.efeito = decisao;
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
    
    if (desenha) {
      if (this.efeito == 0) {
        stroke(0, 255, 255);
        rect(this.x, this.y, raio*2, raio*2);
      } else if ( this.efeito == 1) {
        stroke(255, 0, 0);
        rect(this.x, this.y, raio*3, raio*3);
      }
      colisao();
    }
  }
  void colisao() {
    for (int i=0; i<disparos.size(); i++) {
      colisaoNavePowerUpJ = dist(this.x, this.y, disparos.get(i).x, disparos.get(i).y);
      println(colisaoNavePowerUpJ);
      if (colisaoNavePowerUpJ <= 30) {
        println("colidiu");
        if (this.efeito == 0) {
          colisaoPower=true;
        } else if ( this.efeito == 1) {
          colisaoPower2=true;
        }
        disparos.remove(i);
        desenha=false;
        colidiu=true;
      }
    }
  }
}
