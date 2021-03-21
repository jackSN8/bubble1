class object
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector force;
  float mass;
  
  
  object(float [] tprops)
  {
    mass = tprops[0];
    position = new PVector(tprops[1],tprops[2]);
    velocity = new PVector(tprops[3],tprops[4]);
    acceleration = new PVector(0,0);
    force = new PVector(0,0);
  }
  
  void update()
  {
    position.add(velocity);
    velocity.add(acceleration);        
    acceleration.set(0,0); //very important, keep at end of update function. no acceleration with no force
  }
  
  void applyforce(PVector f)
  {
   force.add(f.copy());
   force.div(mass);   
   acceleration.add(force);
  }
  
  
  void display()
  {
  }
  

  
 
  
  
  
}
