class carnivore {
  int age;
  float sight;
  int mut;
  float hp;
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
  int life;
  int when;
  int count;
  String recm;
  float dig;

  public carnivore() {
    this.br=1;
    this.waver=4;
    this.le=10;
    this.birth=0;
    this.sel=false;
    this.alive=false;
    this.speed=0.4;
    this.dir=0;
    this.x=width/2;
    this.y=height/2;
    this.hp=100;
    this.maxhp=100;
    this.mut=0;
    this.sight=0;
    this.mut=0;
    this.life=round(this.le+random(-this.le/5, this.le/3));
    this.when=round(this.le/(this.br*2)+random(0, 2));
    this.count=this.when;
    this.recm="n/a";
    this.dig=1;
  }

  public void draw() {
    if (this.alive==true) {
      this.hp-=0.0375*acc/this.dig;
      this.age=years-this.birth;
      if(this.le<15){
        fill(250, 25, 25);
      } else {
        fill(220, 0, 0);
      }
      stroke(0);
      strokeWeight(0.5);
      ellipse(this.x, this.y, csize, csize);
      if (this.sel) {
        noFill();
        stroke(50, 90, 100);
        strokeWeight(3);
        ellipse(this.x, this.y, csize, csize);
        stroke(0);
        strokeWeight(1);
        if(this.sight>0){
          ellipse(this.x, this.y, this.sight+csize, this.sight+csize);
        }
      }
      if (this.hp<=0) {
        this.alive=false;
        starve++;
      }
      if(this.age==this.life){
        this.alive=false;
        oldage++;
      }
      if (this.hp>this.maxhp) {
        this.hp=this.maxhp;
      }
    }
  }

  public void hover() {
    if (this.sel) {
      for (int i=0; i<hmax; i++) {
        h[i].sel=false;
      }
      for (int i=0; i<cmax; i++) {
        c[i].sel=false;
      }
      this.sel=true;
    }
    if (this.alive && mouseX>this.x-csize*2 && mouseX<this.x+csize*2 && mouseY>this.y-csize*2 && mouseY<this.y+csize*2) {
      hover1=true;
      if (mousePressed) {
        select=true;
        for (int i=0; i<hmax; i++) {
          h[i].sel=false;
        }
        for (int i=0; i<cmax; i++) {
          c[i].sel=false;
        }
        this.sel=true;
      }
    }
  }

  public void bump() {
    if (this.alive) {
      if (this.x<csize/2) {
        this.dir=270+random(-10, 10);
        this.x=csize/2;
      }
      if (this.x>width-csize/2) {
        this.dir=90+random(-10, 10);
        this.x=width-csize/2;
      }
      if (this.y<csize/2) {
        this.dir=0+random(-10, 10);
        this.y=csize/2;
      }
      if (this.y>height-csize/2) {
        this.dir=180+random(-10, 10);
        this.y=height-csize/2;
      }
    }
  }

