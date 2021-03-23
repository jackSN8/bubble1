  NeuralNet Brain;
//TrainingData[] data = new TrainingData[500];
TrainingData[] data = {new TrainingData(0,0,0),new TrainingData(0,1,1),new TrainingData(1,0,1),new TrainingData(1,1,0)};


float theta;
public void setup() 
{
  size(1000,1000);
  Brain = new NeuralNet(2, 2, 1);
}

public void draw() 
{
  background(51);
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < data.length; j++) {
      int k = PApplet.parseInt(random(data.length));
      Brain.Train(data[k].inputs, data[k].target);
    }
  }

  float res = 10;
  float cols = width/res;
  float rows = height/res;
  for (float x = 0; x < cols; x++) 
  {
    for (float y = 0; y < rows; y++) 
    {
      float x1 = x/cols;
      float y1 = y/rows;
      float[] inputs = {x1, y1};
      float[] c = Brain.FeedForward(inputs);
      noStroke();
      fill(c[0]*255);
      rect(x*res, y*res, res, res);
    }
  }
}

public void mousePressed()
{
  int k= int(random(data.length));
  print("The target is ");
  println(data[k].target);
  println(Brain.FeedForward(data[k].inputs));
}



public int dataGenerator(int x, int y)
{
  if(x*2 > y)
  {
    return 1;
  }
  else
  {
    return 0;
  }
}
 
