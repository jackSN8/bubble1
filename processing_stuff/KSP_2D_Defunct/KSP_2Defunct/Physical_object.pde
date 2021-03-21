class object 
{
  //vector setup
  PVector position;//x y position
  PVector velocity;//velocity
  PVector acceleration;//acceleration, should be changed by forces caused by other objects
  
  //object property variable setup 
  float mass;
  
  object(float [] mprops)
  //constructor for moon
  {
    //moon properties
    mass=mprops[1];
    //Vector setups       
    position = new PVector(0,0);
    position.set(mprops[5],mprops[6]);//sets position x and y to incoming constructor values
    velocity = new PVector (0,0); 
    velocity.set(mprops[7],mprops[8]);//sets velocity x and y to incoming constructor values    
    acceleration = new PVector (0,0); //always should start of at 0, should be no acceleration while there is no force cause newton n shit  
  }
    
  void update()
  { 
    position.add(velocity); //vector added to vector
    velocity.add(acceleration); //
    acceleration.mult(0); // should be no acceleration while there is no force cause newton n shit, so 0 each time to be changed by force which can be constant
  }
  
  void display()
  {
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
