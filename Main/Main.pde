int pxlSizeX = 15;
int pxlSizeY = 15;
int pxlCountX = 64;
int pxlCountY = 40;
element[] [] grid = new element[pxlCountY] [pxlCountX];
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
    }
  }
  display();
  insert(0,32,0);
  insert(1,0,32);
}

void draw(){
    for (int i = 0; i < pxlCountY; i++){
      //switch (i){
       // case 0:
          sorter0(i);
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