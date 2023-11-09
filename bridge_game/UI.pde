/* The ui class which should handles every visual output besides of the gameplay, usually referred as HUD */
/* it was only begun and not finished */
/* *I wanted to move everything to this class which is ui related /
/* Paul Donner */


class UI {
  int score = 0 ; //stores the score value
  float distance = 0.0; //stores the distance value
  //maybe status enum again
  public UI() {
  }
  //draw the end of the player cursor
  public void drawCursor(float x, float y) {
    push();
    fill(200, 100);
    circle(x, y, 10);
    fill(200, 15, 70, 85);
    circle(x, y, 12);
    pop();
  }
  //draws the score and the distance to the screen
  public void gameScreen() {
    push();
    strokeWeight(0.5);
    fill(245,17,30,20);
    rect(40-6,24*2-6,100,24*2,12,12,12,12);
    String score = "Score: " + this.score;
    fill(255, 255);
    textSize(24);
    text(score, 40, 24*2, 280, 320);  // Text wraps within text box
    pop();
    push();
    noStroke();
    fill(180, 100);
    rect(100, height, 280, 320);
    String distance = "Distance: "+this.distance;
    fill(15, 255);
    textSize(24);
    text(distance, 40, height-24*2, 280, 320);  // Text wraps within text box
    pop();
  }
  //should do the menu
  public void menuScreen() {
  }
  //shoud do the gameOver
  public void gameOverScreen() {
  }
}
