class Uranus {

  PShape globe, rings;
  PImage texPlanet, texRings;

  float radius, distance, orbitSpeed;
  float angle = 0;
  float selfRotationSpeed = 0.03f;

  PVector position = new PVector();

  Uranus(String planetTex, String ringTex,
         float radius, float distance, float orbitSpeed) {

    this.radius = radius;
    this.distance = distance;
    this.orbitSpeed = orbitSpeed;

    texPlanet = loadImage(planetTex);
    texRings  = loadImage(ringTex);

    globe = createShape(SPHERE, radius);
    globe.setTexture(texPlanet);
    globe.setStroke(false);

    rings = createRings(radius * 1.4f, radius * 2.5f);
  }

  PShape createRings(float innerR, float outerR) {
    int detail = 80;
    PShape r = createShape();
    r.beginShape(TRIANGLE_STRIP);
    r.texture(texRings);
    r.noStroke();

    for (int i = 0; i <= detail; i++) {
      float a = TWO_PI * i / detail;
      float x1 = cos(a) * innerR;
      float z1 = sin(a) * innerR;
      float x2 = cos(a) * outerR;
      float z2 = sin(a) * outerR;
      float u = map(i, 0, detail, 0, 1);

      r.vertex(x1, 0, z1, u, 1);
      r.vertex(x2, 0, z2, u, 0);
    }

    r.endShape();
    return r;
  }

  void update() {
    angle += orbitSpeed;

    position.x = cos(angle) * distance;
    position.z = sin(angle) * distance;
    position.y = 0;
  }

  void display() {
    update();

    pushMatrix();
    translate(position.x, position.y, position.z);

    rotateZ(radians(98));
    rotateY(frameCount * selfRotationSpeed);
    shape(globe);

    pushMatrix();
    rotateX(HALF_PI);
    shape(rings);
    popMatrix();

    popMatrix();
  }
}
