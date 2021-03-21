class creature
{
  PVector position;
  PVector velocity;
  float maxspeed;
  float size;
  creature(PVector tpos,PVector tvel, float tspeed)
  {
    position = tpos.copy();
    velocity = tvel.copy();
    maxspeed = tspeed;
    size=20;
  }
  
  void update()
  {
    velocity.normalize();//
    velocity.mult(maxspeed);//makes sure velocity stays at max speed
    position = position.add(velocity);//moves the position by speed
  }
  
  void display()
  {
    fill(40,200,120);
    ellipse(position.x,position.y,size,size);
    fill(15);
    ellipse(position.x+4,position.y+4,size/10,size/10);
    ellipse(position.x-4,position.y+4,size/10,size/10);
  }
}
