class SpaceStars {

  PVector[] stars; 
  int totalStars = 2500;

  SpaceStars() {
    stars = new PVector[totalStars];

    for (int i = 0; i < totalStars; i++) {
      stars[i] = new PVector(
        random(-4000, 4000),
        random(-4000, 4000),
        random(-4000, 4000)
      );
    }
  }

  void show() {
    pushMatrix();
    stroke(255);
    strokeWeight(2);  // pequeño brillo
    noFill();

    beginShape(POINTS);
    for (PVector s : stars) {
      vertex(s.x, s.y, s.z);
    }
    endShape();

    popMatrix();
  }
}
