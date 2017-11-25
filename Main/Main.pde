int pxlSizeX = 15;
int pxlSizeY = 15;
int pxlCountX = 64;
int pxlCountY = 20;
element[] [] grid = new element[pxlCountY] [pxlCountX];


//sorter 1 global variables
float sorter1Minimum;
int sorter1BlockSize = 5;
boolean sorter1Setup = false;
int sorter1Last = 0;
//end

String[] names = {"Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort", "Quicksort"};
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
    }
  }
  display();
}

void draw(){
    for (int i = 0; i < pxlCountY; i++){
      //switch (i){
       // case 0:
          sorter1(i);
        //  break;
        //}
      display();
      }
  }

void keyPressed(){
  if (key == 115){
  shuffle();
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
  if (sorter1Setup == false){
    for (int j = 0; j < grid[i].length - 1; j++){
      if (grid[i][j].getHueValue() < sorter1Minimum){
        sorter1Minimum = grid[i][j].getHueValue();
      }
    }
    sorter1Setup = true;
    for (int j = sorter1Last; j < grid[i].length - 1; j++){
      for (int k = 0; k < grid[i].length -1; k++){
        if(grid[i][j].getHueValue() > grid[i][k].getHueValue()){
          append(smallerArray, k);
        }
      }
      if (smallerArray.length != 0){
        smallest = smallerArray[0];
        for (int l = 0; l < smallerArray.length - 1; l++){
          if (grid[i][smallerArray[l]].getHueValue() < grid[i][smallest].getHueValue()){
            smallest = smallerArray[l];
          }
        }
        swap(i, j, smallest);
        return;
      }
    }
  }
}

void shuffle(){
  element temp;
  int tempInt; 
  for (int i = 0; i < grid.length; i++){
    swaps[i] = 0;
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
  text(swaps[i], pxlSizeX * pxlCountX - 20, pxlSizeY * (i + 1) - 1);
  }
}

void swap(int i, int j, int k){
  element temp;
  temp = grid[i][j];
  grid[i][j] = grid[i][k];
  grid[i][k] = temp;
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