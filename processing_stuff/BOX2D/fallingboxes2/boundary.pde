class boundary
{
  Body body;
  float w;
  float h;
  PVector position = new PVector();
  ArrayList<Vec2> surface;
  float seed = 0;
  boundary()//constructor
  {

    createbody();
          
  }
    
  void display()
  {
    stroke(255);
    strokeWeight(1); 
    fill(60,60,120);   
    beginShape();
    vertex(0,height);
    for (Vec2 v: surface) 
    {
      vertex(v.x,v.y);
    }
    vertex(width,height);
    endShape();
  }

   
  void createbody()
  {
    //chain shape dimensions
    surface = new ArrayList<Vec2>();    
    float t = seed;
    int j;
    surface.add(new Vec2(0,500));
    for(j=0; j<5; j++);
    {
      //surface.add(new Vec2(t*width/10, noise(t)));
      surface.add(new Vec2(j*width/5,random(500)));
    }    
    surface.add(new Vec2(width,500)); 
        
    //Create shape    
    ChainShape chain = new ChainShape();
    Vec2[] vertices = new Vec2[surface.size()];
    for (int i=0; i<vertices.length; i++)
      {
        vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
        
      }
    chain.createChain(vertices, vertices.length);
        
    
    //Defining body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    
    //Creating body
    body = box2d.createBody(bd);
  
    //attach shape to body with fixture
    body.createFixture(chain,1);
      

        
  }
  
  
  
}
