int pxlSizeX = 5;
int pxlSizeY = 5;
int pxlCountX = 256;
int pxlCountY = 1;
element[] [] grid = new element[pxlCountX] [pxlCountY];


void settings(){
    size(pxlSizeX * pxlCountX,pxlSizeY * pxlCountY);
}


void setup(){
  element temp;
  int tempInt;

  
  for (int i = grid.length - 1; i > 1; i--){
    for (int j= grid[i].length - 1; j>1; j--){
      grid[i][j].init(j);
    }
  }
  
  for (int i = grid.length - 1; i > 1; i--){
    for (int j= grid[i].length - 1; j > 1; j--){
      tempInt = int(random(0,pxlCountX));
      temp = grid[i][j];
      grid[i][j] = grid[i][tempInt];
      grid[i][tempInt] = temp;
    }
  }
  
}

void draw(){

}

void display(){
  for (int i = grid.length - 1; i>1; i--) {
    for (int j = grid[i].length - 1; j>1; j--) {
      element arrayElement = grid[i][j];
      int rectPosX;
      int rectPosY;
      color pxlColor;
      rectPosX = pxlSizeX * i;
      rectPosY = pxlSizeY * j;
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
    hueValue = 360/pxlCountX * num;
  }
  float getHueValue(){
    return hueValue;
  }
}