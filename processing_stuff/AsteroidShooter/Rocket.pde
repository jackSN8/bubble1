class rocket
{
PVector position;  
PVector velocity; //unused while mouse control active
    
PImage rocimg;
//boolean shootflag = true; //flag to require user to press mouse every time they shoot\\disused
boolean TrueFlag = true; //flag fixed as true
phaser[]phas=new phaser[10000];
int phasnum=0;
int phasarraynum=0; //number to use in array, 1 less than phasnum due to arrays starting at 0

 
  rocket()
  {
    position = new PVector();
    velocity = new PVector();  //unused while mouse control active      
  }
 
 

  void rsetup()
  {
      rocimg = loadImage("rocket.png");
      
      
      
  }
  void rdraw()
  {
    position.x = mouseX;
    position.y = mouseY;     
    imageMode(CENTER);
    image(rocimg,position.x,position.y,30,74);  
    if (phasnum > 0)
      {
       
       
       for (int i=0; i<(phasnum); i++)
         {
           phas[i].pdraw();
           phas[i].pascend();
         } 
         
      }
  }
    
  void rphashoot()
  {                  
         phas[phasnum] = new phaser();
         phasnum += 1;
         phasarraynum = phasnum-1;        
         
  }
  
  
  
  
  
}  
  
