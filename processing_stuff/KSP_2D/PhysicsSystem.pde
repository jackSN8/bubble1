class system
{
ArrayList<object>objects;  //array of everything displayed on screen
float [][] objprop;
int globI; //variable used to store position of object being created. dont touch this  
//physics properties - laws of this universe
float G = 0.8; //gravitional constant
PVector magic;  
  
  system()
  {
    objects = new ArrayList <object>();
    objprop =  new float [] [] {{100,1000,500,000,0000, 150,125,125,155,0.0}, //Planet - has same properties but does not accelerate and is meant to be fixed
                                {100,1000,500,000,0000, 150,125,125,155,0.0}, 
                                {010,0700,500,000,0000, 055,125,000,155,0.1}, //Mass,X cord,Y cord,X speed,Y speed (universal) Diameter,R color,G color,B color,alpha
                                {010,1300,500,000,-001, 035,255,125,000,0.0}
                                                                     };//
    magic = new PVector(0,0);                           
    
    
    objects.add(new planet(getcol()));
    objects.add(new vessel(getcol()));
    for ( globI=2; globI<objprop.length; globI++) //creation of each object loop
      {
        objects.add(new moon(getcol()));
      }
  }
  
  
  
  void display()
  {
    for (int i=objects.size()-1; i>=0; i--)
    {
      object o = objects.get(i);
      o.applyforce(magic);
      o.update();
      o.display();
      applygravity();
    }
  }
  
  void applygravity()
  {
    for (int i=0; i<objects.size(); i++)
      {
        PVector force = new PVector(0,0);
        for (int j=i+1; j<objects.size(); j++)
          {
            object o = objects.get(i);
            object p = objects.get(j);
            force =  PVector.sub(o.position,p.position);//vector between each object
            float distance = force.mag(); //magnitude of that vector
            distance = SOI(distance); //checks if vector is above a certain value, if so sets to infinity
            force.normalize(); 
            float strength = (ps.G*p.mass*o.mass)/(distance*distance);
            force.mult(strength);
            p.applyforce(force);
            //next objects force
            force =  PVector.sub(p.position,o.position);//vector between each object
            distance = force.mag(); //magnitude of that vector
            distance = SOI(distance); //checks if vector is above a certain value, if so sets to infinity
            force.normalize(); 
            strength = (ps.G*p.mass*o.mass)/(distance*distance);
            force.mult(strength);
            o.applyforce(force);  
          }       
      }
  }
  
  
  float SOI(float d) // sets sphere of influence for each object, to be improved upon
  {
    if (d>1000)
      {
        d=10000000;
        return d;        
      }
    else
      {
        return d;
      }
  }
  
  
  float [] getcol()
  {
    float [] tarray = new float[objprop[0].length];
    arrayCopy(objprop[globI],tarray,objprop[0].length);
    return(tarray); 
  }
  
}
