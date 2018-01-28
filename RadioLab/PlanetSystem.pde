class PlanetSystem{
  float size;
  ArrayList<Planet> planets;
  
  PlanetSystem(){
    size=3162.0;
    planets=new ArrayList<Planet>();
  }
  
  Planet addPlanet(){
    boolean done=false;
    float x=0.0;
    float y=0.0;
    
    float sized=0.0;
    while(!done){
      x=random(0.0,size);
      y=random(0.0,size);
    
      sized=30+random(-5.0,15.0);
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
  
  int getPlanetAmount(){
    return planets.size();
  }
  
  Planet getPlanet(int i){
    return planets.get(i);
  }
  
  void drawPlanets(){
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
  
  RadioTower addRadioTower(float angle, int fudge){
    RadioTower temp = new RadioTower();
    temp.fudge = fudge;
    temp.position = new PVector(position.x + cos(angle) * this.getRadius(), position.y + sin(angle)*this.getRadius());
    radioTowers.add(temp);
    return temp;
  }
  
  color planetColor;
  float pr,pb,pg;
  
  void glowSetColor(float r, float g, float b){
    pr=r;
    pb=b;
    pg=g;
  }
  void setColor(float r, float g, float b){
    planetColor=color(r,g,b);
  }
  
  Planet(float x, float y, float dia){
    position=new PVector(x,y);
    diameter=dia;
    glow=int(dia);
    planetColor=color(random(0,255),random(0,255),random(0,255));
    pr=red(planetColor);
    pg=green(planetColor);
    pb=blue(planetColor);
  }
  
  void loadImage(){
    editablesurface.beginDraw();
    for(int ix=3;ix<11;ix++){
      editablesurface.noStroke();
      editablesurface.fill(pr,pb,pg,fibonacci[ix]);
      editablesurface.ellipse(50,50,diameter+(glow*(float(11-ix)/11)),diameter+(glow*(float(11-ix)/11)));
    }

    editablesurface.fill(planetColor);
    editablesurface.ellipse(50,50,diameter,diameter);
    planetImage=editablesurface.get(0,0,100,100);
    editablesurface.endDraw();
    editablesurface=createGraphics(100,100);
  }
  
  private float getRadius(){return diameter/2;}
  private float getDiameter(){return diameter;}
  PVector getPosition(){return position;}
  
  void drawPlanet(){
    if(planetImage==null){
      loadImage();
    }
    image(planetImage,position.x-50,position.y-50);
    //ellipse(int(position.x),int(position.y),diameter,diameter);
    noStroke();
    //rect(int(position.x),int(position.y),10,10);
  }
}