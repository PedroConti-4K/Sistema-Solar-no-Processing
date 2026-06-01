import java.awt.Desktop;
import java.net.URI;

// URLs da Wikipedia
String[] planetaURLs = {
  "https://pt.wikipedia.org/wiki/Merc%C3%BArio_(planeta)",  // 0 - Mercúrio
  "https://pt.wikipedia.org/wiki/V%C3%AAnus_(planeta)",     // 1 - Vênus
  "https://pt.wikipedia.org/wiki/Terra",                    // 2 - Terra
  "https://pt.wikipedia.org/wiki/Marte_(planeta)",          // 3 - Marte
  "https://pt.wikipedia.org/wiki/J%C3%BApiter_(planeta)",   // 4 - Júpiter
  "https://pt.wikipedia.org/wiki/Saturno_(planeta)",        // 5 - Saturno
  "https://pt.wikipedia.org/wiki/Urano_(planeta)",          // 6 - Urano
  "https://pt.wikipedia.org/wiki/Netuno_(planeta)"          // 7 - Netuno
};

void abrirDetalhes() {
  if (planetaClicado >= 0 && planetaClicado < planetaURLs.length) {
    try {
      Desktop.getDesktop().browse(new URI(planetaURLs[planetaClicado]));
    } catch (Exception e) {
      println("Erro ao abrir URL: " + e.getMessage());
    }
  }
}

