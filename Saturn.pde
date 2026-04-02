class Saturn {

  PShape globe, rings;
  PImage texPlanet, texRings;

  float radius, distance, orbitSpeed;
  float angle = 0;
  float selfRotationSpeed = 0.04f;

  PVector position = new PVector();

  Saturn(String planetTex, String ringTex,
         float radius, float distance, float orbitSpeed) {

    this.radius = radius;
    this.distance = distance;
    this.orbitSpeed = orbitSpeed;

    texPlanet = loadImage(planetTex);
    texRings  = loadImage(ringTex);

    globe = createShape(SPHERE, radius);
    globe.setTexture(texPlanet);
    globe.setStroke(false);

    rings = createRings(radius * 2.2f, radius * 4.2f);
  }

  PShape createRings(float innerR, float outerR) {
    int detail = 80;
    PShape s = createShape();
    s.beginShape(TRIANGLE_STRIP);
    s.texture(texRings);
    s.noStroke();

    for (int i = 0; i <= detail; i++) {
      float a = TWO_PI * i / detail;
      float x1 = cos(a) * innerR;
      float z1 = sin(a) * innerR;
      float x2 = cos(a) * outerR;
      float z2 = sin(a) * outerR;
      float u = map(i, 0, detail, 0, 1);

      s.vertex(x1, 0, z1, u, 1);
      s.vertex(x2, 0, z2, u, 0);
    }

    s.endShape();
    return s;
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

    pushMatrix();
    rotateY(frameCount * selfRotationSpeed);
    shape(globe);
    popMatrix();

    rotateX(PI / 2.8f);
    shape(rings);

    popMatrix();
  }
}
