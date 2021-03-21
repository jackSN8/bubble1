class environment
{
  ArrayList<creature>creatures;//arraylist to store all the creatures;
  float totalcreatures = 20;//variable to store number of creatures, arraylist creatures set to this length
  environment()
  {
    creatures = new ArrayList <creature>();//arraylist to store all the creatures;
    for (int i=0; i<totalcreatures; i++)
    {
      PVector tpos = new PVector(random(width),random(height));
      PVector tvel = new PVector(0,0);
      float tspeed = 5;
      creatures.add(new creature(tpos,tvel,tspeed));
      //creatures.add(creature((PVector.random2D().normalize()).mult(random(0,(sqrt(width*width*height*height))),new PVector(0,0),5     ));
    }
  }
  
  void update()
  {
    for creature in creature;
  }
  
  void display()
  {
  }  
  
}
