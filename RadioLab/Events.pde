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
  else if(key=='3'){
    keys[6]=true;
  }
  else if(key=='4'){
    keys[7]=true;
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
  else if(keyCode=='1'){
    keys[4]=false;
  }
  else if(keyCode=='2'){
    keys[5]=false;
  }
  else if(keyCode=='3'){
    keys[6]=false;
  }
  else if(keyCode=='4'){
    keys[7]=false;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  e=-e;
  zoom+=(e*10);
  if(zoom>495){
    zoom=495;
  }
    println(zoom);
}