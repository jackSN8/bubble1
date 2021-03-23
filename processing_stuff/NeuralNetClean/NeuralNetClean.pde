NeuralNet Brain;


float theta;
public void setup() 
{
  size(1000,1000);
  Brain = new NeuralNet(784, 20, 10);
}

public void draw() 
{
  background(51);
  Brain.Train();//Inputs,Targets
}






 
