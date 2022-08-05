public void disp() {
  hover1=false;
  hover2=false;
  for (int i=0; i<fmax; i++) {
    food[i].draw();
  }
  for (int i=0; i<emax; i++) {
    egg[i].draw();
  }
  if (mousePressed) {
    select=false;
  }
  for (int i=0; i<hmax; i++) {
    h[i].draw();
    h[i].hover();
  }
  for (int i=0; i<cmax; i++) {
    c[i].draw();
    c[i].hover();
  }
  if (hover1 || hover2) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
  if (!select) {
    for (int i=0; i<hmax; i++) {
      h[i].sel=false;
    }
    for (int i=0; i<cmax; i++) {
      c[i].sel=false;
    }
  }
}

public void update() {
  if (frame<frameCount) {
    frame=frameCount;
  }
  foodrate=ifr/acc;
  if (frameCount==frame && acc>0) {
    frame+=round(foodrate*60);
    for (int j=0; j<acc; j++) {
      if (foodcount<fmax) {
        food[foodcount].show=true;
        food[foodcount].x=round(random(10, width-10));
        food[foodcount].y=round(random(10, height-10));
        foodcount++;
      } else {
        boolean over=false;
        for (int i=0; i<fmax; i++) {
          if (!food[i].show && !over) {
            food[i].show=true;
            food[i].x=round(random(10, width-10));
            food[i].y=round(random(10, height-10));
            over=true;
          }
        }
      }
    }
  }

  for (int i=0; i<hmax; i++) {
    h[i].bump();
  }
  for (int i=0; i<cmax; i++) {
    c[i].bump();
  }

  for (int i=0; i<hmax; i++) {
    h[i].turn();
  }
  for (int i=0; i<cmax; i++) {
    c[i].turn();
  }
  for (int i=0; i<cmax; i++) {
    if (select && c[i].sel) {
      c[i].display();
    }
  }
  for (int i=0; i<hmax; i++) {
    if (select && h[i].sel) {
      h[i].display();
    }
  }
}

public float mutate(float a, float mutsig) {
  return(random(-(a*mutsig)/4, a*mutsig));
}

public float shorten(float a) {
  return round(a*100.0f)/100.0f;
}