class Info {

  PFont font;

  // -------- IMÁGENES --------
  PImage[] planetImgs = new PImage[9];

  // -------- DATOS --------
  String[] names = {
    "Mercurio", "Venus", "Tierra", "Marte",
    "Júpiter", "Saturno", "Urano",
    "Neptuno", "Plutón"
  };

  String[] age = {
    "4.5 mil millones de años",
    "4.5 mil millones de años",
    "4.54 mil millones de años",
    "4.6 mil millones de años",
    "4.6 mil millones de años",
    "4.5 mil millones de años",
    "4.5 mil millones de años",
    "4.5 mil millones de años",
    "4.5 mil millones de años"
  };

  String[] distance = {
    "57.9 millones km",
    "108.2 millones km",
    "149.6 millones km",
    "227.9 millones km",
    "778.5 millones km",
    "1,434 millones km",
    "2,871 millones km",
    "4,495 millones km",
    "5,906 millones km"
  };

  String[] magnitude = {
    "Pequeño",
    "Mediano",
    "Mediano",
    "Pequeño",
    "Gigante",
    "Gigante",
    "Gigante",
    "Gigante Helado",
    "Enano"
  };

  String[] temperature = {
    "430°C / -180°C",
    "462°C",
    "15°C",
    "-63°C",
    "-108°C",
    "-139°C",
    "-195°C",
    "-201°C",
    "-229°C"
  };

  String[] moons = {
    "0", "0", "1", "2", "79", "83", "27", "14", "5"
  };

  String[] facts = {
    "Mercurio no posee una atmósfera estable y presenta los cambios de temperatura más extremos del sistema solar.",
    "Venus gira en sentido contrario al de la mayoría de los planetas y es el más caliente debido a su densa atmósfera.",
    "La Tierra es el único planeta conocido que alberga vida y tiene agua líquida en su superficie.",
    "Marte alberga el volcán más grande del sistema solar: el Monte Olimpo.",
    "Júpiter es tan grande que podría contener a todos los demás planetas dentro de él.",
    "Saturno posee el sistema de anillos más extenso y visible del sistema solar.",
    "Urano gira inclinado casi 98 grados, causando estaciones extremadamente largas.",
    "Neptuno tiene los vientos más rápidos del sistema solar, alcanzando más de 2,000 km/h.",
    "Plutón es un planeta enano con una atmósfera que se congela cuando se aleja del Sol."
  };

  // -------- LINKS GOOGLE --------
  String[] googleLinks = {
    "https://www.google.com/search?q=Mercurio+planeta+datos+curiosos",
    "https://www.google.com/search?q=Venus+planeta+atm%C3%B3sfera",
    "https://www.google.com/search?q=Tierra+planeta+ciencia",
    "https://www.google.com/search?q=Marte+exploraci%C3%B3n",
    "https://www.google.com/search?q=J%C3%BApiter+gran+mancha+roja",
    "https://www.google.com/search?q=Saturno+anillos",
    "https://www.google.com/search?q=Urano+inclinaci%C3%B3n",
    "https://www.google.com/search?q=Neptuno+vientos",
    "https://www.google.com/search?q=Plut%C3%B3n+planeta+enano"
  };

  // -------- CONSTRUCTOR --------
  Info() {
    font = createFont("Arial", 14);

    planetImgs[0] = loadImage("PlanetsTexture/Mercury/176mercury.jpg");
    planetImgs[1] = loadImage("PlanetsTexture/Venus/985venus.jpg");
    planetImgs[2] = loadImage("PlanetsTexture/Earth/875earth.jpg");
    planetImgs[3] = loadImage("PlanetsTexture/Mars/987mars.jpg");
    planetImgs[4] = loadImage("PlanetsTexture/Jupiter/923jupiter.jpg");
    planetImgs[5] = loadImage("PlanetsTexture/Saturn/176saturn.jpg");
    planetImgs[6] = loadImage("PlanetsTexture/Uranus/388uranus.jpg");
    planetImgs[7] = loadImage("PlanetsTexture/Neptune/785neptune.jpg");
    planetImgs[8] = loadImage("PlanetsTexture/Pluto/878pluto.jpg");
  }

  // -------- DISPLAY --------
  void display(int selected) {
    if (selected == -1) return;

    hint(DISABLE_DEPTH_TEST);
    camera();
    noLights();

    // Panel
    fill(0, 180);
    stroke(255, 150);
    strokeWeight(2);
    rect(width - 320, 40, 300, 580, 14);
    noStroke();

    textFont(font);
    fill(255);
    textAlign(LEFT);

    // Nombre
    textSize(20);
    text(names[selected], width - 300, 80);

    // Imagen
    
    image(planetImgs[selected], width - 300, 100, 160, 160);

    textSize(14);
    text("Edad:", width - 300, 290);
    text(age[selected], width - 300, 308);

    text("Distancia al Sol:", width - 300, 332);
    text(distance[selected], width - 300, 350);

    text("Temperatura:", width - 300, 374);
    text(temperature[selected], width - 300, 392);

    text("Lunas:", width - 160, 374);
    text(moons[selected], width - 160, 392);

    text("Magnitud:", width - 300, 420);
    text(magnitude[selected], width - 300, 438);

    textSize(15);
    text("Dato interesante:", width - 300, 470);

    textSize(13);
    textLeading(18);
    text(facts[selected], width - 300, 490, 260, 80);

    // BOTÓN GOOGLE
    fill(40, 120, 255, 200);
    rect(width - 280, 580, 240, 32, 10);
    fill(255);
    textAlign(CENTER, CENTER);
    text("Explorar más en Google", width - 160, 596);

    hint(ENABLE_DEPTH_TEST);
  }
}
