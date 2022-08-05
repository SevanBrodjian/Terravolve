int hmax=20;
int cmax=20;
int emax=20;
int fmax=1250;
float ifr=0;
boolean eategg=false;
float zoom=1;
int startc=5;
int starth=5;
float mutationRatec=1.5;
float mutationRateh=2.5;
float cfoodworth=2;
float hfoodworth=3;

int starve=0;
int eaten=0;
int oldage=0;
float foodrate=ifr;
int acc=1;
float inc=1;
int years=0;
public food[] food = new food[fmax];
public herbivore[] h = new herbivore[hmax];
public carnivore[] c = new carnivore[cmax];
public egg[] egg = new egg[emax];
int frame=1;
int foodcount=500;
float hsize=12/zoom;
float csize=15/zoom;
float fsize=10/zoom;
int sel=cmax+1;
boolean select;
boolean hover1=false;
boolean hover2=false;
int count1=0;
int count2=600;
boolean stats=false;

void setup() {
  for (int i=0; i<hmax; i++) {
    h[i] = new herbivore();
  }
  for (int i=0; i<cmax; i++) {
    c[i] = new carnivore();
  }
  for (int i=0; i<fmax; i++) {
    food[i] = new food();
  }
  for (int i=0; i<emax; i++) {
    egg[i] = new egg();
  }
  for (int i=0; i<starth; i++) {
    h[i].alive=true;
    h[i].x=random(0, width);
    h[i].y=random(0, height);
    h[i].br=1;
  }
  for (int i=0; i<startc; i++) {
    c[i].alive=true;
    c[i].x=random(0, width);
    c[i].y=random(0, height);
    c[i].br=1;
  }
  for (int i=0; i<fmax/2; i++) {
    food[i].show=true;
    food[i].x=round(random(0, width));
    food[i].y=round(random(0, height));
  }
  frameRate(1000);
  fullScreen();
  cursor(ARROW);
}

