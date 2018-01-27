PlanetSystem gazebo;
PGraphics editablesurface;
int[] fibonacci;

int x=0;
int y=0;
float zoom=1;
boolean [] keys=new boolean[4];

void setup(){
  size(800,640,P3D);
  gazebo=new PlanetSystem();
  for(int i=0;i<80;i++){
    gazebo.addPlanet();
  }
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
  translate(x,y,zoom);
  if(keys[0]){x--;}
  if(keys[1]){x++;}
  if(keys[2]){y++;}
  if(keys[3]){y--;}
  gazebo.drawPlanets();
  //scaletwo(4);
  scale(10);
}