class Player{
  PVector position;
  PVector velocity;
  
  Player(){
    position=new PVector(30,0);
    velocity= new PVector(0,0);
  }
  
  PVector getPlayerLocation(){
    return(position);
  }
  void playerUpdate(){
    position.add(velocity);
  }
  void drawPlayer(){
    playerUpdate();
    stroke(255);
    fill(0);
    rect(position.x-3,position.y-3,3,5);
    rect(position.x+1,position.y-3,3,5);
  }
}