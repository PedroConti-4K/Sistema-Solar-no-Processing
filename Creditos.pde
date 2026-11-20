void desenhaCreditos(PGraphics g) {
  g.fill(0, 0, 20, 220);
  g.stroke(150, 100, 200);
  g.strokeWeight(2);
  g.rect(width*0.05, height*0.05, width*0.90, height*0.90, 16);
  g.strokeWeight(1);

  g.fill(150, 100, 200); g.textSize(height*0.050);
  g.text("Creditos", width/2, height*0.15);

  g.fill(255); g.textSize(height*0.030);
  g.text("Desenvolvido por: Gabriel Bachmann, Gabriel Leonel", width/2, height*0.35);
  g.text("Henrique Batista, Leo Omori, Lucas Ishida", width/2, height*0.43);
  g.text("Pedro Henrique e Renan Nascimento", width/2, height*0.51);

  boolean hoverVoltar = mouseX > width*0.35 && mouseX < width*0.65 &&
                        mouseY > height*0.78 && mouseY < height*0.78 + height*0.07;
  g.fill(50, 100, 200);
  if (hoverVoltar) { g.stroke(255); g.strokeWeight(3); } else { g.noStroke(); }
  g.rect(width*0.35, height*0.78, width*0.30, height*0.07, 12);
  g.fill(255); g.textSize(height*0.030);
  g.text("< Voltar", width/2, height*0.78 + height*0.035);
  g.strokeWeight(1);
}
