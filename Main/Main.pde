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
    for (int i = 0; i < pxlCountY; i++){
      switch (i){
        case 0:
          sorter0(i);
          break;
        }
      display();
      }
  }

void keyPressed(){
  if (key == 115){
  shuffle();
  }
}


boolean sorter0(int i){
  element temp;
  for(int j = 0; j < grid[i].length - 1; j++){
    println(grid[i][j].getHueValue());
    println(grid[i][j+1].getHueValue());
    println(grid[i][j].getHueValue() > grid[i][j+1].getHueValue());
    if(grid[i][j].getHueValue() > grid[i][j+1].getHueValue()){
      temp = grid[i][j];
      grid[i][j] = grid[i][j+1];
      grid[i][j+1] = temp;
      println("test");
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