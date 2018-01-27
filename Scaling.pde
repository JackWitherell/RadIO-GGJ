void scaletwo(int scale){
  loadPixels();
  for(int x=width-1; x>-1; x--){
    for(int y=height-1; y>-1; y--){
      pixels[x+(y*(width))]=pixels[int(x/scale)+int(int(y/scale)*width)];
    }
  }
  updatePixels();
}

void scale(int scale){
  loadPixels();
  for(int x=0; x<width; x=x+scale){
    for(int y=0; y<height; y=y+scale){
      color topLeft=pixels[x+(y*width)];
      for(int i=0;i<scale;i++){
        for(int iy=0;iy<scale;iy++){
          pixels[i+x+((y+iy)*width)]=topLeft;
        }
      }
    }
  }
  updatePixels();
}