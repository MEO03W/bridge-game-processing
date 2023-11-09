float terrain[];
float rotx;
float scl = width / 10;
float globalRotation = HALF_PI -0.2;
Terrain myterrain;
World world;
UI ui;
Player player;
int obstacleCount = 10;
//
PImage bg;

void setup() {
  background(24);
  size(1000, 668, P3D);
  player = new Player(new PVector(200, height/2-70), 1, 20);
  //createObstacles();
  //myterrain = new Terrain(-10, 10000,300,100);
  // createTerrain();
  //lets do preloader again : )
  world = new World();
  ui = new UI();
}




void createTerrain() {
  pushMatrix();
  fill(255);
  stroke(100);
  strokeWeight(1);
  rotateX(globalRotation);
  for (int i  = 0; i<width; i+=scl ) {
    translate(i, 0, 0);
    box(scl*i, 200, scl);
  }
  popMatrix();
}

void keyPressed() {

  switch (key) {
  case 'd':
    this.player.moveRight();
    break;
  case 'D':
    this.player.moveRight();
    break;

  case 'a':
    this.player.moveLeft();
    break;
  case 'A':
    this.player.moveLeft();
    break;

    //UP
  case 'w':
    this.player.moveUp();
    //println("w");
    break;
  case 'W':
    this.player.moveUp();
    break;
  }
  println(this.player.veloc);
  println(this.player.pos);
}

//Draws the line for the shooter and collector 
void drawShooterLine(PVector pos) {
  stroke(255);
  strokeWeight(2);
  line(mouseX, mouseY, pos.x, pos.y);
}

//for the mouse PRess events 
void mousePressed() {
  //do we collect or not 
  boolean collecting = false; 
  
  //check if we collecting an cube right now 
  for (int i = 0; i < world.obstacles.size(); i++) {
    if ( (mouseX >= world.obstacles.get(i).pos.x) && (mouseX <= world.obstacles.get(i).pos.x + world.obstacles.get(i).size  )) {
      //is noch bisgen buggy musst nochmal überarbeiten por favor
      player.collected.add(world.obstacles.get(i));
      world.obstacles.remove(i);
      ui.score += 1;
      collecting = true; 
      println("getroffen");
    }
  }
  //if we are not collecting anything then try to shoot while using the direction of the cursor 
  //we normalize the vector so we don't get issues with the acceleration or velocity 
  //shoot will check if we have something to shoot so we dont need to worry here 
  //we could have done a try catch and than throw some exceptions 
  //but since there is only this limited ide where we can't even trace or stacktrace exceptions we just try to prevent exceptions 
  //which is btw pretty hard for coding to not even having the trace of a nullpointerexception 
  //basically we need to code line by line 
  if(!collecting){
    PVector direction = new PVector(mouseX,mouseY).sub(player.getPos().copy());
    //println(direction); 
    //println(direction.normalize()); 
    player.shoot(direction.normalize());
  }
  
}


//draw everything 
void draw() {

  /*camera(
    width/2.0 + player.getPos().x, //eyeX
    height/2.0, //eyeY
    ( height/2.0 )/tan(PI * 30 / 180.0), //eyeZ
    width/2.0 + player.getPos().x , //centerX
    height/2.0, //centerY
    0.0, //centerZ
    0.0, //upX
    1.0, //upY
    0.0 //upZ
    ); */ 
  
  world.render();  //draw the world 
  ui.gameScreen();//draw the ui game screen
  player.checkForCollision(world.getTerrain().getWalls()); //check the player for any collisions 
  player.update(frameRate/60);  //update the player 
  player.display();             //display the player 
  drawShooterLine(this.player.getPos());  //draw the shooter line -> should probably move this to ui 
  ui.drawCursor(mouseX, mouseY);          //ui draws the cursor 
}
