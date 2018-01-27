class PlanetSystem{
  float size;
  ArrayList<Planet> planets;
  
  PlanetSystem(){
    size=3162.0;
    planets=new ArrayList<Planet>();
  }
  
  void addPlanet(){
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
    System.out.println(planets.size());
    planets.add(new Planet(x,y,sized));
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
  color planetColor;
  
  Planet(float x, float y, float dia){
    position=new PVector(x,y);
    diameter=dia;
    glow=int(dia);
    planetColor=color(random(0,255),random(0,255),random(0,255));
  }
  
  void loadImage(){
    editablesurface.beginDraw();
    for(int ix=3;ix<11;ix++){
      editablesurface.noStroke();
      editablesurface.fill(255,255,255,fibonacci[ix]);
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