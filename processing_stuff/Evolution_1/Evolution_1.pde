environment e;

void setup()
{
  size(1400,1000);    
  e=new environment();
}


void draw()
{
  background(255);
  e.update();
  e.display();
}