  public void turn() {
    if (this.alive) {
      float closef=this.sight+csize;
      int cv=-1;
      int cc=-1;
      int cf=-1;
      boolean e=false;
      boolean sight=false;
      boolean f=false;

      for (int i=0; i<fmax; i++) {
        if (food[i].show && dist(food[i].x, food[i].y, this.x, this.y)<csize/2+fsize/2) {
          food[i].show=false;
          this.hp+=5*cfoodworth;
        }
      }
      for (int i=0; i<hmax; i++) {
        if (h[i].alive && dist(h[i].x, h[i].y, this.x, this.y)<hsize/2+csize/2) {
          h[i].hp-=h[i].maxhp/3;
          if(h[i].hp<0){
            h[i].alive=false;
            eaten++;
          }
          this.hp+=25*cfoodworth;
        }
      }
      for (int i=0; i<emax; i++) {
        if (egg[i].alive && dist(egg[i].x, egg[i].y, this.x, this.y)<hsize/4+csize/2 && eategg) {
          egg[i].alive=false;
          eaten++;
          this.hp+=15*cfoodworth;
        }
      }
      for (int i=0; i<fmax; i++) {
        if (food[i].show && dist(food[i].x, food[i].y, this.x, this.y)<closef && this.hp<0.7*this.maxhp) {
          if (dist(food[i].x, food[i].y, this.x, this.y)<hsize/2+fsize/2) {
            food[i].show=false;
            this.hp+=5*cfoodworth;
          } else {
            f=true;
            closef=dist(food[i].x, food[i].y, this.x, this.y);
            cf=i;
          }
        }
      }
      closef=this.sight;
      for (int i=0; i<hmax; i++) {
        if (h[i].alive && dist(h[i].x, h[i].y, this.x, this.y)<closef && this.hp<0.9*this.maxhp) {
          if (dist(h[i].x, h[i].y, this.x, this.y)<hsize/2+csize/2) {
            h[i].alive=false;
            this.hp+=25*cfoodworth;
          } else {
            sight=true;
            closef=dist(h[i].x, h[i].y, this.x, this.y);
            cv=i;
          }
        }
      }
      closef=this.sight;
      for (int i=0; i<emax; i++) {
        if (egg[i].alive && dist(egg[i].x, egg[i].y, this.x, this.y)<closef && this.hp<0.7*this.maxhp && eategg) {
          if (dist(egg[i].x, egg[i].y, this.x, this.y)<hsize/4+csize/2) {
            egg[i].alive=false;
            this.hp+=15*cfoodworth;
          } else {
            e=true;
            closef=dist(egg[i].x, egg[i].y, this.x, this.y);
            cc=i;
          }
        }
      }
      float deg;
      if (sight) {
        deg=-degrees(atan(dist(0, this.y, 0, h[cv].y)/dist(this.x, 0, h[cv].x, 0)));
        if (h[cv].x<this.x) {
          if (h[cv].y>this.y) {
            //Q3
            deg=deg-270;
          } else {
            //Q2
            deg=-270-deg;
          }
        } else if (h[cv].y>this.y) {
          //Q4
          deg=-90-deg;
        } else {
          //Q1
          deg=deg-90;
        }
        this.dir=deg;
      } else if (e || (e && f)) {
        deg=-degrees(atan(dist(0, this.y, 0, egg[cc].y)/dist(this.x, 0, egg[cc].x, 0)));
        if (egg[cc].x<this.x) {
          if (egg[cc].y>this.y) {
            //Q3
            deg=deg-270;
          } else {
            //Q2
            deg=-270-deg;
          }
        } else if (egg[cc].y>this.y) {
          //Q4
          deg=-90-deg;
        } else {
          //Q1
          deg=deg-90;
        }
        this.dir=deg;
      } else if (f) {
        deg=-degrees(atan(dist(0, this.y, 0, food[cf].y)/dist(this.x, 0, food[cf].x, 0)));
        if (food[cf].x<this.x) {
          if (food[cf].y>this.y) {
            //Q3
            deg=deg-270;
          } else {
            //Q2
            deg=-270-deg;
          }
        } else if (food[cf].y>this.y) {
          //Q4
          deg=-90-deg;
        } else {
          //Q1
          deg=deg-90;
        }
        this.dir=deg;
      }
      this.dir+=random(-this.waver, this.waver);
      pushMatrix();
      translate(this.x, this.y);
      rotate(radians(this.dir));
      if(this.sight>4){
        fill(0);
        noStroke();
        ellipse(0, csize/4, csize/5, csize/5);
      }
      //rotate(radians(0));
      this.x=screenX(0, this.speed*acc-0.5*this.speed*acc*this.age/this.le);
      this.y=screenY(0, this.speed*acc-0.5*this.speed*acc*this.age/this.le);
      if(this.sel){
        stroke(0);
        strokeWeight(2);
        line(0, 0, 0, csize);
      }
      popMatrix();
      if (age==this.count) {
        this.count+=this.when;
        this.birth();
      }
    }
  }

