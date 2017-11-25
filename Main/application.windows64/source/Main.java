import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Main extends PApplet {

int pxlSizeX = 10;
int pxlSizeY = 10;
int pxlCountX = 128;
int pxlCountY = 20;
element[] [] grid = new element[pxlCountY] [pxlCountX];


public void settings(){
    size(pxlSizeX * pxlCountX,pxlSizeY * pxlCountY);

}


public void setup(){
  element temp;
  int tempInt;
  frameRate(480);
  
  for (int i = 0; i < pxlCountY; i++){
    for (int j = 0; j < pxlCountX; j++){
      grid[i][j] = new element();
      grid[i][j].init(j);
    }
  }
  display();
}

public void draw(){
    for (int i = 0; i < pxlCountY; i++){
      //switch (i){
       // case 0:
          sorter0(i);
        //  break;
        //}
      display();
      }
  }

public void keyPressed(){
  if (key == 115){
  shuffle();
  }
}


public boolean sorter0(int i){
  element temp;
  for(int j = 0; j < grid[i].length - 1; j++){
    if(grid[i][j].getHueValue() > grid[i][j+1].getHueValue()){
      temp = grid[i][j];
      grid[i][j] = grid[i][j+1];
      grid[i][j+1] = temp;
      return false;
    }
  }
  return true;
}


public void shuffle(){
  element temp;
  int tempInt; 
  for (int i = 0; i < grid.length; i++){
    for (int j = 0; j < grid[i].length; j++){
      tempInt = PApplet.parseInt(random(0,pxlCountX));
      temp = grid[i][j];
      grid[i][j] = grid[i][tempInt];
      grid[i][tempInt] = temp;
    }
  }
  display();
}


public void display(){
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      element arrayElement = grid[i][j];
      int rectPosX;
      int rectPosY;
      int pxlColor;
      rectPosX = pxlSizeX * j;
      rectPosY = pxlSizeY * i;
      colorMode(HSB, 360, 100, 100);
      pxlColor = color(arrayElement.getHueValue(), 100, 100);
      fill(pxlColor);
      rect(rectPosX, rectPosY, pxlSizeX, pxlSizeY);
    }
  }
}

public void swap(int i, int j, int k){
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
  public void init(int num){
    number = num;
    hueValue = (360/PApplet.parseFloat(pxlCountX)) * num;
  }
  public float getHueValue(){
    return hueValue;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
