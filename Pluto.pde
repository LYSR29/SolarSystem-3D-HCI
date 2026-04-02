class Pluto {

  PShape globe;
  PImage texPlanet;

  float radius, distance, orbitSpeed;
  float angle = 0;
  float selfRotationSpeed = 0.015f;

  PVector position = new PVector();

  Pluto(String path, float radius, float distance, float orbitSpeed) {
    this.radius = radius;
    this.distance = distance;
    this.orbitSpeed = orbitSpeed;

    texPlanet = loadImage(path);
    globe = createShape(SPHERE, radius);
    globe.setTexture(texPlanet);
    globe.setStroke(false);
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

    rotateZ(radians(17));
    rotateY(frameCount * selfRotationSpeed);

    shape(globe);

    popMatrix();
  }
}
