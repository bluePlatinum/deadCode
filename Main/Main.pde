int pxlSizeX = 5;
int pxlSizeY = 5;
int pxlCountX = 256;
int pxlCountY = 1;


void setup(){
  size(pxlSizeX * pxlCountX,pxlSizeY * pxlCountY);
 
}

void draw(){

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