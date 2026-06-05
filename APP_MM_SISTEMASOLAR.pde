import ddf.minim.*;

Minim minim;
AudioPlayer musica;

PVector camPos, camTarget, targetCamPos, targetCamTarget;
Planet selectedPlanetObj = null;

Planet sun, mercurio, venus, earth, mars, jupiter, saturn, uranus, neptune;

int estado = 0;
int planetaClicado = -1;
int nivelQuiz = 0; 
int perguntaAtual = 0;
int pontuacao = 0;
float botaoLargura = 120;
float botaoAltura  = 40;
float x;
float y;
boolean respondeu = false, acertou = false, quizFim = false;

PGraphics ui;

void settings() {
  size(displayWidth, displayHeight, P3D);
  fullScreen();
}

void setup() {
  textAlign(CENTER, CENTER);

  ui = createGraphics(width, height, JAVA2D);
  ui.smooth(8);

  minim = new Minim(this);
  musica = minim.loadFile("musica.mp3");
  musica.loop();

  camPos = new PVector(0, -650, 950);
  camTarget = new PVector(0, 0, 0);
  targetCamPos = camPos.copy();
  targetCamTarget = camTarget.copy();

  sun     = new Planet("sol.obj",      "sun.jpg",             90.0,  0,   0,      0.005, true);
  mercurio = new Planet("mercurio.obj", "2k_mercury.jpg",     18.0,  140, 0.0075,  0.015, false);
  venus    = new Planet("venus.obj",    "2k_venus_surface.jpg", 20.5, 200, 0.0055, 0.010, false);
  earth    = new Planet("Earth.obj",    "earth.jpg",           30.0,  270, 0.00375,  0.020, false);
  mars     = new Planet("mars_2K.obj",  "mars.jpg",            20.8,  340, 0.003,  0.018, false);
  jupiter  = new Planet("jupiter.obj",  "jupiter.jpeg",        58.0,  440, 0.0015,  0.035, false);
  saturn   = new Planet("Saturn.obj",   "Saturn_diff.jpg",     0.19, 530, 0.001125, 0.025, false);
  uranus   = new Planet("uranus.obj",   "Uranus.jpg",          43.3,  610, 0.00075, 0.020, false);
  neptune  = new Planet("neptuno.obj",  "2k_neptune.jpg",      41.01, 690, 0.0006, 0.018, false);
}

void draw() {
  background(10, 10, 30);
  
  ui.beginDraw();
  ui.clear();
  ui.textAlign(CENTER, CENTER);

  if (selectedPlanetObj != null && (estado == 0 || estado == 1)) {
    targetCamTarget = selectedPlanetObj.getAbsolutePosition();
    float offsetZoom = selectedPlanetObj.isSaturn
      ? 600.0
      : selectedPlanetObj.scaleFactor * 25.0;
    targetCamPos = PVector.add(targetCamTarget, new PVector(0, -offsetZoom * 0.6, offsetZoom));
  } else {
    targetCamTarget = new PVector(0, 0, 0);
    targetCamPos = new PVector(0, -650, 950);
  }

  camPos.lerp(targetCamPos, 0.05);
  camTarget.lerp(targetCamTarget, 0.05);
  camera(camPos.x, camPos.y, camPos.z, camTarget.x, camTarget.y, camTarget.z, 0, 1, 0);

  ambientLight(20, 25, 40);
  pointLight(255, 245, 220, 0, 0, 0);
  directionalLight(40, 40, 50, 0.5, 1, -0.5);
  lightSpecular(255, 255, 255);
  specular(140);
  shininess(10.0);

  sun.update();     sun.display();
  mercurio.update(); mercurio.display();
  venus.update();   venus.display();
  earth.update();   earth.display();
  mars.update();    mars.display();
  jupiter.update(); jupiter.display();
  saturn.update();  saturn.display();
  uranus.update();  uranus.display();
  neptune.update(); neptune.display();

  Planet[] listaPlanetas = {mercurio, venus, earth, mars, jupiter, saturn, uranus, neptune};
  for (int i = 0; i < listaPlanetas.length; i++) {
    listaPlanetas[i].calcProjection();
  }

  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();

  if (estado == 0 || estado == 1) {
    String[] nomesPlanetas = {"Mercúrio", "Vênus", "Terra", "Marte", "Júpiter", "Saturno", "Urano", "Netuno"};
    ui.fill(255, 255, 255, 200);
    ui.textSize(height * 0.016);
    for (int i = 0; i < listaPlanetas.length; i++) {
      Planet p = listaPlanetas[i];
      if (p.projZ < 1.0) {
        ui.text(nomesPlanetas[i], p.projX, p.projY + p.projRadius + height * 0.025);
      }
    }
  }

  if (estado == 0) {
    ui.fill(180, 230, 255);
    ui.textSize(height * 0.022);
    ui.text("Clique num planeta para saber mais!", width/2, height * 0.96);
  }

  if (estado == 1) desenhaInfo(ui);
  if (estado == 2) desenhaQuiz(ui);
  if (estado == 3) desenhaCreditos(ui);
  if (estado == 4) desenhaSelecaoNivel(ui);
  
  x = width - botaoLargura - 10;
  y = 20;
  boolean hoverSair = mouseX > x && mouseX < x + botaoLargura &&
                      mouseY > y && mouseY < y + botaoAltura;

  ui.fill(255, 0, 0);

  if (hoverSair) {
    ui.stroke(255);
    ui.strokeWeight(3);
  } else {
    ui.noStroke();
  }

  ui.rect(x, y, botaoLargura, botaoAltura, 12);

  ui.fill(255);
  ui.textSize(height * 0.03);
  ui.text("X",
          x + botaoLargura/2,
          y + botaoAltura/2);

  ui.strokeWeight(1);
  
  ui.endDraw();
  image(ui, 0, 0);

  hint(ENABLE_DEPTH_TEST);
}

