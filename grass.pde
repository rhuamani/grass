import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;

//Grass moves back and forth during the day in response to wind, at night it goes to sleep.
float diameter;
int x=0;
int y=100; 
int beg = 20; // 10
int end = 30 ; // 30
int delay = 3 ; //3
int cloudx = 0 ;
float r = 156;
float g = 236 ;
float b = 255 ;
boolean change = true; 

AniSequence seq;

Arduino ball;

void setup() {
  size(1200, 900);
  println(Arduino.list());
  ball = new Arduino (this, "/dev/cu.usbmodem1421", 57600);
  ball.pinMode(7, Arduino. SERVO);
  background(225);
  ball.servoWrite(7, x);


  diameter =50;
  
  // sequence that moves servo back and forth
  Ani.init(this);

  seq = new AniSequence(this);
  loop();
  seq.beginSequence();
  
  seq.add(Ani.to(this, delay , "x", beg)); 
   seq.add(Ani.to(this, delay, "x", end)); 
   seq.add(Ani.to(this, delay , "x" , beg));
   seq.add(Ani.to(this, delay, "x", end));
   seq.add(Ani.to(this, delay, "x", beg));
   seq.add(Ani.to(this, delay, "x" , end));
   seq.add(Ani.to(this, delay, "x", beg));
   
   seq.add(Ani.to(this, delay, "x", end));
  
  seq.add(Ani.to(this, delay, "x", beg));
  seq.add(Ani.to(this, delay, "x", beg+10)); 

  seq.add(Ani.to(this, delay/3, "x", end+1)); 
  seq.add(Ani.to(this, delay/2, "x", end+1));
  seq.add(Ani.to(this, delay, "x", end+1));
  
  seq.add(Ani.to(this, 1, "x", end+20)); // 
  seq.add(Ani.to(this, delay+5, "x", end+40)); 
  seq.add(Ani.to(this, delay+5, "x", end+45));
  seq.add(Ani.to(this, delay*2, "x", end+50)); 
  seq.add(Ani.to(this, delay*2, "x", end+56)); 

  seq.add(Ani.to(this, delay*2, "x", end+20));
  seq.add(Ani.to(this, delay+2, "x", end+1));
  seq.add(Ani.to(this, delay, "x", beg));
 
  seq.endSequence();
  seq.start();
}
// changes background color according to movement of servo 
void draw() {

  background(r, g, b);

  ball.servoWrite(7, x);

  if (change == true) {
    if ((x>30)&&(x<76)) {
      if ((r>=128) | (g >= 128 ) | (b >= 128)) {

        r= r - 0.2 ;
        g = g - 0.4 ;
        b = b - 0.4;
        background (r, g, b);
      } 
    } else if (x>80) {
      change= false;
        if ((r<156) | (g<236) | (b <255)) {

          r= r + 0.2 ;
          g = g + 0.4 ;
          b = b + 0.4;
          background (r, g, b);
          change= true;
        }
      }
    }
  }



void sequenceEnd() {
  seq.start();
}
