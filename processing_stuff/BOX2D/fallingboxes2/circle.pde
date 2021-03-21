class square
{

  Body body;
  float w;
  float h;
  PVector position = new PVector();
  
  square(float x, float y)//constructor
  {
    position.x = x;
    position.y = y;
    w=random(10,20);
    h=random(10,20);
    createbody(new Vec2(x,y),w,h);
          
  }
    
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(127);
    stroke(0);
    strokeWeight(2);
    rect(0, 0, w, h);
    popMatrix();
    
        
  }
  void killBody() {
    box2d.destroyBody(body);
  }
  
  
  boolean dead()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height +w*h)
    {
      killBody();
      return true;      
    }
   return false;
  }
  
  
  
  
  
  void createbody(Vec2 center, float h, float w)
  {
    //Create shape    
    PolygonShape ps = new PolygonShape();
    float box2dw = box2d.scalarPixelsToWorld(w/2);//sets shape
    float box2dh = box2d.scalarPixelsToWorld(h/2);    
    ps.setAsBox(box2dw,box2dh);
    
    //Create fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;//sets fixture to shape
    
    //phyics paremters
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    //Defining body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    
    //Creating body
    body = box2d.createBody(bd);
  
    //attach shape to body with fixture
    body.createFixture(fd);
      
    //set velocity
    body.setLinearVelocity(new Vec2(random(-5,5),random(2,5)));
    body.setAngularVelocity((random(-5,5)));
        
  }
  
}
