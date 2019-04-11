import processing.sound.*;
SoundFile click, change, score, hit;
boolean Settings = false;
boolean Play = false;
boolean Choose = false;
boolean Exit = false;
boolean Paint = false;
boolean Pong= false;
String Color = "Red";
int c1 =0;
int c2 =0;
int c3 =0;
int c = 1;
int vx = 450;
PImage title, check, pong;
//
int pong_x = 300;
int pong_x2 = 300;
int pong_s = 0;
int pong_s2 = 0;
int pong_x3 = 300;
int pong_y=300;
int pong_xs = int(random(1, 5));
int pong_ys = int(random(1, 5));
int pong_score1 = 0;
int pong_score2 = 0;
//
PImage cursor, eraser;
int psize = 5;
int pbackground1 = 255;
int pbackground2 = 255;
int pbackground3 = 255;
int pcolor1 = 0;
int pcolor2 = 0;
int pcolor3 = 0;
int nz = 0;
int broi = 1;
boolean erase = false;
PImage brush;
//
void setup() {
  size(600, 600);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(20);
  imageMode(CENTER);
  //
  title=loadImage("Title.png");
  pong = loadImage("pong.png");
  brush = loadImage("paint.png");
  check = loadImage("check.png");
  click = new SoundFile(this, "click.wav");
  change = new SoundFile(this, "change.wav");
  score = new SoundFile(this, "score.wav");
  hit = new SoundFile(this, "hit.wav");
  //
  cursor = loadImage("cursor.png");
  eraser = loadImage("eraser.png");
  cursor.resize(50, 50);
  eraser.resize(50, 50);
}