void draw() {
  if (!stats) {
    if (acc>0) {
      count1++;
    }
    if (count1>count2) {
      count1=count2;
    }
    if (count1==count2) {
      count1=0;
      years++;
    }
    background(230);
    disp();
    update();
    fill(255, 255, 255, 200);
      noStroke();
      rect(0, 0, 100, 90);
    fill(0);
    textAlign(LEFT, TOP);
    textSize(12);
    text("Framerate: " + round(frameRate), 1, 1);
    text("Years: " + years, 1, 15);
    text("Speed: " + acc, 1, 30);
    text("Starved: " + starve, 1, 45);
    text("Old Age: " + oldage, 1, 60);
    text("Eaten: " + eaten, 1, 75);
  } else {
    int calive=0;
    float cage=0;
    float cdeath=0;
    float chp=0;
    float cmaxhp=0;
    float cmut=0;
    float cspeed=0;
    float csight=0;
    float cwaver=0;
    float cbr=0;
    float cdig=0;
    float mcage=0;
    float mcdeath=0;
    float mchp=0;
    float mcmaxhp=0;
    float mcmut=0;
    float mcspeed=0;
    float mcsight=0;
    float mcwaver=0;
    float mcbr=0;
    float mcdig=0;
    int halive=0;
    float hage=0;
    float hdeath=0;
    float hhp=0;
    float hmaxhp=0;
    float hmut=0;
    float hspeed=0;
    float hsight=0;
    float hwaver=0;
    float hbr=0;
    float hdig=0;
    float heggtime=0;
    float mhage=0;
    float mhdeath=0;
    float mhhp=0;
    float mhmaxhp=0;
    float mhmut=0;
    float mhspeed=0;
    float mhsight=0;
    float mhwaver=0;
    float mhbr=0;
    float mhdig=0;
    float mheggtime=0;
    for (int i=0; i<cmax; i++) {
      if (c[i].alive) {
        calive++;
        if (c[i].age>mcage) {
          mcage=c[i].age;
        }
        cage+=c[i].age;
        if (c[i].life>mcdeath) {
          mcdeath=c[i].life;
        }
        cdeath+=c[i].life;
        if (c[i].hp>mchp) {
          mchp=c[i].hp;
        }
        chp+=c[i].hp;
        if (c[i].hp>mcmaxhp) {
          mcmaxhp=c[i].maxhp;
        }
        cmaxhp+=c[i].maxhp;
        if (c[i].mut>mcmut) {
          mcmut=c[i].mut;
        }
        cmut+=c[i].mut;
        if (c[i].speed>mcspeed) {
          mcspeed=c[i].speed;
        }
        cspeed+=c[i].speed;
        if (c[i].sight>mcsight) {
          mcsight=c[i].sight;
        }
        csight+=c[i].sight;
        if (c[i].waver>mcwaver) {
          mcwaver=c[i].waver;
        }
        cwaver+=c[i].waver;
        if (c[i].br>mcbr) {
          mcbr=c[i].br;
        }
        cbr+=c[i].br;
        if (c[i].dig>mcdig) {
          mcdig=c[i].dig;
        }
        cdig+=c[i].dig;
      }
    }
    cage=cage/calive;
    cdeath=cdeath/calive;
    chp=chp/calive;
    cmaxhp=cmaxhp/calive;
    cmut=cmut/calive;
    cspeed=cspeed/calive;
    csight=csight/calive;
    cwaver=cwaver/calive;
    cbr=cbr/calive;
    cdig=cdig/calive;

    for (int i=0; i<hmax; i++) {
      if (h[i].alive) {
        halive++;
        if (h[i].age>mhage) {
          mhage=h[i].age;
        }
        hage+=h[i].age;
        if (h[i].life>mhdeath) {
          mhdeath=h[i].life;
        }
        hdeath+=h[i].life;
        if (h[i].hp>mhhp) {
          mhhp=h[i].hp;
        }
        hhp+=h[i].hp;
        if (h[i].hp>mhmaxhp) {
          mhmaxhp=h[i].maxhp;
        }
        hmaxhp+=h[i].maxhp;
        if (h[i].mut>mhmut) {
          mhmut=h[i].mut;
        }
        hmut+=h[i].mut;
        if (h[i].speed>mhspeed) {
          mhspeed=h[i].speed;
        }
        hspeed+=h[i].speed;
        if (h[i].sight>mhsight) {
          mhsight=h[i].sight;
        }
        hsight+=h[i].sight;
        if (h[i].waver>mhwaver) {
          mhwaver=h[i].waver;
        }
        hwaver+=h[i].waver;
        if (h[i].br>mhbr) {
          mhbr=h[i].br;
        }
        hbr+=h[i].br;
        if (h[i].dig>mhdig) {
          mhdig=h[i].dig;
        }
        hdig+=h[i].dig;
        if (h[i].eggtime>mheggtime) {
          mheggtime=h[i].eggtime;
        }
        heggtime+=h[i].eggtime;
      }
    }
    hage=hage/halive;
    hdeath=hdeath/halive;
    hhp=hhp/halive;
    hmaxhp=hmaxhp/halive;
    hmut=hmut/halive;
    hspeed=hspeed/halive;
    hsight=hsight/halive;
    hwaver=hwaver/halive;
    hbr=hbr/halive;
    hdig=hdig/halive;
    heggtime=heggtime/halive;

    background(255);
    fill(0);
    textSize(50);
    textAlign(LEFT, BOTTOM);
    text("Carnivores", 125, height-375);
    textSize(20);
    textAlign(LEFT, BOTTOM);
    text("Age: ", 75, height-100);
    text("Death: ", 75, height-125);
    text("Health: ", 75, height-150);
    text("Max Health: ", 75, height-175);
    text("Mutations: ", 75, height-200);
    text("Speed: ", 75, height-225);
    text("Sight: ", 75, height-250);
    text("Waver: ", 75, height-275);
    text("Birthrate: ", 75, height-300);
    text("Digestion: ", 75, height-325);
    text("Num: "+ calive, 75, height-75);

    text("Avg: " + shorten(cage), 225, height-100);
    text("Avg: " + shorten(cdeath), 225, height-125);
    text("Avg: " + shorten(chp), 225, height-150);
    text("Avg: " + shorten(cmaxhp), 225, height-175);
    text("Avg: " + shorten(cmut), 225, height-200);
    text("Avg: " + shorten(cspeed), 225, height-225);
    text("Avg: " + shorten(csight), 225, height-250);
    text("Avg: " + shorten(cwaver), 225, height-275);
    text("Avg: " + shorten(cbr), 225, height-300);
    text("Avg: " + shorten(cdig), 225, height-325);

    text("Max: " + shorten(mcage), 375, height-100);
    text("Max: " + shorten(mcdeath), 375, height-125);
    text("Max: " + shorten(mchp), 375, height-150);
    text("Max: " + shorten(mcmaxhp), 375, height-175);
    text("Max: " + shorten(mcmut), 375, height-200);
    text("Max: " + shorten(mcspeed), 375, height-225);
    text("Max: " + shorten(mcsight), 375, height-250);
    text("Max: " + shorten(mcwaver), 375, height-275);
    text("Max: " + shorten(mcbr), 375, height-300);
    text("Max: " + shorten(mcdig), 375, height-325);
    
    
    textSize(50);
    textAlign(LEFT, BOTTOM);
    int move=500;
    text("Herbivores", 125+move, height-375);
    textSize(20);
    textAlign(LEFT, BOTTOM);
    text("Age: ", 75+move, height-100);
    text("Death: ", 75+move, height-125);
    text("Health: ", 75+move, height-150);
    text("Max Health: ", 75+move, height-175);
    text("Mutations: ", 75+move, height-200);
    text("Speed: ", 75+move, height-225);
    text("Sight: ", 75+move, height-250);
    text("Waver: ", 75+move, height-275);
    text("Birthrate: ", 75+move, height-300);
    text("Digestion: ", 75+move, height-325);
    text("Egg Time: ", 75+move, height-75);
    text("Num: " + halive, 75+move, height-50);

    text("Avg: " + shorten(hage), 225+move, height-100);
    text("Avg: " + shorten(hdeath), 225+move, height-125);
    text("Avg: " + shorten(hhp), 225+move, height-150);
    text("Avg: " + shorten(hmaxhp), 225+move, height-175);
    text("Avg: " + shorten(hmut), 225+move, height-200);
    text("Avg: " + shorten(hspeed), 225+move, height-225);
    text("Avg: " + shorten(hsight), 225+move, height-250);
    text("Avg: " + shorten(hwaver), 225+move, height-275);
    text("Avg: " + shorten(hbr), 225+move, height-300);
    text("Avg: " + shorten(hdig), 225+move, height-325);
    text("Avg: " + shorten(heggtime), 225+move, height-75);

    text("Max: " + shorten(mhage), 375+move, height-100);
    text("Max: " + shorten(mhdeath), 375+move, height-125);
    text("Max: " + shorten(mhhp), 375+move, height-150);
    text("Max: " + shorten(mhmaxhp), 375+move, height-175);
    text("Max: " + shorten(mhmut), 375+move, height-200);
    text("Max: " + shorten(mhspeed), 375+move, height-225);
    text("Max: " + shorten(mhsight), 375+move, height-250);
    text("Max: " + shorten(mhwaver), 375+move, height-275);
    text("Max: " + shorten(mhbr), 375+move, height-300);
    text("Max: " + shorten(mhdig), 375+move, height-325);
    text("Max: " + shorten(mheggtime), 375+move, height-75);
  }
}

