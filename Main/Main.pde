int pxlSizeX = 15;
int pxlSizeY = 15;
int pxlCountX = 64;
int pxlCountY = 40;
element[] [] grid = new element[pxlCountY] [pxlCountX];
ArrayList<ArrayList<Long>> timeUsed = new ArrayList<ArrayList<Long>>();
boolean[] lineSorted = new boolean[pxlCountY];


//sorter 1 global variables
float[] sorter1Minimum = new float[pxlCountY];
int[] sorter1MinimumPos = new int[pxlCountY];
int[] sorter1BlockSize = new int[pxlCountY];
int[] sorter1Last = new int[pxlCountY];
boolean[] sorter1Wiped = new boolean[pxlCountY];
//end

//sorter 2 global variables
int[] sorter2Phase = new int[pxlCountY];
int sorter2BlockNumber = 5;
int[][] sorter2BlockPositions = new int[pxlCountY][sorter2BlockNumber];
float[][] sorter2BlockSeperators = new float[pxlCountY][sorter2BlockNumber];
int[] sorter2Last = new int[pxlCountY];
//end

String[] names = {"Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort","Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort"};

int[] swaps = new int[pxlCountY];

void settings(){
    size(pxlSizeX * pxlCountX,pxlSizeY * pxlCountY);

}


void setup(){
  frameRate(480);
  
  for (int i = 0; i < pxlCountY; i++){
    for (int j = 0; j < pxlCountX; j++){
      grid[i][j] = new element();
      grid[i][j].init(j);
      timeUsed.add(new ArrayList<Long>());
      lineSorted[i] = false;
    }
  }
  display();
  sorter1Reset();
  sorter2Reset();
}

void draw(){
  long timeTemp;
  for (int i = 0; i < pxlCountY; i++){
     lineSorted[i] = true;
     if(i < 21){
       timeTemp = System.nanoTime();
       sorter1(i);
       if(!lineSorted[i]) {
         timeUsed.get(i).add(System.nanoTime()-timeTemp);
       }
     } else if (20 < i ){
       timeTemp = System.nanoTime();
       sorter0(i);
       if(!lineSorted[i]) {
         timeUsed.get(i).add(System.nanoTime()-timeTemp);
       }
     }
    display();
    }
}

void keyPressed(){
  if (key == 115){
  shuffle();
  sorter1Reset();
  sorter2Reset();
  }
}


void sorter0(int i){
  for(int j = 0; j < grid[i].length - 1; j++){
    if(grid[i][j].getHueValue() > grid[i][j+1].getHueValue()){
      swap(i,j,j+1);
      swaps[i]++;
      return;
    }
  }
  return;
}


void sorter1(int i){
  int[] smallerArray = {};
  Integer smallest;
  
  if (sorter1Wiped[i]){
    for (int j = 0; j < grid[i].length; j++){
      if (grid[i][j].getHueValue() < sorter1Minimum[i]){
        sorter1Minimum[i] = grid[i][j].getHueValue();
        sorter1MinimumPos[i] = j;
      }
    }
    sorter1Wiped[i] = false;
    swap(i, sorter1MinimumPos[i], 0);
    swaps[i]++;
    return;
  }
  for (int j = sorter1Last[i]; j < grid[i].length; j++){
    for (int k = j; k < grid[i].length; k++){
      if(grid[i][j].getHueValue() > grid[i][k].getHueValue()){
        smallerArray = append(smallerArray, k);
      }
    }
    if (smallerArray.length != 0){
      smallest = smallerArray[0];
      for (int l = 0; l < smallerArray.length; l++){
        if (grid[i][smallerArray[l]].getHueValue() < grid[i][smallest].getHueValue()){
          smallest = smallerArray[l];
        }
      }
      swap(i, j, smallest);
      swaps[i]++;
      sorter1Last[i] = j;

      return;
    }
  }
}

void sorter1Reset(){
  for (int i = 0; i < pxlCountY; i++){
    sorter1MinimumPos[i] = pxlCountX - 1;
    sorter1BlockSize[i] = 5;
    sorter1Last[i] = 0;
    sorter1Wiped[i] = true;
  }
  return;
}