void draw() {
  //Smetki
  switch(c) {
  case 1: 
    Color = "Red"; 
    break;
  case 2: 
    Color = "Green"; 
    break;
  case 3: 
    Color = "Blue"; 
    break;
  }
  switch(Color) {
  case "Red": 
    c1 = 255; 
    c2 = 0; 
    c3 = 0; 
    break;
  case "Green": 
    c1 = 0; 
    c2 = 255; 
    c3 = 0; 
    break;
  case "Blue": 
    c1 = 0; 
    c2 = 0; 
    c3 = 255; 
    break;
  }
  //
  if (!Play && !Settings && !Choose) {
    background(0);
    cursor(ARROW);
    //
    image(title, 300, 100, 300, 300);
    fill(c1, c2, c3);
    text("By Denis 18110", 300, 170);
    fill(255);
    //
    strokeWeight(2);
    stroke(c1, c2, c3);
    rect(300, 300, 300, 50);
    rect(300, 360, 300, 50);
    rect(300, 240, 300, 50);
    //
    fill(0);
    text("Settings", 300, 310);
    text("Play", 300, 250);
    text("Choose a game", 300, 370);
    fill(255, 0, 0);
    text("NOTICE: Please read \"README\" before playing!", 300, 500);
  }
  //
  if (Settings) {
    background(0);
    if (mousePressed && dist(pmouseX, pmouseY, vx, 280) < 25 && vx > 149&& vx <451) {
      vx = mouseX;
    } else if (vx <= 149) {
      vx = 150;
    } else if (vx >=451) {
      vx = 450;
    }
    float volume = map(vx, 150, 450, 0, 1)*100;
    //
    strokeWeight(2);
    stroke(c1, c2, c3);
    rect(300, 200, 300, 50);
    rect(550, 500, 100, 33);
    rect(300, 280, 300, 10);
    ellipse(vx, 280, 50, 50);
    fill(0);
    text("Back <-", 550, 510);
    text("Stroke Color: " +Color, 300, 210);
    fill(255);
    text("Volume: " + round(volume), 300, 350);
    click.amp(volume/100);
    change.amp(volume/100);
  }
  //
  if (Choose) {
    background(0);
    image(brush, 310, 330, 150, 100);
    image(pong, 300, 470, 150, 100);
    rect(550, 500, 100, 33);
    fill(0);
    text("Back <-", 550, 510);
    fill(255);
    if (Paint) {
      image(check, 485, 310);
    }
    //
    if (Pong) {
      image(check, 485, 450);
    }
  }
  //
  if (Play) {
    if(!Paint && !Pong){
      background(0);
      fill(255, 0, 0);
      text("You haven't selected a game yet!", width/2,height/2);
    }
    if (Paint) {
      if (nz == 0) {
        background(255);
        nz++;
      }
      if (keyPressed) {
        switch(key) {
        case '[': 
          if (psize > 1) {
            psize--;
          }
          println(psize);
          break;
        case ']': 
          psize++;
          println(psize);
          break;
        case 'd':
          background(pbackground1, pbackground2, pbackground3);
          println("Deleted");
          break;
        case 'r':
          pcolor1 = 255;
          pcolor2 = 0;
          pcolor3 = 0;
          erase = false;
          break;
        case 'g':
          pcolor1 = 0;
          pcolor2 = 255;
          pcolor3 = 0;
          erase = false;
          break;
        case 'b':
          pcolor1 = 0;
          pcolor2 = 0;
          pcolor3 = 255;
          erase = false;
          break;
        case 'e':
          pcolor1 = 255;
          pcolor2 = 255;
          pcolor3 = 255;
          cursor(eraser);
          erase = true;
          break;
        case 'c':
          pcolor1 = 0;
          pcolor2 = 0;
          pcolor3 = 0;
          erase = false;
          break;
        case 's' : 
          saveFrame("drawing"+broi+".png");
          broi++;
          println("SAVED");
          break;
        }
      }
      strokeWeight(psize);
      stroke(pcolor1, pcolor2, pcolor3);
      if (!mousePressed) {
        if (!erase) {
          cursor(cursor, 7, 27);
        } else {
          cursor(eraser, 7, 27);
        }
      } else {
        if (!erase) {
          noCursor();
        }
        line(pmouseX, pmouseY, mouseX, mouseY);
      }
    }
    //
    if (Pong) {
      background(0);
      if (pong_ys ==0) {
        pong_ys =int(random(-5, 5));
      }
      if (pong_xs ==0) {
        pong_xs =int(random(-5, 5));
      }
      fill(255);
      rect(pong_x, height - 25, 150, 50);
      rect(pong_x2, 25, 150, 50);
      rect(pong_x3, pong_y, 30, 30);
      if (pong_x + 75 <= width && pong_x - 75 >= 0) {
        pong_x+=pong_s;
      } else if (pong_x - 75 < 0) {
        pong_x = 75;
      } else if (pong_x + 75 > width) {
        pong_x = width - 75;
      }
      if (pong_x2 + 75 <= width && pong_x2 - 75 >= 0) {
        pong_x2+=pong_s2;
      } else if (pong_x2 - 75 < 0) {
        pong_x2 = 75;
      } else if (pong_x2 + 75 > width) {
        pong_x2 = width - 75;
      }
      pong_x3+=pong_xs;
      pong_y+=pong_ys;
      if (pong_x3 + 15 > width || pong_x3 - 15 < 0) {
        pong_xs=-pong_xs;
      }
      if (pong_x3 > pong_x - 75 && pong_x3 < pong_x + 75 && pong_y + 15 > height - 50) {
        pong_ys=-pong_ys;
        pong_ys-=1;
        hit.play();
      }
      if (pong_x3 > pong_x2 - 75 && pong_x3 < pong_x2 + 75 && pong_y - 15 < 50) {
        pong_ys=-pong_ys;
        pong_ys+=1;
        hit.play();
      }
      text(pong_score1, 500, 300);
      text(pong_score2, 100, 300);
      if (pong_y + 15 > height) {
        score.play();
        pong_score2+=1;
        pong_x3 = 300;
        pong_y  =300;
        pong_xs = int(random(-5, 5));
        pong_ys = int(random(-5, 5));
      }
      if (pong_y - 15 < 0) {
        score.play();
        pong_score1 +=1;
        pong_x3 = 300;
        pong_y  =300;
        pong_xs = int(random(-5, 5));
        pong_ys = int(random(-5, 5));
      }
    }
    //
  }
  //
}
//
void mouseClicked() {
  if (mouseX > 235 && mouseX < 385 && mouseY >255 && mouseY < 405 && Choose) {
    Paint = true;
    Pong = false;
    click.play();
  }
  if (mouseX > 225 && mouseX < 375 && mouseY >395 && mouseY < 545 && Choose) {
    Paint = false;
    Pong = true;
    click.play();
  }
  if (mouseX > 150 && mouseX <450 && mouseY >275 && mouseY <325 && !Choose && !Play && !Settings) {
    Settings = true;
    click.play();
  }
  if (mouseX > 500 && mouseX <600 && mouseY >483 && mouseY <517 && Settings) {
    Settings = false;
    click.play();
  }
  if (mouseX > 500 && mouseX <600 && mouseY >483 && mouseY <517 && Choose) {
    Choose = false;
    click.play();
  }
  if (mouseX > 500 && mouseX <600 && mouseY >483 && mouseY <517 && Play) {
    Play = false;
    click.play();
  }
  if (mouseX > 150 && mouseX <450 && mouseY >215 && mouseY <265 && !Play && !Settings && !Choose) {
    Play = true;
    pong_x = 300;
    pong_x2 = 300;
    pong_s = 0;
    pong_s2 = 0;
    pong_x3 = 300;
    pong_y=300;
    pong_xs = int(random(1, 5));
    pong_ys = int(random(1, 5));
    pong_score1 = 0;
    pong_score2 = 0;
    nz = 0;
    click.play();
  }
  if (mouseX>150 && mouseX <450 && mouseY>335 && mouseY<385 && !Settings && !Play && !Choose) {
    Choose = true;
    click.play();
  }
}
//
void keyReleased() {
  if (Settings && keyCode == LEFT) {
    if (c == 1) {
      c = 3;
    } else {
      c-=1;
    }
    change.play();
  }
  if (Settings && keyCode == RIGHT) {
    if (c == 3) {
      c = 1;
    } else {
      c+=1;
    }
    change.play();
  }
  if (Play && key=='f') {
    Play = false;
  }
  if (Play && Pong) {
    switch(keyCode) {
    case LEFT: 
      pong_s=-5;
      break;
    case RIGHT: 
      pong_s=+5;
      break;
    }
    switch(key) {
    case 'a':
      pong_s2=-5;
      break;
    case 'd':
      pong_s2=+5;
      break;
    }
  }
}
//
