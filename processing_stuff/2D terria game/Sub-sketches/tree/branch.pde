class branch
{
  PVector start = new PVector();
  PVector end = new PVector();
  PVector dir;
  float distance;
  float theta = PI/6; 
  boolean grown = false;
  float size;
  branch(PVector s, PVector e)
  {
    start = s.copy();
    end = e.copy();
    dir = PVector.sub(end,start);
    size = map(level,0,5,5,1);
    print(size);
    strokeWeight(size);  
  }
  
  void display()
  {
    print(level);  
    stroke(145,90,42);
    line(start.x,start.y,end.x,end.y);
  }
  
  void splinter()
  {
    dir.rotate(theta);//rotates direction of tree
    PVector newend; 
    newend =PVector.add(end,dir.mult(0.7));   //new branch is 0.7 times the length and off at an angle    
    tree.add(new branch(end,newend)); 
    dir.div(0.7);//resets direction to original length
    dir.rotate(-theta*2);
    newend =PVector.add(end,dir.mult(0.7));
    tree.add(new branch(end,newend)); 
    grown = true;
  }
  
  void wind()
  {
    end.x +=random(-1,1);
    end.y +=random(-1,1);
  }
  
}
