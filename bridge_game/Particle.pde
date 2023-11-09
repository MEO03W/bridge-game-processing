/* Class for a single particle 
* Paul Donner 
*/

class Particle{

  PVector pos;  //current position 
  PVector accel; //acceleration
  PVector veloc; //velocity
  PVector force; //force
  float mass;    //mass
  float size;    //size here raidus 
  color c = color(255,random(45,130)); //color uses a white whith an alpha between 45 and 130, since we have a colorful background we don't really need other colors 
  
  //constructor 
  public Particle( PVector pos, PVector force, float mass, float size){
    this.pos = new PVector(pos.x,pos.y,random(-height,height)); //place it somewehere random on the z axis as well    
    this.accel = PVector.random3D().mult(40); //creates a random 3D vector so its random it which direction it pints in the 3D world since it will be between 0 and 1 for every dimension it gets multiplied by 40 to give it ome intial speed and random movement 
    this.veloc = new PVector(0,0);            //init with zero
    this.force = force;                       //use the systems force passed down
    this.mass = mass;                           
    this.size = size; 
  }
  
  public void applyForce(PVector force){
    this.accel.add(force.div(this.mass));   //we can aplly some force form the outside
  }
  
  //updates a particle already descibed in other classes
  public void update(){
    this.accel.add(this.force.div(mass)); 
    this.veloc = this.veloc.add(accel); 
    this.veloc.limit(1); 
    this.pos.add(this.veloc);
  }
  //only displays it 
  public void display() {
    push();
      noStroke(); 
      fill(c); 
      //translate(0,0,pos.z); 
      circle(pos.x,pos.y,size); 
    pop();
  }
  
  




}
