class Player{
  PVector position;
  PVector velocity;
  int planetID=-1;
  boolean onPlanet = false;
  float frequency = 0;
  char trapState='f';//f floating d debug t transmission
  
  void setPlanet(int id){
    planetID=id;
    
  }
  
  void planetCollision(){
    for(int i=0; i<gazebo.getPlanetAmount();i++){
      if(sqrt(pow((position.x-gazebo.getPlanet(i).getPosition().x),2)+pow(position.y-gazebo.getPlanet(i).getPosition().y,2))<gazebo.getPlanet(i).getRadius()){
        setPlanet(i);
        //System.out.println(i);
        break;
      }
    }
  }
  
  void escape(){
    switch(trapState){
      case 'd':
        if(keys [10]){
          println("escape ");
          println(trapState);
          velocity.set(
            map(mouseX,0,width,-1,1),
            map(mouseY,0,height,-1,1)
          );
          planetID=-1;
        }
        break;
      case 't':
        if(keys[7]){
          
        }
        if(keys[9]){
        }
      default:
        break;
    }
  }
  
  void velXadd(float abb){
    velocity.x+=abb;
  }
  void velYadd(float abb){
    velocity.y+=abb;
  }
  
  Player(){
    position=new PVector(30,0);
    velocity= new PVector(0,0);
  }
  
  PVector getPlayerLocation(){
    return(position);
  }
  void playerUpdate(){
    if(planetID==-1){
      position.add(velocity);
      trapState = 'f';
      planetCollision();
      if(planetID==-1){
        onPlanet = false;
      }
      else{
        onPlanet = true;
      }
    }
    else{
      trapState = 'd';
      position.set(lerp(gazebo.getPlanet(planetID).getPosition().x,position.x,.96),lerp(gazebo.getPlanet(planetID).getPosition().y,position.y,.96));
      escape();
    }
  }
  void drawPlayer(){
    playerUpdate();
    stroke(255);
    fill(0);
    rect(position.x-3,position.y-3,3,5);
    rect(position.x+1,position.y-3,3,5);
  }
}