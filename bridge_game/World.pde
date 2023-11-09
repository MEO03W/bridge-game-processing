/* World class handles everything in the world */
/* Paul Donner */ 
class World {
  private PVector gravity;              //for my worlds gravity if i want to use it rn i don't use it here  
  private PImage bg;                    //for the background image
  private ParticleSystem psystem;       //stores particles system 
  private Terrain terrain;              //stores my terrain 
  private ArrayList<Obstacle> obstacles;//stores my collectables which were obstacles in the beginning of the process 
  private int collectablesCount = 10;   //we can spawn more or less collectable cubes with this counter for testing 

  public World() {
    /*this.bg = bg;*/ 
    this.psystem = new ParticleSystem(); 
    this.psystem.setParticleCount(100); 
    this.terrain = new Terrain(-10, 10000,300,100); 
    this.terrain.setPosition(0,-height/2); 
    bg = loadImage("./assets/bg1.jpg"); 
    bg.resize(width,height); 
    createObstacles(); 
  }
/*GETTERS SETTERS */  
  public Terrain getTerrain(){
    return this.terrain; 
  }
  
  public ParticleSystem getParticleSystem(){
    return this.psystem; 
  }
//creatubg "obstacles" which are now my collectables since i change the game design a bit    
  private void createObstacles(){
    obstacles = new ArrayList<Obstacle>();
    for(int i = 0 ; i < collectablesCount; i++){
          obstacles.add(new Obstacle(random(width),random(100,height/2-40),20,20,globalRotation));    
    }
  }
  
//Lighting using point lights in pinkish and blueish to light the scene 
//lighting needs to be included in update/draw to render correctly as stated in the references
  private void lighting() {
    lights();
    push();
    //circle(200,-200,10);
    pointLight(220, 25, 10, 200, -200, 1);
    pointLight(10, 25, 220, width-200, -200, 1);
    pop();  
  }
//just for cleaner looks does only render my backround with the according image   
  private void drawBG(){
    background(bg); 
  }
//shows all my collectable cubes which were named obstacles initially   
  private void showCollectables(){
    for(Obstacle ob : obstacles){
      ob.display();
    }
  }
//is to be used from a higher instance or hirachy to actually draw everything on the screen 
//didn't cleaned up the comments so one can try and use them and check for the different looks   
  public void render() {
    //blendMode(DIFFERENCE);
    drawBG(); 
    //blendMode(SCREEN);
    //background(0); //sah auch goodie aus 
    lighting();
    terrain.update();
    terrain.display();
    showCollectables(); 
    psystem.run();
  }
}