void keyPressed() {
  if (key=='-') {
    inc-=0.5;
  }
  if (key=='=') {
    inc+=0.5;
  }
  if (key=='0') {
    inc=1;
  }
  if (key=='9') {
    inc=0;
  }
  if (key=='c') {
    float highc=0;
    int highestc=0;
    for (int i=0; i<cmax; i++) {
      c[i].sel=false;
      select=true;
      float test=0;
      test+=(c[i].dig)+(c[i].maxhp/100)+(c[i].sight)+(c[i].br)+(c[i].waver)+(c[i].le/10);
      if (test>highc) {
        highc=test;
        highestc=i;
      }
    }
    c[highestc].sel=true;
  }
  if (key=='h') {
    float highh=0;
    int highesth=0;
    for (int i=0; i<hmax; i++) {
      h[i].sel=false;
      select=true;
      float test=0;
      test+=(h[i].dig)+(h[i].maxhp/100)+(h[i].sight)+(h[i].br)+(h[i].waver)+(h[i].le/20)+(h[i].eggtime/3);
      if (test>highh) {
        highh=test;
        highesth=i;
      }
    }
    h[highesth].sel=true;
  }
  if (key==' ') {
    stats=!stats;
    acc=0;
  }
  if (inc<0) {
    inc=0;
  }
  acc=round(inc);
  if (acc==0) {
    count1=0;
  }
  if (acc>0) {
    count2=round(600/acc);
  }
}
