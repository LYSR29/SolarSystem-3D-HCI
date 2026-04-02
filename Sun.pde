class Sun {

  PShape globe;
  float rotationSpeed;
  float rotation = 0;

  Sun(String texPath, float radius, float rotationSpeed) {
    this.rotationSpeed = rotationSpeed;

    PImage tex = loadImage(texPath);

    globe = createShape(SPHERE, radius);
    globe.setTexture(tex);
    globe.setStroke(false);
  }

     void display() {
      rotation += rotationSpeed;
    
      pushMatrix();
      rotateY(rotation);
    
      // ☀️ El Sol emite luz, no recibe iluminación
      noLights();
      emissive(255, 220, 180);
    
      shape(globe);
    
      // Reactivar luces para el resto del sistema
      lights();
      popMatrix();
    }

}
