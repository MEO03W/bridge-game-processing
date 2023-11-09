/* Wall describes a wall which will hinder the play on moving and acts as an barrier for the gameplay */
/* Paul Donner */ 
class Wall {

private  float xPos;    //where is the wall located on x dimension ? 
private  float initH;   //the initial height of the wall 
private  float h;       //the current hight of the wall 
private  float w;       //the width of the wall 
private  int lifePoints;//the life Points on integer values 
private  float yPos = 0;//the y position where it needs to be drawn
private  float depth;   //the depth, so the size in z-dimension
  
  //Contructor needs an y position and height and width of the wall 
  //it determines the y pos on its own relativ to the height of the wall 
  //it maps the width of the wall to a lifepoint value between 1 and 5
  public Wall(float x, float h, float w){
    
    this.xPos = x; 
    this.h = h; 
    this.initH = h;
    this.w = w; 
    this.lifePoints = int(map(w,10,50,1,5));
    this.depth = 100; 
    this.yPos = (height / 2) -h/2; 
  }
  
  //if the wall got hit it get a lifepoint deducted and shrinks in height 
  public void hit(){
    if(this.lifePoints > 0){
    this.lifePoints -= 1;
    this.h = map(lifePoints,0,5,0,initH);
    this.yPos = (height / 2) -h/2;
    }

  }
  //getter
  public int getLife(){
    return this.lifePoints; 
  }
  //getter
  public float getPos(){
    return this.xPos; 
  }
  //getter
  public float getH(){
    return this.h;
  }
  //getter
  public float getPosY(){
    return this.yPos; 
  }
  
  public void move(float move){
    this.xPos += move;
  }
  
  //draw the wall
  //draw the lifepoints of the wall underneath it 
  public void display(){
    
    push();
    translate(this.xPos,this.yPos); 
    String life = "Life "+this.lifePoints;
    //text(distance, 40, height-24*2, 280, 320);
    textSize(18);
    text(life,0,(this.initH/4)*3,100,200);
    rotateX(-0.2);
    box(this.w,this.h,this.depth); 
    pop();
  
  }
  
}
