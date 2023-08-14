
class Bubble    //바다 속에서 버블 만들어주는 클래스 
{
  float xpos;
  float ypos;
  float r;
  float speed;
  float max_r;
  boolean del = false;
  Bubble(float temp_xpos, float temp_ypos)
  {
    xpos = temp_xpos;
    ypos = temp_ypos;
    max_r = random(200, 400);
    speed = 1f;
  }
  
  void display()
  {
   noFill();
   stroke(255);
   ellipse(xpos, ypos, r,r);
   ellipse(xpos * 0.6, ypos *0.6, r,r);
   ellipse(xpos*0.3, ypos*0.3, r,r);

  }
  
  void move()
  {
    r+=speed;
    if(max_r < r)
    {
      del = true;
      
    }
    
  }
  
  
}
