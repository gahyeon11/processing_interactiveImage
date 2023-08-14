class Catcher {  //물고기 catcher

  PVector location;    //물고기 움직임을 위한 백터값
  PVector velocity;
  PVector acceleration;
  float topspeed;

  float r;

  float x, y;

  Catcher(float _r) {

    r = _r;   //인식 범위 50

    x = 0;

    y = 0;
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    topspeed = 10;

    IMG = loadImage("1.png");    //IMG 값 불러오기
  }

  void update() {
    PVector mouse = new PVector(mouseX, mouseY);    //마우스를 따라다니도록 업데이트 조정
    PVector acceleration = PVector.sub(mouse, location);

    acceleration.setMag(5);  

    velocity.add(acceleration);     
    velocity.limit(topspeed);
    location.add(velocity);
  }


  void display() {
    image(IMG, location.x, location.y, IMG.width/4, IMG.height/4);
  }

  boolean intersect(Drop d) {

    float distance = dist(location.x, location.y, d.x, d.y);


    if (distance < r + d.r) {

      return true;
    } else {

      return false;
    }
  }
}
