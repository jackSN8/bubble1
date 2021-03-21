  class asteroid
{
PVector position;
PVector velocity;
    
       
//float yspeed = 1;  ||tester
PImage assimg;
float assdiameter = 100;

asteroid()
  {
    position = new PVector();
    velocity = new PVector(random(-0.5,0.5),random(3,6));       
  }

void asetup()
  {
    assimg = loadImage ("asteroid.png");
  
    
    position.x = random(width);
    position.y = -50;
  }

void adraw()
  {
    adescend();
    areturn();
    adisplay();
  }


void adescend()
  {
  
    position.add(velocity);  
  }

void areturn()
  {
    if (position.y > 1200)
    {
      position.y = -50;
      velocity.y+=random(-0.2,0.2);
      velocity.y+=random(-0.5,0.5);
      position.x=random(width);
    }
    if ((position.x > (width+50)) || (position.x<-50))
    {
      position.y=-50;
      position.x=random(wszex);
      velocity.y = random(3,6);
      velocity.x = random(-0.5,0.5);
    }
  }

void aexplosion()
  {
     
  }

void adisplay()
  {
  imageMode(CENTER);
  image(assimg,position.x,position.y,assdiameter,assdiameter);
  
  }
}  
