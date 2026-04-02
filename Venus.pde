
class Venus {

  PShape globe;
  PImage tex;

  float radius, distance, orbitSpeed;
  float angle = 0;
  float rotationSpeed = 0.003f; // Rotación retrógrada


  PVector position = new PVector();

  Venus(String path, float radius, float distance, float orbitSpeed) {
    this.radius = radius;
    this.distance = distance;
    this.orbitSpeed = orbitSpeed;

    tex = loadImage(path);
    globe = createShape(SPHERE, radius);
    globe.setTexture(tex);
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
    
    rotateY(angle * rotationSpeed);
    shape(globe);
    popMatrix();
  }
}