void sorter2(int i){
  if (sorter2Phase[i] == 0){
    for (int j = 0; j < sorter2BlockNumber; j++){
      if (grid[i][j].getHueValue() > grid[i][j+1].getHueValue()){
        swap(i, j, j+1);
        swaps[i]++;
        return;
      }
    }
    for (int j = 0; j < sorter2BlockNumber; j++){
      sorter2BlockSeperators[i][j] = grid[i][j].getHueValue();
      sorter2BlockPositions[i][j] = j;
    }
    sorter2Phase[i]++;
  }
  else if (sorter2Phase[i] == 1){
    for (int j = sorter2Last[i]; j < grid[i].length; j++){
      for (int k = 0; k < sorter2BlockSeperators[i].length; k++){
        if (grid[i][j].getHueValue() < sorter2BlockSeperators[i][0]) {
          insert(i, j, 0);
          
          for (int shift = 0; shift < sorter2BlockPositions[i].length; shift++){
            sorter2BlockPositions[i][shift]++;
          }
          sorter2Last[i]++;
          swaps[i]++;
          if (sorter2Last[i] == grid[i].length - 1){
            sorter2Phase[i] = 2;
          }
          return;
        }
        else if (grid[i][j].getHueValue() > sorter2BlockSeperators[i][k] && grid[i][j].getHueValue() < sorter2BlockSeperators[i][k+1]){
          insert(i, j, sorter2BlockPositions[i][k] + 1);
          
          for (int shift = k + 1; shift < sorter2BlockPositions[i].length; shift++){
            sorter2BlockPositions[i][shift]++;
          }
          sorter2Last[i]++;
          swaps[i]++;
          if (sorter2Last[i] == grid[i].length - 1){
            sorter2Phase[i] = 2;
          }
          return;
        }
        else if (grid[i][j].getHueValue() > sorter2BlockSeperators[i][sorter2BlockSeperators[i].length-1]){
          insert(i, j, sorter2BlockPositions[i][sorter2BlockPositions[i].length-1] + 1);
          
          sorter2Last[i]++;
          swaps[i]++;
          if (sorter2Last[i] == grid[i].length - 1){
            sorter2Phase[i] = 2;
          }
          return;
        }
      }
    }
  }
  else if (sorter2Phase[i] == 2){
    sorter0(i);
    return;
  }
}

void sorter2Reset(){
  for (int i = 0; i < pxlCountY; i++){
    sorter2Phase[i] = 0;
    sorter2Last[i] = 0;
  }
}

void shuffle(){
  element temp;
  int tempInt; 
  for (int i = 0; i < grid.length; i++){
    swaps[i] = 0;
    lineSorted[i] = false;
    timeUsed.get(i).clear();
    for (int j = 0; j < grid[i].length; j++){
      tempInt = int(random(0,pxlCountX));
      temp = grid[i][j];
      grid[i][j] = grid[i][tempInt];
      grid[i][tempInt] = temp;
    }
  }
  display();
}


void display(){
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      element arrayElement = grid[i][j];
      int rectPosX;
      int rectPosY;
      color pxlColor;
      rectPosX = pxlSizeX * j;
      rectPosY = pxlSizeY * i;
      colorMode(HSB, 360, 100, 100);
      pxlColor = color(arrayElement.getHueValue(), 100, 100);
      fill(pxlColor);
      noStroke();
      rect(rectPosX, rectPosY, pxlSizeX, pxlSizeY);
    }
  colorMode(RGB);
  color txtColor = color(RGB,0,0,0);
  fill(txtColor);
  textSize(pxlSizeY);
  textAlign(LEFT);
  text(names[i], 2 , pxlSizeY * (i + 1) - 1);
  textAlign(RIGHT);
  String rightText;
  float timeAverage;
  if (timeUsed.get(i).size()>0) {
  timeAverage = 0;
    for(int j = 0; j < timeUsed.get(i).size(); j++){
    timeAverage += timeUsed.get(i).get(j);
    }
  timeAverage /= float(timeUsed.get(i).size());
  } else {
  timeAverage = 0;
  }
  rightText = swaps[i] + "/" + round(timeAverage) + "ns";
  text(rightText, pxlSizeX * pxlCountX - 20, pxlSizeY * (i + 1) - 1);
  }
}

void swap(int i, int j, int k){
  element temp;
  temp = grid[i][j];
  grid[i][j] = grid[i][k];
  grid[i][k] = temp;
  lineSorted[i] = false;
}

void insert(int i, int j, int k){
  //moves element j to position k
  element temp;
  if (j > k){
    temp = grid[i][j];
    for(int l = j; l > k; l--){
      grid[i][l] = grid[i][l - 1];
    }
    grid[i][k] = temp;
  }
  else if (j < k) {
    temp = grid[i][j];
    for(int l = j; l < k; l++){
      grid[i][l] = grid[i][l +1];
    }
    grid[i][k] = temp;
  }
  lineSorted[i] = false;
}

class element{
  float hueValue;
  int number;
  element(){
  }
  void init(int num){
    number = num;
    hueValue = (360/float(pxlCountX)) * num;
  }
  float getHueValue(){
    return hueValue;
  }
}