  void birth() {
    boolean open=false;
    int newh=0;
    for (int i=0; i<cmax; i++) {
      if (!c[i].alive && !open) {
        newh=i;
        open=true;
      }
    }
    if (open) {
      //MUTATE
      c[newh].waver=this.waver;
      c[newh].le=this.le;
      c[newh].speed=this.speed;
      c[newh].maxhp=this.maxhp;
      c[newh].sight=this.sight;
      c[newh].br=this.br;
      c[newh].dig=this.dig;
      
      int mutate=round(random(-0.49, 6.49));
      float mutsig;
      if(this.mut>0){
        mutsig=0.75*mutationRatec+mutationRatec/(this.mut);
      } else {
        mutsig=1;
      }
      if(mutate==0){
        c[newh].waver=this.waver+mutate(1, mutsig);
        c[newh].recm="waver";
      }
      if(mutate==1){
        c[newh].le=this.le+mutate(3, mutsig);
        c[newh].recm="le";
      }
      if(mutate==2){
        c[newh].speed=this.speed+mutate(.5, mutsig);
        c[newh].recm="speed";
      }
      if(mutate==3){
        c[newh].maxhp=this.maxhp+mutate(12, mutsig);
        c[newh].recm="maxhp";
      }
      if(mutate==4){
        c[newh].sight=this.sight+mutate(7.5, mutsig);
        c[newh].recm="sight";
      }
      if(mutate==5){
        c[newh].br=this.br+(mutate(0.1, mutsig));
        c[newh].recm="br";
      }
      if(mutate==6){
        c[newh].dig=this.dig+(mutate(0.05, mutsig));
        c[newh].recm="dig";
      }
      
      if(c[newh].sight<0){
        c[newh].sight=-c[newh].sight;
      }
      if(c[newh].br<1){
        c[newh].br=1;
      }
      if(c[newh].waver<0){
        c[newh].waver=-c[newh].waver;
      }
      if(c[newh].maxhp<10){
        c[newh].maxhp=10;
      }
      if(c[newh].le<3){
        c[newh].le=3;
      }
      if(c[newh].speed<0.1){
        c[newh].speed=0.1;
      }
      if(c[newh].dig<1){
        c[newh].dig=1;
      }
      
      c[newh].alive=true;
      c[newh].birth=years;
      c[newh].mut=this.mut+1;
      c[newh].hp=c[newh].maxhp;
      c[newh].life=round(c[newh].le+random(-c[newh].le/5, c[newh].le/3));
      c[newh].when=round(c[newh].le/(c[newh].br*1.5)+random(0, 2));
      if(c[newh].when<1){
        c[newh].when=1;
      }
      c[newh].count=c[newh].when;
      c[newh].x=this.x;
      c[newh].y=this.y;
    }
  }

  void display() {
    if (this.alive) {
      fill(255, 255, 255, 200);
      noStroke();
      rect(0, height-185, 130, 185);
      fill(0);
      textAlign(LEFT, BOTTOM);
      textSize(15);
      text("Age: " + this.age, 1, height);
      text("Death: " + this.life, 1, height-15);
      text("Next Birth: " + this.count, 1, height-30);
      text("Health: " + round(this.hp), 1, height-45);
      text("Max Health: " + round(this.maxhp), 1, height-60);
      text("Mutations: " + round(this.mut), 1, height-75);
      text("Speed: " + shorten(this.speed), 1, height-90);
      text("Sight: " + shorten(this.sight), 1, height-105);
      text("Waver: " + shorten(this.waver), 1, height-120);
      text("Birthrate: " + shorten(br), 1, height-135);
      text("Digestion: " + shorten(dig), 1, height-150);
      text("Recently: " + recm, 1, height-165);
    } else {
      this.sel=false;
      for (int i=0; i<cmax; i++) {
        if (c[i].alive) {
          c[i].sel=true;
        }
      }
    }
  }
}