void desenhaInfo(PGraphics g) {
  g.fill(0, 0, 20, 220);
  g.stroke(255, 220, 50);
  g.strokeWeight(2);
  g.rect(width*0.05, height*0.05, width*0.90, height*0.90, 16);
  g.strokeWeight(1);

  if (planetaClicado == 0) {
    g.fill(180, 170, 150);  g.textSize(height*0.050);  g.text("Mercurio",    width/2, height*0.15);
    g.fill(255);            g.textSize(height*0.030);  g.text("Temperatura:  430 C (dia)  /  -180 C (noite)", width/2, height*0.30);
                                                        g.text("Luas: 0",      width/2, height*0.38);
    g.fill(200, 240, 255);  g.textSize(height*0.028);  g.text("Mercurio e o planeta mais proximo do Sol e tambem o menor.\nSeu solo e cheio de crateras, parecido com a Lua.", width/2, height*0.52);
  }
  if (planetaClicado == 1) {
    g.fill(220, 190, 100);  g.textSize(height*0.050);  g.text("Venus",        width/2, height*0.15);
    g.fill(255);            g.textSize(height*0.030);  g.text("Temperatura:  465 C", width/2, height*0.30);
                                                        g.text("Luas: 0",      width/2, height*0.38);
    g.fill(200, 240, 255);  g.textSize(height*0.028);  g.text("Venus e o planeta mais quente do Sistema Solar.\nSua atmosfera e muito densa e cheia de gases toxicos.", width/2, height*0.52);
  }
  if (planetaClicado == 2) {
    g.fill(70, 130, 220);   g.textSize(height*0.050);  g.text("Terra",        width/2, height*0.15);
    g.fill(255);            g.textSize(height*0.030);  g.text("Temperatura:  15 C", width/2, height*0.30);
                                                        g.text("Luas: 1",      width/2, height*0.38);
    g.fill(200, 240, 255);  g.textSize(height*0.028);  g.text("A Terra e o unico planeta conhecido com vida.\nGrande parte da sua superficie e coberta por agua.", width/2, height*0.52);
  }
  if (planetaClicado == 3) {
    g.fill(210, 90, 60);    g.textSize(height*0.050);  g.text("Marte",        width/2, height*0.15);
    g.fill(255);            g.textSize(height*0.030);  g.text("Temperatura:  -63 C", width/2, height*0.30);
                                                        g.text("Luas: 2",      width/2, height*0.38);
    g.fill(200, 240, 255);  g.textSize(height*0.028);  g.text("Marte e conhecido como o Planeta Vermelho.\nCientistas estudam sinais de vida antiga nele.", width/2, height*0.52);
  }
  if (planetaClicado == 4) {
    g.fill(210, 170, 110);  g.textSize(height*0.050);  g.text("Jupiter",      width/2, height*0.15);
    g.fill(255);            g.textSize(height*0.030);  g.text("Temperatura:  -110 C", width/2, height*0.30);
                                                        g.text("Luas: 95",     width/2, height*0.38);
    g.fill(200, 240, 255);  g.textSize(height*0.028);  g.text("Jupiter e o maior planeta do Sistema Solar.\nEle possui uma enorme tempestade chamada Grande Mancha Vermelha.", width/2, height*0.52);
  }
  if (planetaClicado == 5) {
    g.fill(230, 210, 150);  g.textSize(height*0.050);  g.text("Saturno",      width/2, height*0.15);
    g.fill(255);            g.textSize(height*0.030);  g.text("Temperatura:  -140 C", width/2, height*0.30);
                                                        g.text("Luas: 146",    width/2, height*0.38);
    g.fill(200, 240, 255);  g.textSize(height*0.028);  g.text("Saturno e famoso pelos seus aneis brilhantes.\nEsses aneis sao formados por gelo, poeira e rochas.", width/2, height*0.52);
  }
  if (planetaClicado == 6) {
    g.fill(150, 220, 220);  g.textSize(height*0.050);  g.text("Urano",        width/2, height*0.15);
    g.fill(255);            g.textSize(height*0.030);  g.text("Temperatura:  -195 C", width/2, height*0.30);
                                                        g.text("Luas: 27",     width/2, height*0.38);
    g.fill(200, 240, 255);  g.textSize(height*0.028);  g.text("Urano gira de lado em relacao aos outros planetas.\nSua cor azulada acontece por causa do gas metano.", width/2, height*0.52);
  }
  if (planetaClicado == 7) {
    g.fill(60, 90, 220);    g.textSize(height*0.050);  g.text("Netuno",       width/2, height*0.15);
    g.fill(255);            g.textSize(height*0.030);  g.text("Temperatura:  -200 C", width/2, height*0.30);
                                                        g.text("Luas: 16",     width/2, height*0.38);
    g.fill(200, 240, 255);  g.textSize(height*0.028);  g.text("Netuno e o planeta mais distante do Sol.\nEle possui alguns dos ventos mais fortes do Sistema Solar.", width/2, height*0.52);
  }

  // --- Botão Voltar (movido para cima: 0.63) ---
  boolean hoverVoltar = mouseX > width*0.35 && mouseX < width*0.65 &&
                        mouseY > height*0.63 && mouseY < height*0.63 + height*0.07;
  g.fill(50, 100, 200);
  if (hoverVoltar) { g.stroke(255); g.strokeWeight(3); } else { g.noStroke(); }
  g.rect(width*0.35, height*0.63, width*0.30, height*0.07, 12);
  g.fill(255); g.textSize(height*0.030);
  g.text("< Voltar", width/2, height*0.63 + height*0.035);

  // --- Botão Detalhes (novo, posição 0.73) ---
  boolean hoverDetalhes = mouseX > width*0.35 && mouseX < width*0.65 &&
                          mouseY > height*0.73 && mouseY < height*0.73 + height*0.07;
  g.fill(160, 60, 200);
  if (hoverDetalhes) { g.stroke(255); g.strokeWeight(3); } else { g.noStroke(); }
  g.rect(width*0.35, height*0.73, width*0.30, height*0.07, 12);
  g.fill(255); g.textSize(height*0.030);
  g.text("Detalhes (Wikipedia)", width/2, height*0.73 + height*0.035);

  // --- Botão Quiz (posição 0.83) ---
  boolean hoverQuiz = mouseX > width*0.35 && mouseX < width*0.65 &&
                      mouseY > height*0.83 && mouseY < height*0.83 + height*0.07;
  g.fill(40, 150, 70);
  if (hoverQuiz) { g.stroke(255); g.strokeWeight(3); } else { g.noStroke(); }
  g.rect(width*0.35, height*0.83, width*0.30, height*0.07, 12);
  g.fill(255); g.textSize(height*0.030);
  g.text("Jogar Quiz!", width/2, height*0.83 + height*0.035);
  g.strokeWeight(1);
}
