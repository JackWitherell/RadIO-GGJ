import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class RadioLab extends PApplet {

        //Sound engine
SoundFile music;
char oldkey = 0;                  //Keeps lasts key pressed (Used in Player)
char lastKeyPressed = 0;
WhiteNoise noise;                 //Noise generation object
PlanetSystem gazebo;              //PlanetSystem
Player osiris;                    //Player
float noiseAmp = 0;               //Noise Amplitude (controls volume on noise)
PGraphics editablesurface;        //Editable surface for drawing graphics
int[] fibonacci;                  //Fibonacci scale (first 11 numbers
int offset=0;

int x=0;                          //X offset for Camera Mode
int y=0;                          //Y offset for Camera Mode
int minSpeed = 1;                 //Zoom Speed
int maxSpeed =20;                 //Zoom speed max cap
int score=500;                    //Score for Score Counter

int cameraM=1;                    //Cameramode (1 is player camera)
float zoom=1;                     //Current zoom value (range 500, -5000
boolean [] keys=new boolean[11];  //Holds keys right, left up down 1, 2, w, a, s, d, space

public void setup(){
                //Size and 3D mode
  gazebo=new PlanetSystem();      //Define planet system
  
  music = new SoundFile(this, "music.mp3");
  music.play();
  Planet PlanetD = gazebo.addPlanet();
  Planet PlanetT = gazebo.addPlanet();
  Planet goal=new Planet(3000.0f,3000.0f,50.0f,30);
  goal.setColor(255,255,50);
  gazebo.addPlanet(goal);
  PlanetD.position = new PVector(0,50);
  PlanetT.position = new PVector(100,0);
  PlanetT.PlanetType = 't';
  
  RadioTower redHerring = PlanetT.addRadioTower(2f,10);  //new Radio Tower on right side of planet (two radians, how wide it searches)
  RadioTower sender = PlanetT.addRadioTower(1f,10);      //
  redHerring.addFrequency(PlanetT.position, 50);         //Sets the location of planetT as a frequency
  sender.addFrequency(PlanetD.position, 50);             //Sets the location of planetD as a frequency
  
  
  
  for(int i=0;i<80;i++){                                //Old random generation code
    gazebo.addPlanet();
  }
  
  
  
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

public void draw(){
  if(oldkey==lastKeyPressed){              //set old key
    lastKeyPressed = 0;
  }
  oldkey = lastKeyPressed;                 //final set old key
  
  noise.amp(noiseAmp);                     //handle noise
  lerp(noiseAmp,0,0.1f);                    //tone it down
  
  background(frameCount/20,0,0);           //set background to increasing red
  score+=osiris.planetID==-1?-1:5;         //add to score if on planet otherwise subtract
  if(score>200){                           //limit max score to 600
    score=200;
  }
  if(score<0){
    offset++;
    offset*=2;
    if(offset>66666){
      offset=66666;
    }
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
  scale(10);                               //scale everything up by 10;
  stroke(255);
  fill(0);
  rect(osiris.getPlayerLocation().x-map(zoom,495,-5000,42,3890), //draw UI
       osiris.getPlayerLocation().y-map(zoom,495,-5000,34,3150),
       map(zoom,-4979,500,1000,10)*4.9f,
       map(zoom,-4979,500,1000,10));
  fill(255);
  textSize(map(zoom,-4979,500,750,7));                           
  text("health: "+Integer.toString(score),
       osiris.getPlayerLocation().x-map(zoom,495,-5000,42,3890),
       osiris.getPlayerLocation().y-map(zoom,495,-5000,34,3150));//draw text for score
  if(keys[0]){x-=map(zoom,500,-500,minSpeed,maxSpeed);}//move camera offset
  if(keys[1]){x+=map(zoom,500,-500,minSpeed,maxSpeed);}//move camera offset
  if(keys[2]){y+=map(zoom,500,-500,minSpeed,maxSpeed);}//move camera offset
  if(keys[3]){y-=map(zoom,500,-500,minSpeed,maxSpeed);}//move camera offset
  if(keys[4]){cameraM=0;}
  if(keys[5]){cameraM=1;}
  if(keys[6]){osiris.velYadd(-.25f);}                   //add velocity from keys
  if(keys[7]){osiris.velXadd(-.25f);}
  if(keys[8]){osiris.velYadd(.25f);}
  if(keys[9]){osiris.velXadd(.25f);}
  strokeWeight(7);
  osiris.drawPlayer(); //draw player
  strokeWeight(1);
}
public void keyPressed(){
  if(keyCode==RIGHT){
    keys[0]=true;
  }
  else if(keyCode==LEFT){
    keys[1]=true;
  }
  else if(keyCode==UP){
    keys[2]=true;
  }
  else if(keyCode==DOWN){
    keys[3]=true;
  }
  else if(key=='1'){
    keys[4]=true;
  }
  else if(key=='2'){
    keys[5]=true;
  }
  else if(key=='w'){
    keys[6]=true;
  }
  else if(key=='a'){
    keys[7]=true;
  }
  else if(key=='s'){
    keys[8]=true;
  }
  else if(key=='d'){
    keys[9]=true;
  }
  else if(key==' '){
    keys[10]=true;
  }
  lastKeyPressed = key;
}

public void keyReleased(){
  if(keyCode==RIGHT){
    keys[0]=false;
  }
  else if(keyCode==LEFT){
    keys[1]=false;
  }
  else if(keyCode==UP){
    keys[2]=false;
  }
  else if(keyCode==DOWN){
    keys[3]=false;
  }
  else if(key=='1'){
    keys[4]=false;
  }
  else if(key=='2'){
    keys[5]=false;
  }
  else if(key=='w'){
    keys[6]=false;
  }
  else if(key=='a'){
    keys[7]=false;
  }
  else if(key=='s'){
    keys[8]=false;
  }
  else if(key=='d'){
    keys[9]=false;
  }
  else if(key==' '){
    keys[10]=false;
  }
}


public void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  e=-e;
  zoom+=(e*(60));
  if(zoom>495){
    zoom=495;
  }
  if(zoom<-4979){
    zoom=-4979;
  }
}
class PlanetSystem{
  float size;
  ArrayList<Planet> planets;
  
  PlanetSystem(){
    size=3162.0f;
    planets=new ArrayList<Planet>();
  }
  public void addPlanet(Planet pluto){
    planets.add(pluto);
  }
  
  public Planet addPlanet(){
    boolean done=false;
    float x=0.0f;
    float y=0.0f;
    
    float sized=0.0f;
    while(!done){
      x=random(0.0f,size);
      y=random(0.0f,size);
    
      sized=30+random(-5.0f,15.0f);
      done=true;
      for(int i=0;i<planets.size();i++){
        if(sqrt( pow((x-planets.get(i).getPosition().x),2)   +pow((y-planets.get(i).getPosition().y),2)
           ) <(planets.get(i).getRadius()+(sized/2))){
           done=false;
        }
      }
    }
    Planet temp = new Planet(x,y,sized);
    planets.add(temp);
    return temp;
  }
  
  public int getPlanetAmount(){
    return planets.size();
  }
  
  public Planet getPlanet(int i){
    return planets.get(i);
  }
  
  public void drawPlanets(){
    for(int i= 0; i<planets.size(); i++){
      planets.get(i).drawPlanet();
    }
  }
}

class Planet{
  PVector position;
  float diameter;
  PImage planetImage;
  int glow;
  char PlanetType = 'd';
  ArrayList<RadioTower> radioTowers = new ArrayList<RadioTower>();
  
  public RadioTower addRadioTower(float angle, int fudge){
    RadioTower temp = new RadioTower();
    temp.fudge = fudge;
    temp.position = new PVector(position.x + cos(angle) * this.getRadius(), position.y + sin(angle)*this.getRadius());
    radioTowers.add(temp);
    return temp;
  }
  
  int planetColor;
  float pr,pb,pg;
  
  public void glowSetColor(float r, float g, float b){
    pr=r;
    pb=b;
    pg=g;
  }
  public void setColor(float r, float g, float b){
    planetColor=color(r,g,b);
  }
  
  Planet(float x, float y, float dia, int bglow){
    position=new PVector(x,y);
    diameter=dia;
    glow=bglow;
    planetColor=color(random(0,255),random(0,255),random(0,255));
    pr=red(planetColor);
    pg=green(planetColor);
    pb=blue(planetColor);
  }
  Planet(float x, float y, float dia){
    position=new PVector(x,y);
    diameter=dia;
    glow=PApplet.parseInt(dia);
    planetColor=color(random(0,255),random(0,255),random(0,255));
    pr=red(planetColor);
    pg=green(planetColor);
    pb=blue(planetColor);
  }
  
  public void loadImage(){
    editablesurface.beginDraw();
    for(int ix=3;ix<11;ix++){
      editablesurface.noStroke();
      editablesurface.fill(pr,pb,pg,fibonacci[ix]);
      editablesurface.ellipse(50,50,diameter+(glow*(PApplet.parseFloat(11-ix)/11)),diameter+(glow*(PApplet.parseFloat(11-ix)/11)));
    }

    editablesurface.fill(planetColor);
    editablesurface.ellipse(50,50,diameter,diameter);
    planetImage=editablesurface.get(0,0,100,100);
    editablesurface.endDraw();
    editablesurface=createGraphics(100,100);
  }
  
  private float getRadius(){return diameter/2;}
  private float getDiameter(){return diameter;}
  public PVector getPosition(){return position;}
  
  public void drawPlanet(){
    if(planetImage==null){
      loadImage();
    }
    image(planetImage,position.x-50,position.y-50);
    //ellipse(int(position.x),int(position.y),diameter,diameter);
    noStroke();
    //rect(int(position.x),int(position.y),10,10);
  }
}

class Player{
  PVector position;
  PVector velocity;
  int planetID=-1;
  boolean onPlanet = false;
  int frequency = 45;
  char trapState='f';//f floating d debug t transmission
  RadioTower currentTower;
  int towerID;
  
  public void setPlanet(int id){
    planetID=id;
    
  }
  
  public void planetCollision(){
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
  
  public void escape(){
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
  
  public void velXadd(float abb){
    velocity.x+=abb;
  }
  public void velYadd(float abb){
    velocity.y+=abb;
  }
  
  Player(){
    position=new PVector(30,0);
    velocity= new PVector(0,0);
  }
  
  public PVector getPlayerLocation(){
    return(position);
  }
  public void playerUpdate(){
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
        position.set(lerp(gazebo.getPlanet(planetID).getPosition().x,position.x,.96f),lerp(gazebo.getPlanet(planetID).getPosition().y,position.y,.96f));
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
  public void drawPlayer(){
    if(offset==66666){
      velocity.set(0,0);
    }
    playerUpdate();
    stroke(255);
    fill(0);
    pushMatrix();
    translate(position.x-3,position.y-3);
    rotateX(.011f*frameCount);
    //translate(offset,0,0);
    box(5+offset);
    rotateY(.024f*frameCount);
    //translate(0,0,offset);
    box(5+offset);
    rotateZ(.038f*frameCount);
    //translate(0,offset,0);
    box(5+offset);
    popMatrix();
  }
}
class RadioTower{
  
  class holder{
    PVector p;
    int frequency;
  }
  
  
  
  ArrayList<holder> frequencies = new ArrayList<holder>();
  int fudge;
  PVector position;
  public boolean isNear(int frequency){
     for(int i = 0; i<frequencies.size(); i++){
       if (frequencies.get(i).frequency-fudge < frequency && frequency < frequencies.get(i).frequency+fudge){
         return true;
       }
     }
     return false;
  }
  public PVector origin(int frequency){
    for(int i = 0; i<frequencies.size(); i++){
       if (frequencies.get(i).frequency-fudge < frequency && frequency < frequencies.get(i).frequency+fudge){
         return frequencies.get(i).p;
       }
     }
     return null;
  }
  public void addFrequency(PVector p, int frequency){
    holder temp = new holder();
    temp.p = p;
    temp.frequency = frequency;
    frequencies.add(temp);
  }
}
public void scaletwo(int scale){
  loadPixels();
  for(int x=width-1; x>-1; x--){
    for(int y=height-1; y>-1; y--){
      pixels[x+(y*(width))]=pixels[PApplet.parseInt(x/scale)+PApplet.parseInt(PApplet.parseInt(y/scale)*width)];
    }
  }
  updatePixels();
}

public void scale(int scale){
  loadPixels();
  for(int x=0; x<width; x=x+scale){
    for(int y=0; y<height; y=y+scale){
      int topLeft=pixels[x+(y*width)];
      for(int i=0;i<scale;i++){
        for(int iy=0;iy<scale;iy++){
          pixels[i+x+((y+iy)*width)]=topLeft;
        }
      }
    }
  }
  updatePixels();
}
  public void settings() {  size(1200,640,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "RadioLab" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
