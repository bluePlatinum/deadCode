int pxlSizeX = 5;
int pxlSizeY = 5;
int pxlCountX = 256;
int pxlCountY = 1;

void setup(){
  size(pxlSizeX * pxlCountX,pxlSizeY * pxlCountY);
 
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
  element(int num){
    number = num;
    hueValue = 360/pxlCountX * num;
  }
  float getHueValue(){
    return hueValue;
  }
}