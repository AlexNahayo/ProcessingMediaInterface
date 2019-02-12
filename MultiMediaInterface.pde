import controlP5.*;
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

Minim minim, minim2, minim3,minim5,minim6;
AudioOutput out, out2, out3,out4,out5;
Oscil       wave, wave2, wave3;

FilePlayer fileplayer1,groove;//declaring varaibles for the on/off fileplayer and BPF
BandPass   bpf;//BPF
Gain       gain4;




ControlP5 cp5;
int myColorBackground = color(25, 0, 0);
int myColor = color(39, 0, 0, 145);// represnts the colour for the first rectangle.
int myColor2 = color(39, 0, 0, 145);// represnts the colour for the second rectangle.
int myColor3 = color(39, 0.0, 145);// represnts the colour for the third rectangle.

boolean play,play1;//declaring varaibles for on/off advanced and BPF
String fileName = "groove.mp3" ; 

void setup() {
  size(1000, 800);
  
  //BPF
  
  minim6 = new Minim(this);
  out5 = minim6.getLineOut();
  
  groove = new FilePlayer( minim6.loadFileStream("groove.mp3") );
  // make a band pass filter with a center frequency of 440 Hz and a bandwidth of 20 Hz
  // the third argument is the sample rate of the audio that will be filtered
  // it is required to correctly compute values used by the filter
  bpf = new BandPass(440, 20, out5.sampleRate());
  groove.patch( bpf ).patch( out5 );
  // start the file playing
  play1=true;
  groove.loop();
  
  
 
  cp5 = new ControlP5(this);  //set up the ControlP5 object

  play1=true;
  
  cp5.addToggle("toggle1") //adding 
    .setPosition(30, 550)
    .setSize(50, 20)
    .setValue(false)  //the toggle is set to true
    .setMode(ControlP5.SWITCH)
    .setLabel("ON/OFF")  //set the text for the label
    .setColorLabel(color(#FFFFFF))  //set a color for the label
    //place the label above the toggle
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0)
    ;

  println("play= "+play1+" ");
  
  
  //ON/OFF 
  minim5=new Minim(this);
  cp5 = new ControlP5(this);  //set up the ControlP5 object
  out4 = minim5.getLineOut(); //adding
  fileplayer1= new FilePlayer( minim5.loadFileStream(fileName) );
  
  fileplayer1.loop();
  //set play to true
  play=true;
  
  

//create a toggle widget
  cp5.addToggle("toggle")
    .setPosition(30, 505)
    .setSize(50, 20)
    .setValue(false)  //the toggle is set to true
    .setMode(ControlP5.SWITCH)
    .setLabel("ON/OFF")  //set the text for the label
    .setColorLabel(color(#FFFFFF))  //set a color for the label
    //place the label above the toggle
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0)
    ;
    
  println("play= "+play+" ");
  
  
  //adding gain knob
 minim5 = new Minim(this);
  cp5 = new ControlP5(this);
 cp5.addKnob("Gain4")
  .setPosition(892.5,495)
  .setSize(40,30)
  .setMin(-12)
  .setMax(12)
  .setValue(0)
  .setWidth(60)
  .setLabel("Gain")
  .setColorLabel(color(#FFFFFF)) ;
  ;
 
  // I'm trying to patch the signal the boolean play varaible through to the gain knob using examples on moodle 
 //player= new AudioPlayer(minim.loadFileStream(playername) );
  
  //player.loop();
  
  gain4 = new Gain(0.f);

  out4 = minim5.getLineOut();

  fileplayer1.patch(gain4).patch(out4);
  
  
  
  
  
  
  
  
  
  cp5 = new ControlP5(this);
  minim = new Minim(this);
  minim2 = new Minim(this);
  minim3 = new Minim(this);


  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  out2 = minim2.getLineOut();
  out3 = minim3.getLineOut();

  wave = new Oscil( 440, 1.0f, Waves.TRIANGLE);
  wave.patch(out);

  wave2 = new Oscil( 440, 1.0f, Waves.SQUARE);
  wave2.patch(out);

  wave3 = new Oscil( 440, 1.0f, Waves.SINE);
  wave3.patch(out);


  //Saw wave
  cp5.addSlider("Pitch")
    .setPosition(50, 80)
    .setSize(10, 100)
    .setRange(0, width)
    .setValue(0)
    ;

  cp5.addSlider("Shade")
    .setPosition(150, 80)
    .setSize(10, 100)
    .setRange(0, 100)
    .setLabel("Shade")
    .setValue(0)
    ;

  cp5.addKnob("Gain")
    .setPosition(250, 110)
    .setMin(0)
    .setMax(1)
    .setValue(0.0001)
    .setLabel("Gain")
    .setWidth(40);
  ;

  //Square wave
  cp5.addSlider("Pitch2")
    .setPosition(375, 80)
    .setSize(10, 100)
    .setRange(0, width)
    .setLabel("Pitch")
    .setValue(0)
    ;

  cp5.addSlider("Shade2")
    .setPosition(475, 80)
    .setSize(10, 100)
    .setRange(0, 100)
    .setLabel("Shade")
    .setValue(0)
    ;

  cp5.addKnob("Gain2")
    .setPosition(575, 110)
    .setMin(0)
    .setMax(1)
    .setValue(0.0001)
    .setLabel("Gain")
    .setWidth(40);
  ;

  //Sine wave
  cp5.addSlider("Pitch3")
    .setPosition(700, 80)
    .setSize(10, 100)
    .setRange(0, width)
    .setLabel("Pitch")
    .setValue(0)
    ;

  cp5.addSlider("Shade3")
    .setPosition(800, 80)
    .setSize(10, 100)
    .setRange(0, 100)
    .setLabel("Shade")
    .setValue(0)
    ;

  cp5.addKnob("Gain3")
    .setPosition(900, 110)
    .setMin(0)
    .setMax(1)
    .setValue(0.0001)
    .setLabel("Gain")
    .setWidth(40);
  ;
}

void draw() {
  background(myColorBackground);

  //the fill color for the rectangle will be set by the values from sliderValue
  fill(myColor);
  rect(25, 225, 270, 100, 300);
  fill(myColor2);
  rect(350, 225, 270, 100, 300);
  fill(myColor3);
  rect(665, 225, 270, 100, 300);
  
  //initialising functons in draw for the on/off advanced.
  //background(20, 0, 0);
  stroke(255, 255, 255);
  fill(50, 0, 120);
  
  //adding ON/OFF
  for(int i = 0; i < out4.bufferSize() - 1; i++)
  {
    line(i, 400  + out4.left.get(i)*50,  i+1, 400  + out4.left.get(i+1)*50);
    line(i, 475 + out4.right.get(i)*50, i+1, 475 + out4.right.get(i+1)*50);
  }
  
  //maps the poistion of the curcer on the screen
   float posx = map(fileplayer1.position(), 0, fileplayer1.length(), 0, width);
  stroke(0,200,0);
  line(posx, 375, posx,490);
  
 stroke(#FFFFFF);
  text("Press g to skip forward and h to skip backward.", 10, 365);
  stroke(0); 
  
  
  //BPF
  {
  //background(0);
  stroke(255);
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for(int i = 0; i < out5.bufferSize()-1; i++)
  {
    float x1 = map(i, 0, out5.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out5.bufferSize(), 0, width);
    line(x1, 600 - out5.left.get(i)*50, x2, 600 - out5.left.get(i+1)*50);
    line(x1, 675 - out5.right.get(i)*50, x2, 675 - out5.right.get(i+1)*50);
  }
  // draw a rectangle to represent the pass band
  noStroke();
  fill(255, 0, 0, 60);
  rect(mouseX - bpf.getBandWidth()/20, 590, bpf.getBandWidth()/10, 100);
  }
  
  
}

//declaring fucntions for on/off advanced.

void toggle(boolean b) {
  //when the toggle is on (true) the song will play
  if (b)  //if the toggle is switched on (true) the song will play
    fileplayer1.play();
  else  //if toggle is off (false) the song will pause
    fileplayer1.pause();
}


void keyPressed()// allows the user to press two assigned keys.
{
  if ( key == 'g' )
  {
    // skip forward 1 second (1000 milliseconds)
    fileplayer1.skip(1000);
  }
  if ( key == 'h' )
  {
    // skip backward 1 second (1000 milliseconds)
    fileplayer1.skip(-1000);
  }


}
void Gain4(float p){
   gain4.setValue(p);
}





//Saw wave
void Shade(float theColor) {
  myColor = color(200, theColor, 50);
}

void Pitch(float freq) {
  wave.setFrequency(freq+200);
}

void Gain(float g) {
  wave.setAmplitude(g);
}


//Square wave
void Shade2(float theColor) {
  myColor2 = color(200, theColor, 50);
}

void Pitch2(float freq) {
  wave2.setFrequency(freq+200);
}

void Gain2(float g) {
  wave2.setAmplitude(g);
}

//Sine wave
void Shade3(float theColor) {
  myColor3 = color(200, theColor, 50);
}

void Pitch3(float freq) {
  wave3.setFrequency(freq+200);
}

void Gain3(float g) {
  wave3.setAmplitude(g);
}

//BPF


void mouseMoved()
{
  // map the mouse position to the range [100, 10000], an arbitrary range of passBand frequencies
  float passBand = map(mouseX, 0, width, 100, 2000);
  bpf.setFreq(passBand);
  float bandWidth = map(mouseY, 0, height, 50, 500);
  bpf.setBandWidth(bandWidth);
  // prints the new values of the coefficients in the console
  //bpf.printCoeff();
}

void toggle1(boolean g) {
  //when the toggle is on (true) the song will play
  if (g)  //if the toggle is switched on (true) the song will play
    groove.play();
  else  //if toggle is off (false) the song will pause
    groove.pause();
}
