class Lights {

  PVector sunPosition;
  int ambientCol;
  int pointCol;

  Lights() {
    sunPosition = new PVector(0, 0, 0); 
    ambientCol = color(40, 40, 40);
    pointCol = color(255, 230, 200); 
  }

  void display() {
    ambientLight(
      red(ambientCol),
      green(ambientCol),
      blue(ambientCol)
    );

    pointLight(
      red(pointCol),
      green(pointCol),
      blue(pointCol),
      sunPosition.x,
      sunPosition.y,
      sunPosition.z
    );
  }
}
