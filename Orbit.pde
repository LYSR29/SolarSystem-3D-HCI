
class Orbit {

  float radius;
  int detail;
  PShape shape;

  Orbit(float radius, int detail) {
    this.radius = radius;
    this.detail = detail;

    shape = createOrbitShape();
  }

  PShape createOrbitShape() {
    PShape s = createShape();
    s.beginShape(POINTS);
    s.stroke(150);
    s.strokeWeight(2);

    for (int i = 0; i < detail; i++) {
      float angle = TWO_PI * i / detail;
      float x = cos(angle) * radius;
      float z = sin(angle) * radius;
      s.vertex(x, 0, z);
    }

    s.endShape();
    return s;
  }

  void display() {
    pushMatrix();
    // ❌ NO MOVERLA AL CENTRO
    // translate(width/2, height/2, 0);
    shape(shape);
    popMatrix();
  }
}
