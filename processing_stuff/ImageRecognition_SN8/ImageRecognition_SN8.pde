NeuralNet Brain;
String []InpWeightIH;
String []InpWeightHO;
String []InpBiasH;
String []InpBiasO;

String [] input;//String to hold incoming txt file for MNST
int [][]mainImageStorage;//2D String to hold MNST data
int [][] headerStorage;//1D string to store header data, althought this isnt 1d, so idk why i said 1d (1st part of this comment was made well before the second)
PImage img;//PImage object to display the current image being trained on
float totalCorrect =0;
FloatList trainingHistory = new FloatList(); 
float t=0;
PVector [] points = new PVector[500];//PVector array to store points on the error graph

float textLine = 0;//Variable to store how many lines down in the txt file you are



float theta;
public void setup() 
{
  InpWeightIH = loadStrings("SavedWeightsIH.txt");
  InpWeightHO = loadStrings("SavedWeightsHO.txt");
  InpBiasH = loadStrings("SavedBiasH.txt");
  InpBiasO = loadStrings("SavedBiasO.txt");
  Matrix TweightsIH = LoadIntoMatrix(InpWeightIH,20,784);
  Matrix TweightsHO = LoadIntoMatrix(InpWeightHO,10,20);
  Matrix TbiasH = LoadIntoMatrix(InpBiasH,20,1);
  Matrix TbiasO = LoadIntoMatrix(InpBiasO,10,1);
  
  size(1000,1000);
  Brain = new NeuralNet(784, 20, 10,TweightsIH,TweightsHO,TbiasH,TbiasO);  
  //Below deals with actual incoming data
  input = loadStrings("MnistTestSet1.txt");//Loads the txt file
  
  String [] newInp = new String[785*3];//Cuts off any data past that value. Value must divide by 785, and is to be removed.
  arrayCopy(input,0,newInp,0,785*3);
  
  mainImageStorage = splitMnst(strToInt(newInp)); //Converts input to intiger, and splits into 2d array
  headerStorage = getHeaders(mainImageStorage);//Splits the labels of the MNST files off into a 2d array ready for MNST 
  mainImageStorage = downSizeMnst(mainImageStorage);//Downsizes the main info into a 784 * n images array
  
  //function to fill points array first to avoid array being empty at beginning of program
  for(int i=0; i<points.length; i++)
  {
    points[i] = new PVector(0,0);
  }
}

public void draw() 
{
  frameRate(0.5);
  background(51);
  //Brain.Train();//Inputs,Targets
  //Then actually run the NN on the data. YAY!
  ////Directly copied from the train algorithim so might have wierd comments
  background(0);
  int currentImage = int(t%3.0);
  displayIMG(mainImageStorage[currentImage]);//Display the file being trained on
  float [] input = float(mainImageStorage[currentImage]);//Converts incoming data to float as NN can only accept floats
  for(int i=0; i<input.length; i++)//Linearly maps incoming data to between 0 and 1
  {
    input[i] = map(input[i],0,255,-1,1);
  }
  
  float [] guesses = Brain.FeedForward(input);  //Runs the data through the NN once and records outputs  
  float [] header = float(headerStorage[currentImage]);
  //Brain.Train(input,header); //No training for the this
  
  
  //Display debug data
  float guess = findMax(guesses);  //Finds the maximum value as the value that the NN is most confident is the answer
  float answer = findMax(float(headerStorage[currentImage])); //Gets the actual answer as a float value
  t ++;
  if(guess == answer)
  {
    totalCorrect++;
    trainingHistory.append(1);
  }
  else
  {
    trainingHistory.append(0);
  }  
  text("Guess was",width-300,50);
  text(guess,width-150,50);
  text("Actual result was", width-300,100);
  text(answer,width-150,100);
  text("Total correct rate is", width - 300,150);
  text(totalCorrect/t, width - 150,150);
  //Maths to find the recent amount correct
  float recentTotalCorrect = 0;
  if(t > 100)
  {    
    for(int i=0; i<100; i++)
    {
      if(trainingHistory.get(int(t-100+i)) == 1)
      {
        recentTotalCorrect ++;
      }
    } 
  }
  text("Recent correct rate is", width - 300,200);
  text(recentTotalCorrect/100, width - 150,200);
  //Now graph the error rate
  //0-100 xy box top left?
  int xpos = int(t%500);
  int ypos = int(recentTotalCorrect);
  points[xpos] =  new PVector(xpos,ypos);
  for(int i=0; i<points.length; i++)
  {
    stroke(255);
    point(points[i].x,points[i].y);
  }  
  stroke(0,255,0);
  line(0,100,500,100);
  line(500,0,500,100);
  stroke(255);
  //println(guess);
  //println(answer);
  //println("next one");
}

