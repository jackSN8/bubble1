float [] verticesx = new float [1000];
float [] verticesy = new float [1000];
void setup()
{
  float t = 0;
  size(1000,800);  
  noiseSeed(30);
  for(int i=0; i<width; i++)
  {    
    verticesx[i] = i;
    verticesy[i] = noise(t)*700;  
    t += 0.05;//amplitude, lower means lower amplitude
  }
    
}


void draw()
{
  background(127);
  noFill();  
  beginShape();
  for (int i=0; i<width/10; i++)
  {
   stroke(2);
   strokeWeight(3);
   vertex(verticesx[i*10],verticesy[i]);
  } 
  endShape();
}
