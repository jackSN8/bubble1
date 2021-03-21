class boundary
{
  Body body;
  float w;
  float h;
  PVector position = new PVector();
  
  boundary(float x, float y)//constructor
  {
    position.x = x;
    position.y = y;
    w=(200);
    h=(15);
    createbody(new Vec2(x,y),w,h);
          
  }
    
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    rectMode(CENTER);
    rect(pos.x, pos.y, w, h);
        
  }

   
  void createbody(Vec2 center, float h, float w)
  {
    //Create shape    
    PolygonShape ps = new PolygonShape();
    float box2dw = box2d.scalarPixelsToWorld(w/2);//sets shape
    float box2dh = box2d.scalarPixelsToWorld(h/2);    
    ps.setAsBox(box2dh,box2dw);
    
    //Create fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;//sets fixture to shape
    
    //phyics paremters
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    //Defining body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    
    //Creating body
    body = box2d.createBody(bd);
  
    //attach shape to body with fixture
    body.createFixture(fd);
      

        
  }
  
  
  
}