public Matrix LoadIntoMatrix(String []input,int rows, int cols)
{
  float []tempFloatData = float(input);
  Matrix output = new Matrix(rows, cols);
  float [][]MatrixFloat = convertTwoD(tempFloatData,rows,cols);
  output.values = MatrixFloat;
  printMatrix(output,"debug2.txt");
  return output;//???????????????   
}

public float [][] convertTwoD(float [] input,int rows, int cols)
{
  float [][]output = new float[rows][cols];
  int k=0;//Variable that stores iterates by cols every time you incriment through each column on the 2d output matrix
  for(int i=0; i<rows; i++)
  {
    arrayCopy(input,k,output[i],0,cols);
    k+=cols;
  }
  return output;
}

public void printMatrix(Matrix input, String name)
{
  PrintWriter output;
  output = createWriter(name);
  for(int i=0; i<input.rows; i++)
  {
    for(int j=0; j<input.cols; j++)
    {
      output.println(input.values[i][j]);
    }
  } 
  output.flush();
  output.close();
}

///Function to split the incoming 1d array of 785*n images, into an array of x = n/785, y = 785 (each image occupies one further space in x
public int [][]splitMnst(int [] input)
{
  int [][] output = new int[input.length/785][785];
  for(int i=0; i<input.length; i+=785)
  {
    arrayCopy(input,i,output[i/785],0,785);
  }
  return output;  
}

//Function to copy headers of the MNST data into 2d array ready for ML
public int [][] getHeaders(int [][]input)
{
  int[][] output = new int[input.length][10];
  for(int i=0; i<input.length; i++)
  {
    output[i][input[i][0]] = 1;
  }
  return output;
}

//Function to downsize main image storage to 784 from 785 so it divides into 28 
public int [][] downSizeMnst(int [][]input)
{
  int [][] output = new int[input.length][784];
  for(int i=0; i<input.length; i++)
  {
    for(int j=0; j<784; j++)
    {
      output[i][j] = input[i][j+1];
    }
  }
  return output;
}

//Function to display an image when given a 1d array of 784 ints
public void displayIMG(int []input)
{  
  img =  createImage(28,28,ARGB);//Creates the image as new an clean each time
  img.loadPixels();//loads the img objects pixel array
  for(int i=0; i<784; i++)
  {
    int bright = input[i];//Sets the brightness variable to the value stored at that place in the MNST array
    //println(i);
    //int index = i*4;
    img.pixels[i] = color(bright,bright,bright,255);//Sets the pixels of the PImage to that brightness variable
  }
  img.updatePixels();
  img.resize(500,500);//Upscales, 28X28 is very small
  imageMode(CENTER);
  image(img,width/2,height/2);//Displays image 
}


//Function to convert 1d string arrays to int
public int [] strToInt(String []input)
{
  int [] output = new int[input.length];
  for (int i=0; i<input.length; i++)
  {
    output[i] = int(input[i]);
  }
  return output;
}


public float findMax(float []input)//Fins index of max value of array
{
  float maxSoFar = 0;
  float maxIndex = 0;
  for(int i=0; i<input.length; i++)
  {
    if(input[i] > maxSoFar)
    {
      maxSoFar = input[i];
      maxIndex = i;
    }
  }
  return maxIndex;
}





 
