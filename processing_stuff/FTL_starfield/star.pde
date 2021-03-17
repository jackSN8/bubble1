class star
{
  PVector pos;
  float z;
 // color c;
  float pz;
  float speed;
  
  star()
  {
    pos = new PVector(random(-height,height),random(-height,height));
    z = random(0,height);
    pz =z;
    speed=20;
  }
  
  void display()
  {
    fill(255);
    noStroke();
    PVector spos;
    spos = new PVector(map((pos.x/z),0,1,0,width),map((pos.y/z),0,1,0,width));
    float r = map(z,0,width/2,8,0);
    
    ellipse(spos.x,spos.y,r,r); 
    PVector pastpos = new PVector();
    pastpos.x = map((pos.x/pz),0,1,0,width);
    pastpos.y = map((pos.y/pz),0,1,0,width);  
    pz=z;
    stroke(255);
    strokeWeight(0.1);
    PVector streak = PVector.sub(pastpos,spos);
    streak.mult(1.0);
    streak.add(spos);
    line(streak.x,streak.y,spos.x,spos.y);
    
    
  }
  
  
  void update()
  {
    z -=speed;
    if (z < 1)
    {
      z = width/2;
      pos = new PVector(random(-height,height),random(-height,height));
      pz = z;
    }
   
  }
  
  
  
  
  
  
}
