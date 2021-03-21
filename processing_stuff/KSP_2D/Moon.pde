class moon extends object
{  
  color c;
  float diameter;
  
  
  
  moon(float [] tprops)
   { 
     super(tprops);    
     diameter = tprops[5];
     c = color(tprops[6],tprops[7],tprops[8]);
   }
  
  void display()
  {
    strokeWeight(1);
    stroke(120);
    fill(c);
    ellipse(position.x,position.y,diameter,diameter);
  }
  
}
