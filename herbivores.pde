class herbivore {
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
  int eggtime;
  int life;
  int when;
  int count;
  float dig;
  String recm;

  public herbivore() {
    this.dig=1.2;
    this.br=2;
    this.waver=4;
    this.birth=0;
    this.le=20;
    this.sel=false;
    this.alive=false;
    this.speed=0.55;
    this.dir=0;
    this.x=width/2+45;
    this.y=height/2;
    this.hp=100;
    this.maxhp=100;
    this.mut=0;
    this.sight=0;
    this.eggtime=4;
    this.life=round(this.le+random(-this.le/5, this.le/3));
    this.when=round(this.le/(this.br*2)+random(0, 2));
    this.count=this.when;
    this.recm="n/a";
  }

  public void draw() {
    if (this.alive==true) {
      this.hp-=0.035*acc/this.dig;
      this.age=years-this.birth;
      if(this.age<35){
        fill(25, 250, 25);
      } else {
        fill(0, 210, 0);
      }
      stroke(0);
      strokeWeight(0.5);
      ellipse(this.x, this.y, hsize, hsize);
      if (this.sel) {
        noFill();
        stroke(50, 90, 100);
        strokeWeight(3);
        ellipse(this.x, this.y, hsize, hsize);
        stroke(0);
        strokeWeight(1);
        if(this.sight>hsize){
          ellipse(this.x, this.y, this.sight, this.sight);
        }
      }
      if (this.hp<0) {
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
    if (mouseX>this.x-hsize*2 && mouseX<this.x+hsize*2 && mouseY>this.y-hsize*2 && mouseY<this.y+hsize*2 && this.alive) {
      hover2=true;
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
      if (this.x<hsize/2) {
        this.dir=270+random(-45, 45);
        this.x=hsize/2;
      }
      if (this.x>width-hsize/2) {
        this.x=width-hsize/2;
        this.dir=90+random(-45, 45);
      }
      if (this.y<hsize/2) {
        this.dir=0+random(-45, 45);
        this.y=hsize/2;
      }
      if (this.y>height-hsize/2) {
        this.dir=180+random(-45, 45);
        this.y=height-hsize/2;
      }
    }
  }

  public void turn() {
    if (this.alive) {
      float closef=this.sight;
      int cv=-1;
      int cc=-1;
      boolean pred=false;
      boolean sight=false;

      for (int i=0; i<fmax; i++) {
        if (food[i].show && dist(food[i].x, food[i].y, this.x, this.y)<hsize/2+fsize/2) {
          food[i].show=false;
          this.hp+=10*hfoodworth;
        }
      }

      for (int i=0; i<fmax; i++) {
        if (food[i].show && dist(food[i].x, food[i].y, this.x, this.y)<closef && this.hp<0.9*this.maxhp) {
          if (dist(food[i].x, food[i].y, this.x, this.y)<hsize/2+fsize/2) {
            food[i].show=false;
            this.hp+=10*hfoodworth;
          } else {
            sight=true;
            closef=dist(food[i].x, food[i].y, this.x, this.y);
            cv=i;
          }
        }
      }
      closef=this.sight;
      for (int i=0; i<cmax; i++) {
        if (c[i].alive && dist(c[i].x, c[i].y, this.x, this.y)<closef) {
          sight=true;
          pred=true;
          closef=dist(c[i].x, c[i].y, this.x, this.y);
          cc=i;
        }
      }
      float deg;
      if (!pred && sight) {
        deg=-degrees(atan(dist(0, this.y, 0, food[cv].y)/dist(this.x, 0, food[cv].x, 0)));
        if (food[cv].x<this.x) {
          if (food[cv].y>this.y) {
            //Q3
            deg=deg-270;
          } else {
            //Q2
            deg=-270-deg;
          }
        } else if (food[cv].y>this.y) {
          //Q4
          deg=-90-deg;
        } else {
          //Q1
          deg=deg-90;
        }
        this.dir=deg;
      } else if (sight) {
        deg=-degrees(atan(dist(0, this.y, 0, c[cc].y)/dist(this.x, 0, c[cc].x, 0)));
        if (c[cc].x<this.x) {
          if (c[cc].y>this.y) {
            //Q3
            deg=deg-90;
          } else {
            //Q2
            deg=-90-deg;
          }
        } else if (c[cc].y>this.y) {
          //Q4
          deg=90-deg;
        } else {
          //Q1
          deg=deg+90;
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
        ellipse(0, hsize/4, hsize/5, hsize/5);
      }
      //rotate(radians(0));
      this.x=screenX(0, this.speed*acc-0.5*this.speed*acc*this.age/this.le);
      this.y=screenY(0, this.speed*acc-0.5*this.speed*acc*this.age/this.le);
      if(this.sel){
        stroke(0);
        strokeWeight(2);
        line(0, 0, 0, hsize);
      }
      popMatrix();
      if (age==this.count) {
        this.count+=this.when;
        this.birth();
      }
    }
  }

  void birth() {
    boolean ef=false;
    int en=0;
    for (int i=0; i<emax; i++) {
      if (!egg[i].alive) {
        en=i;
        ef=true;
      }
    }
    if (ef) {
      egg[en].alive=true;
      egg[en].x=this.x+random(-hsize, hsize);
      egg[en].y=this.y+random(-hsize, hsize);
      egg[en].sight=this.sight;
      egg[en].mut=this.mut;
      egg[en].maxhp=this.maxhp;
      egg[en].speed=this.speed;
      egg[en].le=this.le;
      egg[en].birth=this.birth;
      egg[en].waver=this.waver;
      egg[en].br=this.br;
      egg[en].eggtime=this.eggtime;
      egg[en].birth=years;
      egg[en].hatch=round(eggtime+random(-eggtime/10, eggtime/10));
      egg[en].when=round(this.le/(this.br*2)+random(0, 2));
    }
  }

  void display() {
    if (this.alive) {
      fill(255, 255, 255, 200);
      noStroke();
      rect(0, height-200, 130, 200);
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
      text("Egg Time: " + shorten(eggtime), 1, height-165);
      text("Recently: " + recm, 1, height-180);
    } else {
      this.sel=false;
      for (int i=0; i<hmax; i++) {
        if (h[i].alive) {
          h[i].sel=true;
        }
      }
    }
  }
}
