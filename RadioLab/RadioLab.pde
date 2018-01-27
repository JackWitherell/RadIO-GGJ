PlanetSystem gazebo;
Player osiris;
PGraphics editablesurface;
int[] fibonacci;

int x=0;
int y=0;

int cameraM=1;
float zoom=1;
boolean [] keys=new boolean[8];

void setup(){
  size(800,640,P3D);
  gazebo=new PlanetSystem();
  for(int i=0;i<80;i++){
    gazebo.addPlanet();
  }
  osiris=new Player();
  editablesurface=createGraphics(100,100);
  fibonacci= new int[11];
  fibonacci[0]= 1;
  fibonacci[1]= 2;
  fibonacci[2]= 3;
  fibonacci[3]= 5;
  fibonacci[4]= 8;
  fibonacci[5]= 13;
  fibonacci[6]= 21;
  fibonacci[7]= 34;
  fibonacci[8]= 55;
  fibonacci[9]= 89;
  fibonacci[10]= 113;
}

void draw(){
  background(0);
  switch(cameraM){
    case 0:
      translate(x,y,zoom);
      break;
    case 1:
      translate((width/2)-osiris.getPlayerLocation().x, (height/2)-osiris.getPlayerLocation().y,zoom);
      break;
    default:
      break;
  }
  if(keys[0]){x--;}
  if(keys[1]){x++;}
  if(keys[2]){y++;}
  if(keys[3]){y--;}
  if(keys[4]){cameraM=0;}
  if(keys[5]){cameraM=1;}
  gazebo.drawPlanets();
  //scaletwo(4);
  
  scale(10);
  strokeWeight(7);
  osiris.drawPlayer();
  strokeWeight(1);
}

class Player{
  PVector position;
  
  Player(){
    position=new PVector(30,0);
  }
  
  PVector getPlayerLocation(){
    return(position);
  }
  
  void drawPlayer(){
    stroke(255);
    fill(0);
    rect(position.x-3,position.y-3,3,5);
    rect(position.x+1,position.y-3,3,5);
  }
}