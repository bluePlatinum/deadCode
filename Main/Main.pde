int pxlSizeX = 10;
int pxlSizeY = 10;
int pxlCountX = 128;
int pxlCountY = 20;
element[] [] grid = new element[pxlCountY] [pxlCountX];


void settings(){
    size(pxlSizeX * pxlCountX,pxlSizeY * pxlCountY);
}


void setup(){
  element temp;
  int tempInt;

  
  for (int i = 0; i < pxlCountY; i++){
    for (int j = 0; j < pxlCountX; j++){
      grid[i][j] = new element();
      grid[i][j].init(j);
    }
  }
  display();
}

void draw(){
  boolean allSorted = false;
  while (!allSorted){
    allSorted = true;
    for (int i = 0; i < pxlCountY; i++){
      switch (i){
        case 0:
          if(!sorter0(i)){allSorted = false;}
          break;
        }
      display();
      }
    }
  }

void keyPressed(){
  if (key == 115){
  shuffle();
  }
}


boolean sorter0(int i){
  element temp;
  for(int j = 0; j < grid[i].length; j++){
    if(grid[i][j].getHueValue() > grid[i][j++].getHueValue()){
      temp = grid[i][j];
      grid[i][j] = grid[i][j++];
      grid[i][j++] = temp;
      return false;
    }
  }
  return true;
}


void shuffle(){
  element temp;
  int tempInt; 
  for (int i = 0; i < grid.length; i++){
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
      rect(rectPosX, rectPosY, pxlSizeX, pxlSizeY);
    }
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