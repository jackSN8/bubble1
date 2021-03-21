class planet
{
  //vector setup
  PVector position;
  //planet property variable setup
  float mass;
  float diameter;
  float []colr = new float[3];
  
  //fixed variable setup
  
     
  planet(float tdiameter,float tmass,float tr, float tg, float tb, float txpos, float typos)
  //constructor for planet
  {
    //planet properties
    mass=tmass;
    diameter=tdiameter;
    colr[0] = tr;
    colr[1] = tg;
    colr[2] = tb;
    //Vector setups
     position = new PVector (txpos,typos);
  }
  
  
  void display()
  {
    stroke(0);
    strokeWeight(4);
    fill(colr[0],colr[1],colr[2]);
    ellipse(position.x, position.y, diameter, diameter);
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