void mousePressed() {
  if (mouseX > x && mouseX < x + botaoLargura &&
    mouseY > y && mouseY < y + botaoAltura) {
  exit();
}
  
  if (estado == 0 || estado == 1) {
    Planet[] listaPlanetas = {mercurio, venus, earth, mars, jupiter, saturn, uranus, neptune};
    for (int i = 0; i < listaPlanetas.length; i++) {
      Planet p = listaPlanetas[i];
      float margemClique = max(35, p.projRadius + 15);
      if (dist(mouseX, mouseY, p.projX, p.projY) < margemClique) {
        selectedPlanetObj = p;
        planetaClicado = i;
        estado = 1;
        return;
      }
    }
  }

  if (estado == 1) {
    // Botão Voltar (posição 0.63)
    if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.63 && mouseY < height*0.63 + height*0.07) {
      estado = 0;
      selectedPlanetObj = null;
    }
    // Botão Detalhes (posição 0.73)
    if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.73 && mouseY < height*0.73 + height*0.07) {
      abrirDetalhes();
    }
    // Botão Quiz (posição 0.83)
    if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.83 && mouseY < height*0.83 + height*0.07) {
      perguntaAtual = 0; pontuacao = 0; respondeu = false; acertou = false; quizFim = false;
      estado = 4;
    }
    return;
  }

  if (estado == 2) {
    if (quizFim) {
      if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.62 && mouseY < height*0.62 + height*0.07) {
        perguntaAtual = 0; pontuacao = 0; respondeu = false; acertou = false; quizFim = false; estado = 4;
      }
      if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.72 && mouseY < height*0.72 + height*0.07) {
        estado = 0;
        selectedPlanetObj = null;
        planetaClicado = -1;
      }
      if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.82 && mouseY < height*0.82 + height*0.07) {
        estado = 3;
      }
      return;
    }

    if (!respondeu) {
int correto = 0;

      if (nivelQuiz == 0) {
        if (perguntaAtual == 0) correto = 1;
        if (perguntaAtual == 1) correto = 2;
        if (perguntaAtual == 2) correto = 2;
        if (perguntaAtual == 3) correto = 0;
        if (perguntaAtual == 4) correto = 1;
      }

      if (nivelQuiz == 1) {
        if (perguntaAtual == 0) correto = 3;
        if (perguntaAtual == 1) correto = 2;
        if (perguntaAtual == 2) correto = 3;
        if (perguntaAtual == 3) correto = 2;
        if (perguntaAtual == 4) correto = 1;
      }

      if (nivelQuiz == 2) {
        if (perguntaAtual == 0) correto = 1;
        if (perguntaAtual == 1) correto = 2;
        if (perguntaAtual == 2) correto = 3;
        if (perguntaAtual == 3) correto = 2;
        if (perguntaAtual == 4) correto = 1;
      }
      for (int i = 0; i < 4; i++) {
        float bx = width*0.30;
        float by = height*0.42 + i * height*0.12;
        if (mouseX > bx && mouseX < bx + width*0.40 && mouseY > by && mouseY < by + height*0.09) {
          respondeu = true;
          acertou = (i == correto);
          if (acertou) pontuacao++;
          return;
        }
      }
    }

    if (respondeu) {
      if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.92 && mouseY < height*0.92 + height*0.07) {
        perguntaAtual++;
        respondeu = false;
        if (perguntaAtual >= 5) quizFim = true;
      }
    }
  }

  if (estado == 3) {
    if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.78 && mouseY < height*0.78 + height*0.07) {
      estado = 0;
      selectedPlanetObj = null;
      planetaClicado = -1;
    }
  }
  if (estado == 4) {
    if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.42 && mouseY < height*0.42 + height*0.08) {
      nivelQuiz = 0; perguntaAtual = 0; pontuacao = 0; respondeu = false; acertou = false; quizFim = false;
      estado = 2;
    }
    if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.55 && mouseY < height*0.55 + height*0.08) {
      nivelQuiz = 1; perguntaAtual = 0; pontuacao = 0; respondeu = false; acertou = false; quizFim = false;
      estado = 2;
    }
    if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.68 && mouseY < height*0.68 + height*0.08) {
      nivelQuiz = 2; perguntaAtual = 0; pontuacao = 0; respondeu = false; acertou = false; quizFim = false;
      estado = 2;
    }
    if (mouseX > width*0.35 && mouseX < width*0.65 && mouseY > height*0.82 && mouseY < height*0.82 + height*0.07) {
      estado = 1;
    }
  }
}

