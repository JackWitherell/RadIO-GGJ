class RadioTower{
  
  class holder{
    PVector p;
    int frequency;
  }
  
  
  
  ArrayList<holder> frequencies = new ArrayList<holder>();
  int fudge;
  PVector position;
  boolean isNear(int frequency){
     for(int i = 0; i<frequencies.size(); i++){
       if (frequencies.get(i).frequency-fudge < frequency && frequency < frequencies.get(i).frequency+fudge){
         return true;
       }
     }
     return false;
  }
  PVector origin(int frequency){
    for(int i = 0; i<frequencies.size(); i++){
       if (frequencies.get(i).frequency-fudge < frequency && frequency < frequencies.get(i).frequency+fudge){
         return frequencies.get(i).p;
       }
     }
     return null;
  }
  void addFrequency(PVector p, int frequency){
    holder temp = new holder();
    temp.p = p;
    temp.frequency = frequency;
    frequencies.add(temp);
  }
}