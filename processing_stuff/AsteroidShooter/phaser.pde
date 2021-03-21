class phaser
{
PVector position;
PVector velocity;
  
  



phaser()
{
position = new PVector(r1.position.x,r1.position.y);
velocity = new PVector(0,-15);
  
}


void pdraw()
  {
   fill(255,0,0);
   ellipse(position.x,position.y,50,50);
  }

void pascend()
  {
    position.add(velocity);
  }
  
  
}  
  
  
  
