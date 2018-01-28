import processing.sound.*;        //Sound engine
char oldkey = 0;                  //Keeps lasts key pressed (Used in Player)
WhiteNoise noise;                 //Noise generation object
PlanetSystem gazebo;              //PlanetSystem
Player osiris;                    //Player
float noiseAmp = 0;               //Noise Amplitude (controls volume on noise)
PGraphics editablesurface;        //Editable surface for drawing graphics
int[] fibonacci;                  //Fibonacci scale (first 11 numbers

int x=0;                          //X offset for Camera Mode
int y=0;                          //Y offset for Camera Mode
int minSpeed = 1;                 //Zoom Speed
int maxSpeed =20;                 //Zoom speed max cap
int score=500;                    //Score for Score Counter

int cameraM=1;                    //Cameramode (1 is player camera)
float zoom=1;                     //Current zoom value (range 500, -5000
boolean [] keys=new boolean[11];  //Holds keys right, left up down 1, 2, w, a, s, d, space

void setup(){
  size(800,640,P3D);              //Size and 3D mode
  gazebo=new PlanetSystem();      //Define planet system
  
  Planet PlanetD = gazebo.addPlanet();   //Example of a D planet
  Planet PlanetT = gazebo.addPlanet();   //Example of a T planet
  PlanetD.position = new PVector(0,50);  //Setting the location
  PlanetT.position = new PVector(100,0); //Setting the location
  PlanetT.PlanetType = 't';              //setting planet type
  
  RadioTower redHerring = PlanetT.addRadioTower(2f,10);  //new Radio Tower on right side of planet (two radians, how wide it searches)
  RadioTower sender = PlanetT.addRadioTower(1f,10);      //
  redHerring.addFrequency(PlanetT.position, 50);         //Sets the location of planetT as a frequency
  sender.addFrequency(PlanetD.position, 50);             //Sets the location of planetD as a frequency
  
  
  /*
  for(int i=0;i<80;i++){                                //Old random generation code
    gazebo.addPlanet();
  }
  */
  
  
  osiris=new Player();                     //New player
  osiris.velocity.x =0;                    //set velocity to nun
  osiris.velocity.y =0;                    //set velocity to non
  editablesurface=createGraphics(100,100); //create editable surface for drawing planets
  fibonacci= new int[11];                  //set fibonacci sequence
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
  textAlign(LEFT,TOP);                     //Align text to be under and to the right of the loc
  noise = new WhiteNoise(this);            //New whitenoise object
  noise.amp(0);                            //start playing no volume
  noise.play();
}

void draw(){
  if(oldkey==lastKeyPressed){              //set old key
    lastKeyPressed = 0;
  }
  oldkey = lastKeyPressed;                 //final set old key
  
  noise.amp(noiseAmp);                     //handle noise
  lerp(noiseAmp,0,0.1);                    //tone it down
  
  background(frameCount/20,0,0);           //set background to increasing red
  score+=osiris.planetID==-1?-1:5;         //add to score if on planet otherwise subtract
  if(score>600){                           //limit max score to 600
    score=600;
  }
  switch(cameraM){                         //camera switch
    case 0:                                //if mode 0, freecam
      translate(x,y,zoom);
      break;
    case 1:                                //if mode 1, playercam
      translate((width/2)-osiris.getPlayerLocation().x, (height/2)-osiris.getPlayerLocation().y,zoom);
      break;
    default:
      break;
  }
  gazebo.drawPlanets();                    //draw all planets
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