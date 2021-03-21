class gamesystem
{
  asteroid[]asses=new asteroid[5];
  float totalass=asses.length;//disused
 
  
  
  
  
 void gsetup()
   {
     asscreate();
   }
  
 
 void asscreate()
   {
     for (int i=0; i<(asses.length); i++)
     {
       asses[i] = new asteroid();
       asses[i].asetup();
     }
   }
  
  void assdraw()
    {
      for (int i=0; i<(asses.length); i++)
      {       
       asses[i].adraw();
       explosion();
      }
      
      
      
      
    }
  
void explosion()
{
  for (int i=0; i<(r1.phasnum); i++)  
    {
      for (int j=0; j<(asses.length); j++)
        {
        if (dist(r1.phas[i].position.x, r1.phas[i].position.y, asses[j].position.x, asses[j].position.y) <= (asses[j].assdiameter/2))
          print("xd");
        }
    }
}   
  
  
  
  
  
}
