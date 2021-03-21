PFont font;
system ps;




void setup()
{
  size(1940,1080);
  font = createFont("Arial",10,true);
  ps = new system();
}



void draw()
{
  background(15);
  ps.display(); 
  //fps readout
  fill(255);
  textFont(font,20);
  text("fps " + frameRate,width-150,20); 
}
