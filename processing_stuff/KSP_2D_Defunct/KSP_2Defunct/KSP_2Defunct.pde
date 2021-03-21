planet p;
physics s;
moon[] moons;
ArrayList <object> objects;
PFont font;
float [][] moonprop = new float[2][7];
float [][] obprop = new float[2][7];
float [] physprops = new float[0];

int totalmoons = 2;//must set this to exact same as height of moonproperties otherwise you will ARRAY OUT OF BOUNDS
int moonI;



void setup()
{  
  //class creation - planet, physics, moons
  //planet creation
  p = new planet(100,100,0,0,255,width/2,height/2);//planet properties defined here - diameter,mass,r,g,b,x pos,y pos
  //creation of physics(godTM)  
  physprops = new float [] {1}; //physics properties defined here - [0]gravitional constant
  s = new physics(physprops);
  //creation of other objects
  objects = new ArrayList <object>();
  obprop = new float [] [] { {40, 2,   70, 70, 70,  500,  100, 1, 0}, //[0]diameter,[1]mass,[2]rcolor,[3]gcolor,[4]bcolor,[5]xpos,[6]ypos,[7]xspeed,[8]yspeed
                             {20, 0,    0,  0,  0,  500,  250, 1, 0}};                       
  //creation of moons
  moonprop = new float [] [] { {40, 2,   70, 70, 70,  300,  100, 0, 0}, //[0]diameter,[1]mass,[2]rcolor,[3]gcolor,[4]bcolor,[5]xpos,[6]ypos,[7]xspeed,[8]yspeed
                               {30, 1.5, 30, 45, 100, 1000, 900, 0, 0}}; //moon 2
  //end of moon properties, actual creation of moons
  moons = new moon[moonprop.length];
  mooncreation();
  //font for use in text
  font = createFont("Arial",10,true);
  //window paremeters
  size(1940,1080);
  //test code to be removed goes below
  test();
  
}


void draw()
{
  //window paremeters
  background(5);
  //displays every object including their daughters
  objectdisplay();
  
  //main planet functions
  p.display();
  //main moon functions
  for (moon m : moons)
  {
    m.display();
    m.update();
  }
  
  //debug text
  writefps();
}

void mooncreation() //loop that creates each seperate moon
{
 for ( moonI=0; moonI<(totalmoons); moonI++)
    { 
      moons[moonI] = new moon(getcol());                                    
    }  
}


void objectdisplay()//This function displays every single object that is a daughter class of object(the class)
{
  for (int i=objects.size()-1; i>=0; i--)
  {
    object o = objects.get(i);
    o.update();
    o.display();
  }
}


void test()
{
 for ( moonI=0; moonI<(1); moonI++)
   { 
      objects.add(new test(obgetcol()));
   }
}


float [] getcol()
{
 float [] tarray = new float[moonprop[0].length];
 arrayCopy(moonprop[moonI],tarray,moonprop[0].length);
 return(tarray);      
}

float [] obgetcol()
{
 float [] tarray = new float[obprop[0].length];
 arrayCopy(obprop[moonI],tarray,obprop[0].length);
 println(tarray);
 return(tarray);      
}



void writefps()
{
  fill(255);
  textFont(font,20);
  text("fps " + frameRate,width-150,20); 
  
}
