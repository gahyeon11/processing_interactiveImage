import processing.video.*;


//SoundFile sound;

Capture video;

Timer timer;

Drop[] drops;

Catcher catcher;


PImage backgroundImage;
PImage p;
PImage IMG;
PImage water;
float threshold =20;     //컬러 허용 한계값 
int totalDrops = 0;    //빗방울의 총 개수 컨츠롤
boolean game_start = true;   //game control 할 불리안 값
ArrayList<Bubble> bubbles = new ArrayList<Bubble>();

void setup() {

  size(1280, 960);

  video = new Capture(this, width/2, height/2);

  video.start();

  backgroundImage = createImage(video.width, video.height, RGB);  //클릭시 전체 배경이 저장 될 백그라운드
  IMG = createImage(video.width, video.height, ARGB);    //배경이 제거되고 이미지가 저장 될 IMG
  water = loadImage("water3.png");
  
  catcher = new Catcher(50);

  drops = new Drop[90];

  timer = new Timer(300);
  
 // sound = new SoundFile(this, "sound.mp3");

  timer.start();
  
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {

  loadPixels();

  video.loadPixels();

  backgroundImage.loadPixels();

 // IMG.loadPixels();
  for (int x =0; x <video.width; x++) {    // 모든 픽셀에 접근 할 반복문

    for (int y = 0; y <video.height; y++) {

      int loc = x + y*video.width;     

      color fgColor = video.pixels[loc];   //현재 픽셀값

      color bgColor =backgroundImage.pixels[loc];    //배경 이미지의 픽셀값

      float r1 = red (fgColor);

      float g1 = green(fgColor);

      float b1 = blue(fgColor);

      float r2 = red(bgColor);

      float g2 = green(bgColor);

      float b2 = blue(bgColor);

      float diff = dist(r1, g1, b1, r2, g2, b2);   //현재 색과 움직임 색상의 비교를 위헤 dist() 사용

      if (diff > threshold) {   //현재 색상이 가장 가까운 색상보다 추적된 색상과 더 유사한 경우 현재 색상  저장

        pixels[loc] = fgColor;
        IMG.pixels[loc] = fgColor;
      } else {

        pixels[loc] = color(255, 0);
        IMG.pixels[loc] = color(255, 0);
      }
    }
  }

  updatePixels();
  if (key == '1' ) {  //1이 누르면 이미지 저장
    IMG.save("1.png");
  }
  if (key == 'l' || key == 'L') {   //L 누르면 배경 변경 게임 시작

    p = loadImage("ocean2.png");
    background(p);
    
 //   sound.play();
    
    push();
    tint(255, 126);
    image(water, 0, 0, width, height);    //배경에 파도 느낌 주기
    pop();
    
    for (int i = 0; i< bubbles.size(); i++)    //동그라미 효과 
    {
      Bubble myBubble = bubbles.get(i);
      myBubble.display();
      myBubble.move();
      if (myBubble.del == true)
      {
        bubbles.remove(i);
      }
    }
    if (mousePressed == true) {
      bubbles.add(new Bubble(mouseX, mouseY));    //바다 속에서 마우스 클릭시 버블 생성
    }
 
    catcher.update();    //catcher 클래스 호출 //물고기 그림 호출
    catcher.display();


    if (timer.isFinished()) {

      drops[totalDrops] = new Drop();    //떨어지는 먹이 객체 생성

      totalDrops++;    //생성 될 때 마다 토탈 값 늘리기

      if (totalDrops >= drops.length) {

        totalDrops = 0;    //길이보다 늘어나면 초기화
      }

      timer.start();
    }

    for (int i =0; i < totalDrops; i++) {

      drops[i].move();    //떨어지는 drop 클래스 호출

      drops[i].display();
      if ( i % 10 == 0) {    //drop 10개당 1개 비율로 킬러 생성해줌

        drops[i].killer();
      }


      if (catcher.intersect(drops[i])) {    //catcher가 인수로 drop을 받게 함으로써 객체끼리 접촉을 알 수 있게 해줌

        drops[i].caught();
        if ( i % 10 == 0) {    //killer와 닿으면 false , 반복문 나감
          game_start = false;
          break;
        }
      }
    }
  }
  if (game_start == false) {    //gameover
    background(0);
    fill(255, 255, 255);
    text("Game Over", width/2, height/2);
  }
}


void mousePressed() {    //캠에서 마우스가 입력 되면 배경 이미지가 복사되어 비디오와 비교할 수 있게 해준다.

  backgroundImage.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);

  backgroundImage.updatePixels();
}


class Timer {  //timer class

  int savedTime;

  int totalTime;

  Timer(int _totalTime) {

    totalTime = _totalTime;
  }

  void start() {

    savedTime = millis();  //millis로 시간을 1/1000초로 표시 //savedTime에 실행 시간 기록 
    
  }

  boolean isFinished() {

    int passedTime = millis() - savedTime;   //현재 시간에서 savedtime을 뺀 값을 passedtime으로 정의

    if (passedTime > totalTime) {   //총 입력된 시간보다 지나간 시간이 크다면 true

      return true;
    } else {

      return false;
    }
  }
}
