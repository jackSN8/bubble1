class planet extends object
{  
  color c;
  float diameter;
  
  
  planet(float [] tprops)
  { 
    super(tprops);    
    diameter = tprops[5];
    c = color(tprops[6],tprops[7],tprops[8]);
  }
  
  void update()
  {
    //planets are on rails so therefore technically they have no acceleration    
  }
  
  
  void display()
  {
    strokeWeight(1);
    stroke(120);
    fill(c);
    ellipse(position.x,position.y,diameter,diameter);
  }
  
}
