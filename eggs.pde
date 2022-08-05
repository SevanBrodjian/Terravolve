class egg {
  int age;
  float sight;
  int mut;
  float maxhp;
  float x;
  float y;
  float dir;
  float speed;
  boolean alive;
  boolean sel;
  float le;
  int birth;
  float waver;
  float br;
  int eggtime;
  int hatch;
  int when;
  float dig;

  public egg() {
    this.dig=1;
    this.br=10;
    this.waver=16;
    this.birth=0;
    this.le=10;
    this.sel=false;
    this.alive=false;
    this.speed=1;
    this.dir=0;
    this.x=0;
    this.y=0;
    this.maxhp=100;
    this.mut=0;
    this.sight=100;
    this.mut=0;
    this.hatch=0;
    this.when=round(this.le/(this.br*2)+random(0, 2));
  }

  void draw() {
    if (this.alive) {
      this.age=years-this.birth;
      fill(216, 255, 0);
      stroke(0);
      strokeWeight(2.5);
      ellipse(this.x, this.y, hsize/2, hsize/2);
      if (this.age==this.hatch) {
        boolean open=false;
        int newh=0;
        for (int i=0; i<hmax; i++) {
          if (h[i].alive==false && !open) {
            newh=i;
            open=true;
          }
        }
        if (open) {
          //MUTATE
          this.alive=false;

          h[newh].dig=this.dig;
          h[newh].br=this.br;
          h[newh].waver=this.waver;
          h[newh].le=this.le;
          h[newh].speed=this.speed;
          h[newh].maxhp=this.maxhp;
          h[newh].sight=this.sight;
          h[newh].eggtime=this.eggtime;



          int mutate=round(random(-0.49, 7.49));
          float mutsig;
          if (this.mut>0) {
            mutsig=0.75*mutationRateh+mutationRateh/(this.mut);
          } else {
            mutsig=1;
          }
          if (mutate==0) {
            h[newh].waver=this.waver+mutate(1, mutsig);
            h[newh].recm="waver";
          }
          if (mutate==1) {
            h[newh].le=this.le+mutate(3, mutsig);
            h[newh].recm="le";
          }
          if (mutate==2) {
            h[newh].speed=this.speed+mutate(.5, mutsig);
            h[newh].recm="speed";
          }
          if (mutate==3) {
            h[newh].maxhp=this.maxhp+mutate(25, mutsig);
            h[newh].recm="maxhp";
          }
          if (mutate==4) {
            h[newh].sight=this.sight+mutate(7.5, mutsig);
            h[newh].recm="sight";
          }
          if (mutate==5) {
            h[newh].br=this.br+(mutate(0.25, mutsig));
            h[newh].recm="br";
          }
          if (mutate==6) {
            h[newh].dig=this.dig+(mutate(0.05, mutsig));
            h[newh].recm="dig";
          }
          if (mutate==7) {
            h[newh].eggtime=this.eggtime+round(mutate(1.75, mutsig));
            h[newh].recm="EggTime";
          }

          if (h[newh].sight<0) {
            h[newh].sight=-c[newh].sight;
          }
          if (h[newh].br<1) {
            h[newh].br=1;
          }
          if (h[newh].waver<0) {
            h[newh].waver=-c[newh].waver;
          }
          if (h[newh].maxhp<10) {
            h[newh].maxhp=10;
          }
          if (h[newh].le<3) {
            h[newh].le=3;
          }
          if (h[newh].speed<0.1) {
            h[newh].speed=0.1;
          }
          if (h[newh].dig<1) {
            h[newh].dig=1;
          }
          if (h[newh].eggtime<1) {
            h[newh].eggtime=1;
          }

          h[newh].alive=true;
          h[newh].birth=years;
          h[newh].x=this.x;
          h[newh].y=this.y;
          h[newh].mut=this.mut+1;
          h[newh].hp=h[newh].maxhp;
          h[newh].life=round(this.le+random(-this.le/5, this.le/3));
          h[newh].when=round(this.le/(this.br*1.5)+random(0, 2));
          if (h[newh].when<1) {
            h[newh].when=1;
          }
          h[newh].count=h[newh].when;
        } else {
          this.hatch++;
        }
      }
    }
  }
}