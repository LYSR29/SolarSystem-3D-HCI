class Controls {
  // Ahora distance es la posición real y targetDistance es a donde queremos ir
  float distance = 2300;   
  float targetDistance = 2300; 
  
  float yaw = 0;           
  float pitch = -0.5f;      

  float zoomSpeed = 40;     // Velocidad del teclado
  float rotateSpeed = 0.03f;
  float easing = 0.05f;     // Suavizado (ajusta entre 0.01 y 0.1)

  void update() {
    // ---- ZOOM POR TECLADO ----
    if (keyPressed) {
      if (key == 'r' || key == 'R') {
        targetDistance -= zoomSpeed; // Modificamos el objetivo
      }
      if (key == 'g' || key == 'G') {
        targetDistance += zoomSpeed; // Modificamos el objetivo
      }
    }

    // Límites del OBJETIVO
    targetDistance = constrain(targetDistance, 600, 5000);

    // ---- EL TRUCO DEL SUAVIZADO ----
    // La distancia real persigue al objetivo suavemente
    distance = lerp(distance, targetDistance, easing);

    // ---- ROTACIÓN ----
    if (keyPressed) {
      if (keyCode == LEFT)  yaw -= rotateSpeed;
      if (keyCode == RIGHT) yaw += rotateSpeed;
      if (keyCode == UP)    pitch += rotateSpeed;
      if (keyCode == DOWN)  pitch -= rotateSpeed;
    }

    pitch = constrain(pitch, -PI/2 + 0.1f, PI/2 - 0.1f);
  }

  void apply() {
    float camX = width/2 + cos(yaw) * cos(pitch) * distance;
    float camY = height/2 + sin(pitch) * distance;
    float camZ = sin(yaw) * cos(pitch) * distance;

    camera(
      camX, camY, camZ,
      width/2, height/2, 0,
      0, 1, 0
    );
  }
}
