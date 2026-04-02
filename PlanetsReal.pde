 import processing.video.*;
Capture cam;
 PImage prevFrame;
float motionAmount = 0;
float targetDistance = 2000;
float easing = 0.05;
boolean movementDetected = false;
boolean canTrigger = true;
int lastTriggerTime = 0;

// ----------------------------------------------------
//                   PLANETAS
// ----------------------------------------------------
SpaceStars stars;
Sun sun;
Mercury mercury;
Venus venus;
Earth earth;
Moon moon;
Mars mars;
Jupiter jupiter;
Saturn saturn;
Uranus uranus;
Neptune neptune;
Pluto pluto;
Lights sunLight;
Controls controls;
ViewP viewP;
Info info;



Orbit orbitMercury, orbitVenus, orbitEarth, orbitMoon, orbitMars,
      orbitJupiter, orbitSaturn, orbitUranus, orbitNeptune, orbitPluto;




void setup() {
  size(1280, 720, P3D);

  stars = new SpaceStars();

  // --- Iluminación ---
  sunLight = new Lights();

  // --- Controles ---
  controls = new Controls();
  
  // --- Selector de Planetas ---
  viewP = new ViewP();
  info = new Info();
  
  cam = new Capture(this, 640, 480);
  cam.start();


 

  // ---- Sol ----
  sun = new Sun("PlanetsTexture/Sun/8ksun.jpg", 160, 0.002);

  // ---- Planetas ----
  mercury = new Mercury("PlanetsTexture/Mercury/mercurymap.jpg", 6, 300, 0.0040);
  venus   = new Venus("PlanetsTexture/Venus/8kvenus.jpg", 12, 500, 0.0156);
  earth   = new Earth("PlanetsTexture/Earth/earthmapthumb.jpg", 14, 700, 0.0096);
  moon = new Moon("PlanetsTexture/Moon/8kmoon.jpg", 4,  40,  0.04f,  earth);
  mars    = new Mars("PlanetsTexture/Mars/mars_thumbnail.jpg", 10, 900, 0.0051);
  jupiter = new Jupiter("PlanetsTexture/Jupiter/jupitermap.jpg", 60, 1400, 0.0033);
  saturn  = new Saturn("PlanetsTexture/Saturn/saturnmap.jpg",
                       "PlanetsTexture/Saturn/saturnringcolor.jpg",
                       50, 1800, 0.00135);
  uranus  = new Uranus("PlanetsTexture/Uranus/uranusmap.jpg",
                       "PlanetsTexture/Uranus/uranusringcolour.jpg",
                       45, 2200, 0.00048);
 
  neptune = new Neptune(
  "PlanetsTexture/Neptune/neptunemapthumb.jpg",
  43,        // radio
  2400,      // distancia
  0.00035    // velocidad orbital
);
  
  pluto   = new Pluto("PlanetsTexture/Pluto/plutomap1k.jpg", 5, 2600, 0.00024);

  // ---- Órbitas ----
  orbitMercury = new Orbit(300, 180);
  orbitVenus   = new Orbit(500, 180);
  orbitEarth   = new Orbit(700, 180);
  orbitMoon    = new Orbit(40, 120);
  orbitMars    = new Orbit(900, 180);
  orbitJupiter = new Orbit(1400, 180);
  orbitSaturn  = new Orbit(1800, 180);
  orbitUranus  = new Orbit(2200, 180);
  orbitNeptune = new Orbit(2400, 180);
  orbitPluto   = new Orbit(2600, 180);
  
   //targetDistance = controls.distance;
   controls.targetDistance = controls.distance;
}


void draw() {
  background(0);

  // ---- ACTUALIZAR SELECTOR ----
  viewP.update();

  // ---- CÁMARA ----
  if (viewP.selected == -1) {
    controls.update();
    controls.apply();
  } else {
    viewP.apply(
      mercury, venus, earth, mars,
      jupiter, saturn, uranus, neptune, pluto
    );
  }
  
  if (cam.available()) {
    cam.read();
    
    // Si es la primera vez que corre, inicializamos prevFrame
    if (prevFrame == null) {
      prevFrame = createImage(cam.width, cam.height, RGB);
    }
  }

if (prevFrame != null) {
  float totalMotion = 0;
  float sumY = 0; 
  int motionCount = 0;

  cam.loadPixels();
  prevFrame.loadPixels();

  for (int x = 0; x < cam.width; x += 4) { 
    for (int y = 0; y < cam.height; y += 4) {
      int i = x + y * cam.width;
      float diff = abs(brightness(cam.pixels[i]) - brightness(prevFrame.pixels[i]));
      
      // SUBIMOS EL FILTRO: Solo cambios de brillo muy fuertes (manos)
      if (diff > 55) { 
        totalMotion += diff;
        sumY += y;     
        motionCount++;
      }
    }
  }

  // UMBRAL DE MASA: Ignora si el movimiento es pequeño (como la cara o ruido)
  // Necesita ver al menos 250 puntos de movimiento para considerar que es una MANO.
  if (motionCount > 250) { 
    float avgY = sumY / motionCount;
    float intensity = totalMotion / motionCount; 

    if (canTrigger) {
      // --- DETECCIÓN DE ZOOM OUT (ZONA ALTA) ---
      if (avgY < cam.height * 0.40) {
        if (intensity > 65) { 
          controls.targetDistance += 1000; // Gesto brusco: alejar mucho
        } else { 
          controls.targetDistance += 400;  // Gesto suave: alejar poco
        }
        canTrigger = false;
      } 
      
      // --- DETECCIÓN DE ZOOM IN (ZONA BAJA) ---
      else if (avgY > cam.height * 0.60) {
        if (intensity > 65) { 
          controls.targetDistance -= 1000; // Gesto brusco: acercar mucho
        } else { 
          controls.targetDistance -= 400;  // Gesto suave: acercar poco
        }
        canTrigger = false;
      }
    }
  }

  // RESET: Solo permite otro gesto cuando la mano se detiene por completo
  if (motionCount < 40) { 
    canTrigger = true; 
  }

  prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
}


  // ---- LUCES SOL ----
  sunLight.display();

  // ---- UNIVERSO ----
  pushMatrix();
  translate(width/2, height/2, 0);



  // ⭐ estrellas lejanas
  stars.show();

  // 🪐 ÓRBITAS
  orbitMercury.display();
  orbitVenus.display();
  orbitEarth.display();
  orbitMars.display();
  orbitJupiter.display();
  orbitSaturn.display();
  orbitUranus.display();
  orbitNeptune.display();
  orbitPluto.display();

  // ☀️ PLANETAS
  sun.display();
  mercury.display();
  venus.display();
  earth.display();
  moon.display();
  mars.display();
  jupiter.display();
  saturn.display();
  uranus.display();
  neptune.display();
  pluto.display();

  popMatrix();

  // ---- PANEL INFO ----
  info.display(viewP.selected);
  
    image(cam, 20, 20, 200, 150);

}

void mousePressed() {
  if (viewP.selected != -1) {
    if (mouseX > width - 280 && mouseX < width - 40 &&
        mouseY > 580 && mouseY < 612) {
      link(info.googleLinks[viewP.selected]);
    }
  }
} 
