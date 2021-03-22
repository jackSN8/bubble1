NeuralNet Brain;
//Needs to take in both a template weights file, and an incoming data file, both txts
//Need a new constructor function for NN, replace old one? This takes in size cause i dont wanna do bs sqrts and 4 matrices for weights and biases
//////REMINDER USE FLOAT NOT INT FOR THIS, ALL VALUES ARE >-1 <1
String [] weightStr;
////Remove below
//Matrix TweightsIH;
//Matrix TweightsHO;
//Matrix TbiasH;
//Matrix TbiasO;

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
  int totalInputs = 784;
  int totalHiddens = 20;
  int totalOutputs = 10;
  
  
  size(1000,1000);
  //This side deals with reading the weights file and setting up the NN
  weightStr = loadStrings("SavedNN.txt");
  
  Matrix TweightsIH = LoadIntoMatrix(0,15680,weightStr,totalHiddens,totalInputs);
  Matrix TweightsHO = LoadIntoMatrix(19999,20199,weightStr,totalOutputs,totalHiddens);
  Matrix TbiasH = LoadIntoMatrix(29999,30019,weightStr,totalHiddens,1);
  Matrix TbiasO = LoadIntoMatrix(39999,40009,weightStr,totalOutputs,1);
  
  Brain = new NeuralNet(784, 20, 10,TweightsIH,TweightsHO,TbiasH,TbiasO);  
  //Below deals with actual incoming data
  input = loadStrings("MnistTest.txt");//Loads the txt file
  
  String [] newInp = new String[785*600];//Cuts off any data past that value. Value must divide by 785, and is to be removed.
  arrayCopy(input,0,newInp,0,785*600);
  
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
  background(51);
  //Then actually run the NN on the data. YAY!
  ////Directly copied from the train algorithim so might have wierd comments
  background(0);
  int currentImage = int(t%600.0);
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
//Function that takes in a random long string array, and creates a matrix with a specified set of values in that string array. Requires Matrix size.
public Matrix LoadIntoMatrix(int start,int stop, String [] input,int rows, int cols)
{
  String []tempStrData = new String [stop-start];
  //println("split");
  //println(tempStrData.length);
  //println(start);
  //println(stop);
  //println(rows*cols);
  //println(input[19999]);
  //println(input[20199]);
  arrayCopy(input,start,tempStrData,0,stop-start);
  
  //for(int i=19999; i<tempStrData.length+19999; i++)
  //{
  //  println("next one");
  //  println(input[i]);
  //  println(i);
  //}
  
  float []tempFloatData = float(tempStrData);
  println(tempFloatData.length);
  printString(tempFloatData,"debug1.txt");

  Matrix output = new Matrix(rows, cols);
  //Text file is structured so that each column is whole - ie for the 20 rows by 784 cols matrix, you have lines 1-784 containing column 1
  float [][]MatrixFloat = convertTwoD(tempFloatData,rows,cols);
  output.values = MatrixFloat;
  /////Matrix bruh shit fuck below
  //for(int i=0; i<rows; i++)
  //{
  //  println(i);
  //  for(int j=0; j<cols; j++)
  //  {
  //    output.values[i][j]=tempFloatData[i*j+j];//1D file is structured column, column, column, so iterate through each colum, and at the end, iterate row
  //    if(i*j+j==784)
  //    {
  //      println(tempFloatData[i*j+j]);
  //    }
  //  }
  //}
  printMatrix(output,"debug2.txt");
  return output;//???????????????    
}
//Function to convert 1D array of 2D data structured column, column... to 2d form
public float [][] convertTwoD(float [] input,int rows, int cols)
{
  
  float [][]output = new float[rows][cols];
  //println(output.length);
  //println(output[0].length);
  int k=0;//Variable that stores iterates by cols every time you incriment through each column on the 2d output matrix
  for(int i=0; i<rows; i++)
  {    
    //println(i);
    //println(k);
    //println(output[i]);
    //println(input[0]);
    //println(input[0]);
    
    println(input.length);
    //println(input[14896+cols]);
    //arrayCopy(input,14896,output[19],0,cols);
    arrayCopy(input,k,output[i],0,cols);
    k+=cols;
      k--;
  }
  return output;
}

public void printString(float[]input,String name)
{
  PrintWriter output;
  output = createWriter(name);
  for(int i=0; i<input.length; i++)
  {
    output.println(input[i]);
  }
  output.flush();
  output.close();
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

public void mousePressed()
{
  PrintWriter output;
  Matrix TweightsIH = Brain.weightsIH;
  Matrix TweightsHO = Brain.weightsHO;
  Matrix TBiasH = Brain.biasH;
  Matrix TBiasO = Brain.biasO;
  output = createWriter("SavedNNxd.txt");
  //output.println("Input to hidden weights");
  saveMatrix(TweightsIH,output);
  if(textLine<20000)
  {
    float diff = 20000-textLine;
    for(int i=0; i<diff; i++)
    {
      textLine ++;
      output.println("");
    }
  }
  //output.println("Hidden to output weights");
  saveMatrix(TweightsHO,output);
  if(textLine<30000)
  {
    float diff = 30000-textLine;
    for(int i=0; i<diff; i++)
    {
      textLine ++;
      output.println("");
    }
  }
  //output.println("Hidden biases");
  saveMatrix(TBiasH,output);
  if(textLine<40000)
  {
    float diff = 40000-textLine;
    for(int i=0; i<diff; i++)
    {
      textLine ++;
      output.println("");
    }
  }
  //output.println("Output biases");
  saveMatrix(TBiasO,output);
  output.flush();
  output.close();
}

public void saveMatrix(Matrix input,PrintWriter output)
{
   for(int i=0; i<input.rows; i++)
   {
     for(int j=0; j<input.cols; j++)
     {
       output.println(input.values[i][j]);
       textLine ++;
     }
   }
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



 
