/* Player class handles almost everything what the playerobject needs to do 
*  Paul Donner 
*/

class Player {

  private PVector pos;  //stores my x,y,(z) position
  private PVector accel;//stores the accleeration of my player
  private PVector veloc;//stores the velocity 
  private PVector force;//stores the force, could e.g. be applied by may world 
  private float mass;  //has a mass 
  private float size;  //has a size could use integer for that as well to save some ressource but I may calculate with it so easier to do this 
  private float yBound;//for now we use a static yBound to deermine the lowest postion of the ball
  private ArrayList<Obstacle> collected;//stores my collected obstacles -> cubes 
  private ArrayList<Obstacle> shooted; //stores my shooted cubes, maybe they should be part of the world once shooted ? but for now it s like that  
  color playercolor; //stores a color for the player if we like to 
  float rotZ = .1;
  
  //constructor 
  public Player(PVector pos, float mass, float size) {
    this.yBound = pos.y;
    this.pos = pos;
    this.mass = mass;
    this.size = size;
    this.force = new PVector(0, 4); //was for testing rn no usage
    this.accel = new PVector(0, 0);
    this.veloc = new PVector(0, 0);
    this.collected = new ArrayList<Obstacle>();
    this.shooted = new ArrayList<Obstacle>();
    this.playercolor = color(255,255,255);
  }
  //getter
  public PVector getPos() {
    return this.pos;
  }
  //move the player right 
  public void moveRight() {
    this.accel.add(new PVector(1, 0));
  }
  //move the player up like jumping
  public void moveUp() {
    this.accel.add(new PVector(0, -100));
  }
  //move the player left
  public void moveLeft() {
    this.accel.add(new PVector(-1, 10));
  }
  //move the player down 
  public void moveDown() {
  }
  //getter for cubes 
  public ArrayList<Obstacle> getCollected() {
    return this.collected;
  }
  //draw collected cubes
  private void  drawCollected() {
    for (int i = 0; i < collected.size(); i++) {
      Obstacle ob = collected.get(i);
      ob.pos.x = this.pos.x;
      ob.pos.y = this.pos.y - (2* ob.getSize())*(i+1);
      ob.display();
      //ob.pos.z = 0;
      //println("x",ob.pos.x,",y",ob.pos.y);
    }
  }
  //updates should later use the framerate better would be an acutall delta time calculated by millis, done that in another project
  //so everything would move framerate independent 
  //not implemented for now 
  //i m atually probaly more going for moving the terrain underneath the player 
  public void update(float dt) {

    if (this.pos.y >= yBound) {
      //this.veloc = new PVector(this.veloc.x,-this.veloc.y);
      //this.veloc = new PVector(this.veloc.x, this.veloc.y * -1);
      this.pos.y = yBound;
      //this.veloc(0,0);
    }

    this.accel.add(this.force.div(mass));    //commonly known equation for newtons basic law of motion F = m * a >> a = F / m when we get a force from the world like gravity that would be a = gravity / mass   
    this.veloc = this.veloc.add(this.accel); //add accel to the veloc 
    this.veloc.limit(50);                    //limit the veloc to a certain limit 
    this.pos.add(veloc);                     //add the veloc to the pos 
  }
  
//the shoot function 
  public void shoot(PVector direction) {

    //check if we collected an item 
    if (collected.size()>0) {
      //Obstacle projectile = this.collected.get(this.collected.size()-1);
      
      //take the lowest item from the cube stack 
      Obstacle projectile = this.collected.get(0);
      //add the item to the projectiles -> flying
      this.shooted.add(projectile);
      //remove it form the collected ones
      this.collected.remove(projectile);
      //add a force of the directional vector we get and multiply it by 2
      projectile.addForce(direction.mult(2));
      //projectile.addVeloc(new PVector(3,0));
      //set the rotation of the cube backwards bc looks coolio^^
      projectile.setRotIncr(-0.1);
    }
  }

  //just display the projectile until it s out of screen if its out of screen we delete it from the arraylist
  public void drawProjectile() {
    for (int i = 0; i < shooted.size(); i++) {
      shooted.get(i).display();
      if (shooted.get(i).getPos().x > width) {
        shooted.remove(i);
      }
    }
  }
  //getter
  public ArrayList<Obstacle> getProjectiles() {
    return this.shooted;
  }

  //should check for collision of the player with the walls but also of the projectile with a wall
  public void checkForCollision(ArrayList<Wall> walls) {
    checkForProjectileCollision(walls);
   
    for(int i = 0; i< walls.size();i++){
      if(this.pos.x >= walls.get(i).getPos() - this.size){
        this.pos.x = walls.get(i).getPos() - this.size;
        break; 
      }
    }
   
    //this.
  }
  //if the projectile hits a wall then the wall gets hit
  private void checkForProjectileCollision(ArrayList<Wall> walls) {
    if (shooted.size() > 0 && walls.size() > 0) {
      //println(shooted.size()); 
      //println(walls.size());
      for (int i= 0; i < shooted.size(); i++) {
        for (int j = 0; j < walls.size(); j++) {
          //println(shooted.get(i).getPos().x); 
          //println(walls.get(j).getPos()); 
          if ( 
              (shooted.get(i).getPos().x > walls.get(j).getPos())
           && (shooted.get(i).getPos().y <= walls.get(j).getPosY()+walls.get(j).getH())
           && (shooted.get(i).getPos().y + shooted.get(i).getSize() >= walls.get(j).getPosY() - walls.get(j).getH()/2 )
           ) {
            //println("shootery",shooted.get(i).getPos().y + shooted.get(i).getSize() );
            //println("yPos",walls.get(j).getPosY(),"wheight",walls.get(j).getH());
            shooted.remove(i);
            walls.get(j).hit();
            break; //thats kinda ugly but no time^^
          }
        }
      }
    }
  }
  
  //display the player and everything what the player stores as objects related to it 
  public void display() {
    rotZ +=.1;
    push();
    noStroke();
    //fill(25);
    //translate(0,height/2);
    translate(this.pos.x, this.pos.y);
    rotateZ(rotZ);
    fill(playercolor);
    sphere(this.size);
    pop();
    drawCollected();
    drawProjectile();
  }
}
