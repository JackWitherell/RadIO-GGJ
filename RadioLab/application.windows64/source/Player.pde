
class Player{
  PVector position;
  PVector velocity;
  int planetID=-1;
  boolean onPlanet = false;
  int frequency = 45;
  char trapState='f';//f floating d debug t transmission
  RadioTower currentTower;
  int towerID;
  
  void setPlanet(int id){
    planetID=id;
    
  }
  
  void planetCollision(){
    for(int i=0; i<gazebo.getPlanetAmount();i++){
      if(sqrt(pow((position.x-gazebo.getPlanet(i).getPosition().x),2)+pow(position.y-gazebo.getPlanet(i).getPosition().y,2))<gazebo.getPlanet(i).getRadius()){
        setPlanet(i);
        trapState = gazebo.getPlanet(i).PlanetType;
        if(trapState == 't'){
          towerID = 0;
          currentTower = gazebo.getPlanet(i).radioTowers.get(towerID);
        }
        //System.out.println(i);
        break;
      }
    }
  }
  
  void escape(){
    switch(trapState){
      case 'd':
        if(keys [10]){
          velocity.set(
            map(mouseX,0,width,-1,1),
            map(mouseY,0,height,-1,1)
          );
          planetID=-1;
        }
        break;
      case 't':
        //println("frequency " + frequency);
        if(keys[0]&&frequency>0){
          frequency--;
          noiseAmp = 0;
        }
        else if(keys[1]&&frequency<100){
          frequency++;
          noiseAmp = 0;
        }
        else if(!currentTower.isNear(frequency)){
          noiseAmp = 0;
        }
        if(currentTower.isNear(frequency))
        {
          noiseAmp = 0;
        }
        if(key==' '&&currentTower.isNear(frequency)){
            position.set(currentTower.origin(frequency));
            trapState = 'f';
            planetID=-1;
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
      planetCollision();
      if(planetID==-1){
        onPlanet = false;
      }
      else{
        onPlanet = true;
      }
    }
    else{
      if(trapState=='d'){
        position.set(lerp(gazebo.getPlanet(planetID).getPosition().x,position.x,.96),lerp(gazebo.getPlanet(planetID).getPosition().y,position.y,.96));
      }
      else if(trapState=='t'){
        if(lastKeyPressed == 'a'){
          towerID--;
          if(towerID<0)towerID = gazebo.getPlanet(planetID).radioTowers.size()-1;
          currentTower = gazebo.getPlanet(planetID).radioTowers.get(towerID);
        }
        if(lastKeyPressed == 'd'){
          towerID++;
          if(towerID>=gazebo.getPlanet(planetID).radioTowers.size())towerID = 0;
          currentTower = gazebo.getPlanet(planetID).radioTowers.get(towerID);
        }
        position.set(currentTower.position);
      }
      escape();
    }
  }
  void drawPlayer(){
    if(offset==66666){
      velocity.set(0,0);
    }
    playerUpdate();
    stroke(255);
    fill(0);
    pushMatrix();
    translate(position.x-3,position.y-3);
    rotateX(.011*frameCount);
    //translate(offset,0,0);
    box(5+offset);
    rotateY(.024*frameCount);
    //translate(0,0,offset);
    box(5+offset);
    rotateZ(.038*frameCount);
    //translate(0,offset,0);
    box(5+offset);
    popMatrix();
  }
}