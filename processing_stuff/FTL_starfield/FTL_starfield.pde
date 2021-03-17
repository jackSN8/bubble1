
star[] stars = new star[2000];


void setup()
{
  fullScreen();
  for(int i = 0; i<stars.length; i++)
  {
    stars[i] = new star();
  }
}



void draw()
{
  background(5);
  translate(width/2,height/2);
  for(int i = 0; i<stars.length; i++)
  {
    stars[i].update();
    stars[i].display();
  }
}
void mousePressed()
{
  frameRate(1);
}
