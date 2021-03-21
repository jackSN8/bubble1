class moon extends object
{
  //vector setup - velocity, position and acceleration already defined

  //moon property variable setup
  float diameter;
  float []colr = new float[3];
  
  
  //fixed variable setup
  
     
  moon(float [] mprops)
  //constructor for moon
  {
    super(mprops);
    //moon properties
    diameter=mprops[0];
    colr[0] = mprops[2];
    colr[1] = mprops[3];
    colr[2] = mprops[4];

  }
    
  
  void display()
  {
    stroke(0);
    strokeWeight(4);
    fill(colr[0],colr[1],colr[2]);
    ellipse(position.x, position.y, diameter, diameter);
    
  }
}
