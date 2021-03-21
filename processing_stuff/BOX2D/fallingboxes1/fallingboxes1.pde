import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
PFont font;
 
 
ArrayList <square> squares;
ArrayList <boundary> bounds;

void setup()
{
  size(1000,800);

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  font = createFont("Arial",10,true);
  squares = new ArrayList<square>();
  bounds = new ArrayList<boundary>();
  boundary b1 = new boundary(300,600);
  boundary b2 = new boundary(650,400);
  bounds.add(b1);
  bounds.add(b2);
}


void draw()
{
  background(0);  
  box2d.step();
  
  if (random(1) < 0.3) {
    square p = new square(width/2,30);
    squares.add(p);
  } 
  
  for (square c : squares)
  {
    c.display();
  }
  for (boundary b : bounds)
  {
    b.display();
  }
  
       
  killboxes();
  writefps();
}


void killboxes()
{
  for (int i = squares.size()-1; i >= 0; i--) 
  {
      square b = squares.get(i);
      if (b.dead()) 
      {
        squares.remove(i);
      }
  }
} 


void writefps()
  {
    fill(255);
    textFont(font,20);
    text("fps " + frameRate,width-150,20); 
  }
