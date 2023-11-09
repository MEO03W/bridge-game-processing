/* the Terrain stores and handles everything related to the playArea so it has the "bridge" and the walls  
* Paul Donner 
*/
class Terrain {
  float [][]ostaclePos;
  float begin;  //where does the bridge begin (x) 
  float end;    //where does the bridge end   (x)
  float deepness;//how deep on z axis is the bridge
  float boxwidth;//how wide on x is one box 
  float x = 0; 
  float y = 0; 
  ArrayList<Wall> walls; //stores all walls in the level 
  int wallCount = 10;    //how many walls do we want to create 
  
  //constructor 
  public Terrain(float begin, float end, float deepness, float boxwidth) {
    this.begin = begin;
    this.end = end;
    this.deepness = deepness;
    this.boxwidth = boxwidth;
    generateWalls();
  }
  //generates all walls 
  private void generateWalls(){
    walls = new ArrayList<Wall>(); 
    for(int i = 0; i< wallCount; i++ ){
      //uses randomness to generate them particular random in size so box width and height 
      this.walls.add(new Wall(begin+(i+1)*450,random(150,350),(random(10,50))));  
    }
  }
  
  //setter
  public void  setPosition(float x, float y){
    this.x = x; 
    this.y = y; 
  }
  //show all walls
  public void showWalls(){
    for(int i = 0; i < walls.size();i++){
      walls.get(i).display(); 
    }
    
  }
  //get the walls from terrain
  public ArrayList<Wall> getWalls(){
    return this.walls; 
  }
  //update the walls 
  //if the life of a wall gets under 1 it will be removed 
  //since we only can shoot the first wall to zero we can break after removing 
  //and otherwise the drawLoop with 60 fps is so fast we would still remove the next wall very fast 
  //couldnt test this because i neve rgot the angle to fistly "kill" the second wall before hitting the first 
  public void updateWalls(){
    for(int i= 0; i < walls.size(); i++){
      if(walls.get(i).getLife() < 1){
        walls.remove(i);
        break; 
      }
    
    }
  }
  
  public void update(){
   this.x += -.5; 
   for(Wall w :walls){
     w.move(-.5); 
   }
  }
  //displays terrain and walls 
  //wanted first to do some floating but it seemed really uncalm so i did exclude it for now 
  public void display() {
    updateWalls();
    showWalls();
    //x-=1; 
    //y+=0.1;
    float dispy =  sin(y)*5; 
    for (int i = int(this.begin); i < int(this.end); i+= this.boxwidth) {  
    push();
    stroke(0); 
    rotateX(HALF_PI-0.2);
    translate(this.x + i +this.boxwidth, 0,this.y + dispy);
    box(boxwidth,deepness,10);
    pop();
    }
    
  }
}
