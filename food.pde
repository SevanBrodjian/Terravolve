class food {
  int x;
  int y;
  boolean show;
  
  public food(){
    this.x=0;
    this.y=0;
    this.show=false;
  }
  
  public void draw(){
    fill(0);
    noStroke();
    if(this.show){
      ellipse(this.x, this.y, fsize, fsize);
    }
  }
}