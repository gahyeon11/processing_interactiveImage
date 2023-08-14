
class Drop {

  float x, y;

  float speed;

  float r;

  color c;

  Drop() {

    r =8;

    x = random(width);

    y = -r*4;

    speed = random(1, 5);

    c = color(50, 100, 150);
  }

  void move() {

    y += speed;
  }

  void display() {

    fill(c);

    noStroke();

    for (int i =2; i < r; i++) {

      ellipse(x, y, i*2, i*2);
    }
  }
  void killer() {
    fill(0, 0, 0);
    noStroke();

    for (int i =2; i < r; i++) {

      ellipse(x, y, i*3, i*3);
    }
  }


  void caught() {

    speed = 0;

    y = -1000;
  }
}
