class Obstacle {
  float rotY = 0;
  float rotYIncr = 0.01; 
  PVector pos;
  PVector accel; 
  PVector veloc; 
  PVector force; 
  float size;
  float mass;
  float globalXRot;
  color c; 
  color strokeC; 

  public Obstacle(float x, float y, float size, float mass, float globalXRot) {
    this.pos = new PVector(x, y);
    this.size = size;
    this.mass = mass;
    this.globalXRot = globalXRot;
    this.accel = new PVector(0,0); 
    this.veloc = new PVector(0,0); 
    this.force = new PVector(0,0); //should get the system / world force e.g gravity or smth 
  }
  
  public float getSize(){
    return this.size; 
  }
  
   public PVector getPos(){
    return this.pos; 
  }
  
  public void addVeloc(PVector veloc){
    this.veloc.add(veloc); 
  }
  
  public void setRotIncr(float incr){
    this.rotYIncr = incr; 
  }
  
  public void addForce(PVector force){
    this.force.add(force); 
  }
  
  public void update(){
    this.accel.add(this.force.div(mass));  
    this.veloc.add(this.accel);
    this.pos.add(this.veloc); 
    this.veloc.limit(5);
  }
  
  public void changeColor(){
    //lets change the color here so when we are collected it got maybe another color than if 
    //the collectable is only floating around, if the collectable is shooted it maybe gets another color as well 
  }

  public void display() {
    update(); 
    pushMatrix();
    rotY += rotYIncr; //let it increase its rotation
    translate(this.pos.x, this.pos.y); 
    fill(245,200);
    rotateX(globalXRot);  //rotate it dependend on the global Value 
    rotateY(rotY);        //rotate it dependend on the changing variable rotY . . . actually there might be a problem here since float only stores values up to 32 Bit so if that would be exceeded over time we could face an issue we could reserve more capacity by using double but probably what we want to do is limit and set back to zero  
    box(this.size);       //shows the box 
    popMatrix();
  }
}
