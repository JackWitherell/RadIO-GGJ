PlanetSystem gazebo;
Player osiris;
PGraphics editablesurface;
int[] fibonacci;
int score=500;
int x=0;
int y=0;
int minSpeed = 1;
int maxSpeed =20;

int cameraM=1;
float zoom=1;
boolean [] keys=new boolean[11];

void setup(){
  size(800,640,P3D);
  gazebo=new PlanetSystem();
  for(int i=0;i<80;i++){
    gazebo.addPlanet();
  }
  osiris=new Player();
  osiris.velocity.x =1;
  osiris.velocity.y =1;
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
  textAlign(LEFT,TOP);
}

void draw(){
  background(frameCount/20,0,0);
  score+=osiris.planetID==-1?-1:5;
  if(score>600){
    score=600;
  }
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
  gazebo.drawPlanets();
  scale(10);
  stroke(255);
  fill(0);
  rect(osiris.getPlayerLocation().x-map(zoom,495,-5000,42,3890),
       osiris.getPlayerLocation().y-map(zoom,495,-5000,34,3150),
       map(zoom,-4979,500,1000,10)*4.9,
       map(zoom,-4979,500,1000,10));
  fill(255);
  textSize(map(zoom,-4979,500,750,7));
  text("health: "+Integer.toString(score),osiris.getPlayerLocation().x-map(zoom,495,-5000,42,3890),osiris.getPlayerLocation().y-map(zoom,495,-5000,34,3150));
  if(keys[0]){x-=map(zoom,500,-500,minSpeed,maxSpeed);}
  if(keys[1]){x+=map(zoom,500,-500,minSpeed,maxSpeed);}
  if(keys[2]){y+=map(zoom,500,-500,minSpeed,maxSpeed);}
  if(keys[3]){y-=map(zoom,500,-500,minSpeed,maxSpeed);}
  if(keys[4]){cameraM=0;}
  if(keys[5]){cameraM=1;}
  if(keys[6]){osiris.velYadd(-.25);}
  if(keys[7]){osiris.velXadd(-.25);}
  if(keys[8]){osiris.velYadd(.25);}
  if(keys[9]){osiris.velXadd(.25);}
  //scaletwo(4);
  strokeWeight(7);
  osiris.drawPlayer();
  strokeWeight(1);
}