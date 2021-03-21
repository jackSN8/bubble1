class leaf
{
  PVector branch = new PVector();
  PVector pos = new PVector();
  float theta;
  float t = random(0,130);
  leaf(PVector branchstart,PVector branchend)
  {
    pos = branchend.copy();
    branch = PVector.sub(branchend,branchstart);
    theta = (branch.heading()-PI/2)+random(-PI/10,PI/10);
  }
  
  void display()
  {
    strokeWeight(0);
    fill(102,175,60,80);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(theta);    
    ellipse(0,0,15,30);
    popMatrix();
  }
  
  void update()
  {
   
  }

}
