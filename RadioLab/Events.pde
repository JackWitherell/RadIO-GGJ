void keyPressed(){
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
}

void keyReleased(){
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

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  e=-e;
  zoom+=(e*(60));
  if(zoom>495){
    zoom=495;
  }
  if(zoom<-4979){
    zoom=-4979;
  }
    println(zoom);
}