class Planet {
  float distance, orbitAngle = 0, orbitSpeed, rotationAngle = 0, rotationSpeed, scaleFactor;
  boolean isSun;
  boolean isSaturn;
  PShape mesh;

  float projX, projY, projZ, projRadius;

  Planet(String objFile, String texFile, float scaleF, float d, float oSpeed, float rSpeed, boolean isSun) {
    this.distance = d;
    this.orbitSpeed = oSpeed;
    this.rotationSpeed = rSpeed;
    this.scaleFactor = scaleF;
    this.isSun = isSun;

    this.isSaturn = objFile.toLowerCase().contains("saturn");

    if (isSaturn) {
      this.mesh = loadShape(objFile);
    } else {
      sphereDetail(35);
      noStroke();
      this.mesh = createShape(SPHERE, 1);
    }

    this.mesh.setTexture(loadImage(texFile));
  }

  void update() {
    orbitAngle += orbitSpeed;
    rotationAngle += rotationSpeed;
  }

  PVector getAbsolutePosition() {
    if (isSun) return new PVector(0, 0, 0);
    return new PVector(distance * cos(orbitAngle), 0, -distance * sin(orbitAngle));
  }

  void calcProjection() {
    PVector absPos = getAbsolutePosition();
    projX = screenX(absPos.x, absPos.y, absPos.z);
    projY = screenY(absPos.x, absPos.y, absPos.z);
    projZ = screenZ(absPos.x, absPos.y, absPos.z);
    float edgeX = screenX(absPos.x + scaleFactor, absPos.y, absPos.z);
    projRadius = abs(edgeX - projX);
  }

  void display() {
    if (distance > 0) {
      noFill();
      stroke(255, 255, 255, 25);
      strokeWeight(1.5);
      pushMatrix();
      rotateX(HALF_PI);
      ellipse(0, 0, distance * 2, distance * 2);
      popMatrix();
    }

    pushMatrix();
    rotateY(orbitAngle);
    translate(distance, 0, 0);
    rotateY(rotationAngle);

    if (isSaturn) {
      rotateX(HALF_PI);
    }

    scale(scaleFactor);

    if (isSun) {
      noLights();
      tint(255, 220, 120);
      shape(mesh);
      noTint();
      ambientLight(20, 25, 40);
      pointLight(255, 245, 220, 0, 0, 0);
      directionalLight(40, 40, 50, 0.5, 1, -0.5);
    } else {
      shape(mesh);
    }

    popMatrix();
  }
}
