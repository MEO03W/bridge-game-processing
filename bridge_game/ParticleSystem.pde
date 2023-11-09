import java.util.*; 
/*
*  the ParticleSystem i used in other projects already just a bit rewritten and simplyfied for now 
*  Paul Donner 
*/
class ParticleSystem {
 
  int count = 0;
  ArrayList<Particle> particles; //store a list of all the single particles 
  PVector systemForce;          //we use a system force might be related to the world force e.g gravity
  int minRadius = 1;            //minimal size of a particle - feel free to play around with those 
  int maxRadius = 3;            //maxSize of a particle      - feel free to play around with those

  //constuctor 
  public ParticleSystem() {
    this.particles = new ArrayList<Particle>(); //init the arraylist 
    this.systemForce = new PVector(0, .1);      //give the particlesystem an artificial force of positive 0.1 downwards 
  }
  //can change the particle count if we want to adjust manually from a higher hirarchy 
  public void setParticleCount(int c) {
    this.count = c;
    createParticleSystem();
  }
  //creates all particles 
  private void createParticleSystem() {

    for (int i = 0; i < count; i++) {
      this.particles.add(new Particle( new PVector(random(width),random(-height/2,height/2)) , this.systemForce , 1 , random(3,10) ) );
    }
  }
  //create only 1 new particle and adds it to the system 
  private void createSingleParticle(){
    this.particles.add(new Particle( new PVector(random(width),random(-height/2,height/2)) , this.systemForce , 1 , random(3,10) ) );
  }; 
  
  //can be used to aplly a new force e.g. wind dircetion or negative moving direction which i planned to do 
  public void applyForce(PVector force) {
    this.systemForce.add(force);
  }
  
  //checks the boundaries of a particle so if the particle is outside of the screen than return true 
  public boolean checkBound(Particle p){
    return (p.pos.y >= height + p.size || p.pos.y <= 0 - p.size ||p.pos.x >= width +p.size ||p.pos.x <= 0 - p.size ); 
  }
  
  //update the particles 
  //if outside remove it and create a new one 
  public void update(){
    for(int i= 0; i < particles.size(); i++){
      Particle p = particles.get(i); 
      
      if(checkBound(p)){
        particles.remove(i);
        createSingleParticle(); 
      }
      p.update();
    }
    //the remoe problem while iterating through an arraylist you cant remove while using a for each method 
    //you would need to use the iterator method but somehow it didn't work and since i want to add a new particle one i remove one 
    //i don't have a problem by just using normal for loops, since there will be no smaller size of the arraylist and therefor 
    //no currentmodifacation exception 
    /* 
    for(Iterator i = particles.iterator(); i.hasNext();){
      //Particle p = i.next();
      //println(i.next());
      
      // if(checkBound(i.next())){
     //   println("outofBounds"); 
       
     // }
    }
    */
  
  }
  //display a particle in using the simplified for each method   
  public void display(){
    for(Particle p : particles){
       
     p.display();  
    }
  }
  //updates and displays everything should be used from the outside 
  public void run(){
    update(); 
    display(); 
  }
}
