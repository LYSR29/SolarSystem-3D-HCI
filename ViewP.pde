class ViewP {
  int selected = -1;
  
  // Variables para suavizado y movimiento
  PVector camSmooth = new PVector(0, 0, 0);
  PVector lookSmooth = new PVector(0, 0, 0);
  
  float angle = 0;         
  float tilt = -0.3f;      
  float zoomOffset = 300;  // Distancia extra desde la superficie
  float lerpSpeed = 0.07f; // Suavidad del movimiento

  void update() {
    if (keyPressed) {
      if (key >= '1' && key <= '9') selected = key - '1';
      if (key == '0') selected = -1;

      // Controles de órbita (Flechas)
      if (keyCode == LEFT)  angle -= 0.04f;
      if (keyCode == RIGHT) angle += 0.04f;
      if (keyCode == UP)    tilt -= 0.04f;
      if (keyCode == DOWN)  tilt += 0.04f;
      
      // Controles de Zoom
      if (key == '+') zoomOffset -= 10;
      if (key == '-') zoomOffset += 10;
    }
    
    // Límites de seguridad para la cámara
    tilt = constrain(tilt, -PI/2.2f, PI/2.2f);
    zoomOffset = max(30, zoomOffset); 
  }

  void apply(Mercury me, Venus ve, Earth ea, Mars ma, Jupiter ju, Saturn sa, Uranus ur, Neptune ne, Pluto pl) {
    if (selected == -1) return;

    PVector pos = new PVector();
    float pSize = 50; 

    // Asignación de posición y radio según el planeta seleccionado
    switch(selected) {
      case 0: pos = me.position; pSize = 6;   break; 
      case 1: pos = ve.position; pSize = 12;  break; 
      case 2: pos = ea.position; pSize = 14;  break; 
      case 3: pos = ma.position; pSize = 10;  break; 
      case 4: pos = ju.position; pSize = 60;  break; 
      case 5: pos = sa.position; pSize = 50;  break; 
      case 6: pos = ur.position; pSize = 45;  break; 
      case 7: pos = ne.position; pSize = 43;  break; 
      case 8: pos = pl.position; pSize = 5;   break; 
    }

    // Punto objetivo: Posición del planeta + Centro de la pantalla
    PVector target = PVector.add(pos, new PVector(width/2, height/2, 0));
    
    // Distancia de la cámara al planeta
    float dist = (pSize * 3) + zoomOffset;

    // Cálculo de posición orbital (Coordenadas Esféricas)
    float x = target.x + dist * cos(tilt) * sin(angle);
    float y = target.y + dist * sin(tilt);
    float z = target.z + dist * cos(tilt) * cos(angle);
    
    PVector desiredCam = new PVector(x, y, z);

    // Suavizado (Lerp) para que el movimiento sea fluido
    camSmooth.x = lerp(camSmooth.x, desiredCam.x, lerpSpeed);
    camSmooth.y = lerp(camSmooth.y, desiredCam.y, lerpSpeed);
    camSmooth.z = lerp(camSmooth.z, desiredCam.z, lerpSpeed);
    
    lookSmooth.x = lerp(lookSmooth.x, target.x, lerpSpeed);
    lookSmooth.y = lerp(lookSmooth.y, target.y, lerpSpeed);
    lookSmooth.z = lerp(lookSmooth.z, target.z, lerpSpeed);

    // Aplicación de la cámara de Processing
    camera(
      camSmooth.x, camSmooth.y, camSmooth.z,
      lookSmooth.x, lookSmooth.y, lookSmooth.z,
      0, 1, 0
    );
  }
}
