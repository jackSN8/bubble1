//PImage rocimg;
rocket r1; //initilisation of classes, wszex and wszey are height and width

gamesystem g1;
int wszex;
int wszey;
PFont f;


void setup()
{
  wszex = 800; //width is obselete
  wszey = 1000; //height is obselete
  size(800,1000);
  r1 = new rocket();
  r1.rsetup();
  g1 = new gamesystem();
  g1.gsetup();
  f = createFont("Arial",40,true);
}

void draw()
{
  background(5);  
  r1.rdraw();
  g1.assdraw();
  if (r1.phasnum > 0);
    {
      //explosion();
    }
  textFont(f,10);
  text("fps " + frameRate,40,40);
}
 
void mouseClicked()
{
   r1.rphashoot();
}


//void explosion() Function moved to gamesystem
//{
//  for (int i=0; i<(r1.phasnum); i++)
//    {
//      if (dist(r1.phas[i].x, r1.phas[i].y, a1.x, a1.y) <= (a1.assdiameter/2))  
//        print("xd");
//    }
//}  
  
