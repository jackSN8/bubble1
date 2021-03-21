ArrayList <branch>tree;
ArrayList <leaf> leaves;
int level=0;


void setup()
{
  size(1000,800);
  PVector rootstart = new PVector(width/2,height);
  PVector rootend = new PVector(width/2,height-200);
  tree = new ArrayList <branch>();
  leaves = new ArrayList <leaf>();
  tree.add(new branch(rootstart,rootend));
  createtree();
}
void createtree()
{
  for(level=0; level<5; level++)
  {    
    for (int i = tree.size()-1; i>=0; i--)
    {
      branch b = tree.get(i);
      if (b.grown == false)
      {
        b.splinter();
        
      }
    }
  }
  if (level>4)
  {
    for (branch b : tree)
    {
      if (b.grown == false)
      {
        leaves.add(new leaf(b.start,b.end));
      }
    }
  }
}


void draw()
{
  background(0);  
  for (branch b : tree)
  {
    b.display();
    //b.wind();
  }
  for (leaf l : leaves)
  {
    l.display();
    l.update();
  }
}
