class Moon {

  PShape globe;
  PImage tex;

  float radius;
  float distance;      // distancia a la Tierra
  float angle = 0;

  // ---- TIEMPO REAL ----
  float orbitalPeriodDays = 27.32;
  float timeScale;                // días simulados por segundo

  Earth earth;
  PVector position = new PVector();

  Moon(String texturePath, float radius, float distance, float timeScale, Earth earth) {
    this.radius = radius;
    this.distance = distance;
    this.timeScale = timeScale;
    this.earth = earth;

    tex = loadImage(texturePath);
    globe = createShape(SPHERE, radius);
    globe.setTexture(tex);
    globe.setStroke(false);
  }

  void update() {
    // ⏱️ Conversión tiempo real → ángulo
    float daysPerFrame = timeScale / frameRate;
    float angularSpeed = TWO_PI / orbitalPeriodDays;

    angle += angularSpeed * daysPerFrame;

    position.x = cos(angle) * distance;
    position.z = sin(angle) * distance;
    position.y = 0;
  }

  void display() {
    update();

    pushMatrix();

    // 🌍 Posición de la Tierra
    translate(earth.position.x, earth.position.y, earth.position.z);

    // 🌕 Movimiento lunar
    translate(position.x, position.y, position.z);

    shape(globe);
    popMatrix();
  }
}
