class exhaust
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan = random(95,105);
  float diameter = 1;
  color c;
  
  exhaust(PVector tpos)
  {
    position=tpos.copy();
    c = color(255,51,255);    
  }
  
  void display()
  {    
    stroke(0,lifespan);
    strokeWeight(3);
    fill(c,lifespan);
    ellipse(position.x,position.y,16,16);   
  }
  
  void update()
  {
    position.add(velocity);
    velocity.add(acceleration);
    lifespan -=1;
    acceleration.mult(0);
  }
  
  boolean isDead()
  {
    if (lifespan <=0)
      {
        return true;        
      }
    else
      {
        return false;
      }
    
  }
  
  
  void applyforce(PVector force)
  {
    acceleration.add(force);   
    
  }
  
  
  
  
  
  
  
  
  
  
  
}
