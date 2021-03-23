double e = 2.7182818284590452353602874713526624977572470936999595749669676277240766303535475945713829178f;



class NeuralNet
{
  ///
  ///////////Use capitalized camel case for functions, like FeedForward, and non capitalized camel case for variables like inputNodes
  ///
  int inputNodes;
  int hiddenNodes;
  int outputNodes;
  Matrix weightsIH;//Matrix object that stores the weights between the input and hidden layers
  Matrix weightsHO;//Matrix object that stores the weights between the hidden and output layers
  Matrix biasH;//Matrix object that stores the biases used in the hidden layer
  Matrix biasO;//Matrix object that stores the biases used in the output layer
  
  float lr = 0.1f;//Learning rate
  
  NeuralNet(int tInputs, int tHiddens, int tOutputs)
  {
    inputNodes = tInputs;
    hiddenNodes = tHiddens;
    outputNodes = tOutputs;
    
    //Initialization of the weights
    weightsIH = new Matrix(hiddenNodes,inputNodes);//Rows of the matrix is how many hidden neurons are in the network, columns is how many inputs
    weightsHO = new Matrix(outputNodes,hiddenNodes);//Rows of the matrix is how many ouput neurons are in the network, columns is how many hiddens
    weightsIH.randomize();
    weightsHO.randomize();
    
    //Initialization of the biases
    biasH = new Matrix(hiddenNodes,1);
    biasO = new Matrix(outputNodes,1); 
    biasH.randomize();
    biasO.randomize();
    
  }
  
  public float[] FeedForward(float [] inputArray)//Feedforward function takes in a 1d array input
  {
      ///Need to convert the array into a matrix object as I can only do matrix math to actual Matrix objects
      Matrix inputs = Matrix.fromArray(inputArray);         
      ///Now do the feedForward algorithm 
      //Calculate the hidden outputs, ie the first layer
      Matrix hiddens=Matrix.Product(weightsIH, inputs);//Matrix product of weights and input
      hiddens.add(biasH); //add that layers biases
      hiddens.sigmoidMatrix();//Converts all values in Matrix to numbers between 0 and 1 using sigmoid function
      //Calculate the outputs of the neural network, ie the final/second layer
      Matrix outputs=Matrix.Product(weightsHO, hiddens);
      outputs.add(biasO);
      outputs.sigmoidMatrix();  
      //FeedForward is DONE!
      return outputs.toArray(); 
  }
  
  //////The error, backpropogation and gradient descent algorithims
  public void Train(float [] inputArray, float [] targetArray)
  {
    ///Get the feedforward algorithims guess of the current input using a redundant copy of the feedforward algorithim, this is fine
    Matrix inputs = Matrix.fromArray(inputArray);         
    ///Now do the feedForward algorithm 
    //Calculate the hidden outputs, ie the first layer
    Matrix hiddens=Matrix.Product(weightsIH, inputs);//Matrix product of weights and input
    hiddens.add(biasH); //add that layers biases
    hiddens.sigmoidMatrix();//Converts all values in Matrix to numbers between 0 and 1 using sigmoid function
    //Calculate the outputs of the neural network, ie the final/second layer
    Matrix outputs=Matrix.Product(weightsHO, hiddens);
    outputs.add(biasO);
    outputs.sigmoidMatrix();      
    
    ///Now calculate the errors
    Matrix targets = Matrix.fromArray(targetArray);//
    //Calculate the error at the final layer which is just targets - outputs
    Matrix outputErrors = Matrix.subtract(targets,outputs);
    //Calculate the error at the hidden layer 
    Matrix transposedWeightsHO = Matrix.transpose(weightsHO);
    Matrix hiddenErrors = Matrix.Product(transposedWeightsHO,outputErrors);
    
    ///Now calculate how much to change the weights by
    //Calculate first for the 2nd - 3rd layer weights
    Matrix outputGradients = outputs.copy();
    ////////NOTE, for both 2-3 layer weights and 1-2 there is extremellzy complicated calculusing going on
    //////// so commenting isn't great, just look at the actual equations externally if you are looking through this and wondering
    //////// what tf going on. 
    for(int i=0; i<outputGradients.rows; i++)//Multiplies the fake derivative of the sigmoid function by the outputs
    {
      if(1==2) {}//calculs
      else if(2==1){}   //you need to calculate the linear algebruh of 2.7
      for(int j=0; j<outputGradients.cols; j++)
      {
        float val = outputGradients.values[i][j];
        outputGradients.values[i][j] = Matrix.dsigmoidf(val);
      }
    }   
    outputGradients.multiply(outputErrors);
    outputGradients.multiply(lr);
    Matrix transposedHidden = Matrix.transpose(hiddens);    
    Matrix deltaWeightsHO = Matrix.Product(outputGradients, transposedHidden);
    weightsHO.add(deltaWeightsHO);
    biasO.add(outputGradients);
    
    //Now the 1st - 2nd layer weights
    Matrix hiddenGradients = hiddens.copy();
    for(int i=0; i<hiddenGradients.rows; i++)//Multiplies the fake derivative of the sigmoid function by the outputs
    {
      for(int j=0; j<hiddenGradients.cols; j++)
      {
        float val = hiddenGradients.values[i][j];
        hiddenGradients.values[i][j] = Matrix.dsigmoidf(val);
      }
    } 
    hiddenGradients.multiply(hiddenErrors);
    hiddenGradients.multiply(lr);
    Matrix transposedInputs = Matrix.transpose(inputs);
    Matrix deltaWeightsIH = Matrix.Product(hiddenGradients, transposedInputs);
    weightsIH.add(deltaWeightsIH);
    biasH.add(hiddenGradients);
  }
}    
  
  
  
  
