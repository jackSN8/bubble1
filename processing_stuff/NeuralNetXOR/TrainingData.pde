class TrainingData {
  float[] inputs;
  float[] target;

  TrainingData(float i, float j, float goal) {
    inputs = new float[2];
    inputs[0] = i;
    inputs[1] = j;
    target = new float[1];
    target[0] = goal;
  }

  TrainingData(float[] data, float[] goal) {
    inputs = data;
    target = goal;
  }
}
