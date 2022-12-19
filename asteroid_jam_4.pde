float colisaoAsteroidTiro, colisaoNaveAsteroid, colisaoNavePowerUpJ;
Asteroid [] vetorAsteroids = new Asteroid[10];
Asteroid bolinhas;
int raioNave = 20;
PowerUpJ powerJ;
int posX = 200, posY = 200;
ArrayList <Shot> disparos = new ArrayList();
ArrayList <PowerUpJ> tiropower = new ArrayList();
int pontuacao = 0;
int tempo;
int tempo2;
float posLinhaX;
float posLinhaY;
//BOOLEANAS
boolean play;
boolean colisao = false;
Boolean gameover = false;
boolean colisaoPower = false;
boolean colisaoPower2 = false;

void setup() {
  size(600, 600);
  textSize(16);
  noFill();
  for (int i = 0; i < vetorAsteroids.length; i++) {
    int x = int(random(0, 600));
    int y = int(random(600));
    bolinhas = new Asteroid(x, y);
    vetorAsteroids[i] = bolinhas;
  }
}

void draw() {
  background(0);
  fill(255);
  stroke(255);
  text("Pontos: " + pontuacao, 250, 50);
  noFill();
  
  for (int i = 0; i < vetorAsteroids.length; i++) {
    vetorAsteroids[i].atualiza();
  }
  
  //COLISÕES
  for (int i = 0; i < vetorAsteroids.length; i++) {
    colisaoNaveAsteroid = dist( vetorAsteroids[i].x, vetorAsteroids[i].y, posX, posY);
    if (colisaoNaveAsteroid <= 35) {
      gameover = true;
    }
    for (int j = 0; j < disparos.size(); j++) {
      colisaoAsteroidTiro = dist(vetorAsteroids[i].x, vetorAsteroids[i].y, disparos.get(j).x, disparos.get(j).y);
      if (colisaoAsteroidTiro <= 25) {
        colisao=true;
        disparos.remove(j);
        vetorAsteroids[i].x = 700;
        disparos.size();
        pontuacao++;
      }
    }
  }
  //LINHA
  pushMatrix();
  PVector inicio = new PVector(posX, posY);
  PVector mouse = new PVector(mouseX, mouseY);
  mouse.sub(inicio);
  mouse.setMag(40);
  translate(posX, posY);
  stroke(255);
  line(0, 0, + mouse.x, + mouse.y);
  posLinhaX = posX + mouse.x;
  posLinhaY = posY + mouse.y;
  popMatrix();
  for (int i = 0; i < disparos.size(); i++) {
    disparos.get(i).desenha();
  }
  //NAVE
  fill(0);
  stroke(255);
  circle(posX, posY, raioNave);
  noFill();
  //encerrarJogo();
  //POWER UPS
  if (frameCount % 180 == 0 && tiropower.size()<4) {
    criaPowerUp();
    //se não fica desenhando pra sempre
  }
  for (int i = 0; i < tiropower.size(); i++) {
    tiropower.get(i).atualiza();
    if (tiropower.get(i).colidiu) {
      tiropower.remove(i);
      //se o tiro acertar o PowerUp, ele some
    }
  }
  //1ª MEF
  if (colisaoPower == true ) {
    tempo++;
    raioNave=30;
    if (tempo>=180) {
      raioNave=20;
      colisaoPower = false;
      tempo=0;
    }
  }
  //2º MEF
  if (colisaoPower2 == true ) {
    tempo2++;
    if (tempo2==1) {
      for ( int i=0; i< vetorAsteroids.length; i++) {
        vetorAsteroids[i].dX =random(-1, 1);
        vetorAsteroids[i].dY =random(-1, 1);
      }
    }
    for ( int i=0; i< vetorAsteroids.length; i++) {
      vetorAsteroids[i].e= 1;
      //ou seja, durante todo esse tempo a velocidade não muda
    }
    if (tempo2>=180) {
      for (int i=0; i< vetorAsteroids.length; i++) {
        vetorAsteroids[i].e=1.001;
      }
      tempo2=0;
      colisaoPower2 = false;
    }
  }
  println(tempo2, colisaoPower2);
}

void keyPressed() {
  if (posY >= 15) {
    if (keyCode == 'W' || keyCode == 'w') {
      posY-=10;
    }
  }

  if (posY <= 585) {
    if (keyCode == 'S'|| keyCode == 's') {
      posY+=10;
    }
  }

  if (posX >= 15) {
    if (keyCode == 'A' || keyCode == 'a') {
      posX-=10;
    }
  }
  if (posX <= 585) {
    if (keyCode == 'D' || keyCode == 'd') {
      posX+=10;
    }
  }
}

void mousePressed() {
  PVector inicio = new PVector(posX, posY);
  PVector mouse = new PVector(mouseX, mouseY);
  mouse.sub(inicio);
  mouse.setMag(3);
  //o novo comprimento desse vetor
  Shot tiro = new Shot(posLinhaX, posLinhaY, mouse.x, mouse.y);
  disparos.add(tiro);
}

void encerrarJogo() {
  if (gameover) {
    fill(255, 0, 255);
    textSize(36);
    text("GAME OVER", 215, 300);
    noFill();
    noLoop();
  }
} 

void criaPowerUp() {
  int x = int(random(0, 600));
  int y = int(random(600));
  PowerUpJ powerJ = new PowerUpJ(x, y, int(random(0, 2)));
  tiropower.add(0, powerJ);
  //posição do vetor e objeto a ser add no tiropower
}
