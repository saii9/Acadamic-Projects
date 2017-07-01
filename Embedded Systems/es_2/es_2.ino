/*H**********************************************************************
* FILENAME :        es_2.ino /version 4.0            
*
* DESCRIPTION :
*       embeddded systems 2st assignment
*
* NOTES :
*       wayne state university, Embedded Systems, Fall 2016
*       Q. http://ece.eng.wayne.edu/~smahmud/ECECourses/ECE5620/All_Semesters/F16/Assign1_ECE5620_F16.htm
*
* AUTHORS : Group 7/ [Sundeep Innamuri - fx3898, 
*                     Harshavardhan Puvvada, 
*                     Sravan Kumar Peddi]   
*
* START DATE :    27 Sep 2016
*
* CHANGES :
*
********************************************************************************/

int currval = 0;
typedef void (*FunctionCallback)(int);
int x = 1000;
int value = 0;
long lastUpdate = 0;
const int potPin = A0;

/*function pointer array for the specific switch function*/
FunctionCallback glow[] = {&glow0, &glow1, &glow1, &glow1, &glow2, &glow2, &glow2, &glow3};


//to update the seraill monitor
void giveUpdate(){
  if (millis() - lastUpdate > 2000){
    Serial.print("SW3 = ");
    digitalRead(13) ? Serial.print("Open") : Serial.print("Closed"); 
    Serial.print(" SW2 = ");
    digitalRead(12) ? Serial.print("Open") : Serial.print("Closed");  
    Serial.print(" SW1 = ");
    digitalRead(11) ? Serial.print("Open") : Serial.print("Closed");
    Serial.print(" A/D Output = ");
    Serial.print(value);  
    Serial.print(" and X = ");
    Serial.println(x);  
    lastUpdate = millis();
  }
}

//function to read the pot
int readPot(){
  value = analogRead(potPin);
  x = (int)(value*800.0/1024.0 + 200);
  return value;
}
  
/*to read innput from the input pins*/
int readinput(){
  int newval = digitalRead(13)?4:0; 
  newval += digitalRead(12)?2:0;
  newval += digitalRead(11)?1:0;
  return newval;
}


/*returns the delay time*/
int ftime(int numflash, int period){
  return period/2/numflash;
}


/*Simulates delay function while performing other tasks*/
int engage(int interval){
  
  unsigned long curMillis = millis(), prevMillis = millis();  
  while(curMillis - prevMillis < interval){
    curMillis = millis();
    giveUpdate();
    if(currval != readinput()) {
      return 1;
    }
  }
  readPot();
  return 0;
}


/*Continuously flash all 5 LEDs at 1 flash/sec*/
void glow0(int input){
int i=0;
  while(1){
    for(i = 0; i < 5 ; i++){
      digitalWrite(2+i, HIGH);
    }
    if (engage(100)) return;
    for(i = 0; i < 5 ; i++){
      digitalWrite(2+i, LOW);
    }
    if (engage(100)) return;
  }
}


/*
STEP1: Flash LED1 at 1 flash/second for 2 seconds.
       Then flash LED2 at 1 flash/second for 2 seconds. 
       Then do the same for LED3, and so on until you flash LED5.
STEP2: Now go in the reverse direction, meaning flash LED4 at 1 flash/second for 2 seconds. 
       Then flash LED3 at 1 flash/second for 2 seconds. And so on until you flash LED1.
       
Continuously repeat STEP1 and STEP2
this function also provides functionality for differnt rate of flashing
*/

void glow1(int input){
  int numflash = 5;                    // no of  flash/ no of seconds
  
  if (input == 1)     numflash = 5;                    // nnumflasho of  flash/ no of seconds
  else if(input == 2) numflash = 10;                    // no of  flash/ no of seconds
  else if(input == 3) numflash = 15;                    // no of  flash/ no of seconds
 
  int ubound = 6;
  int lbound = 2;
  int i = lbound;
  int flashtime = ftime(numflash, 1000);     // flash time
  int course = 0 ;                      // 0 for ascending 1 for descending 
  
  while(1){
    int j = 0;
    int k = 0;
    long y = millis();
    
    while(millis() - y < x){
        digitalWrite(i, HIGH);
        if (engage(flashtime)) return;
        digitalWrite(i, LOW);
        if (engage(flashtime)) return;
    }
    if (i == lbound){
      course = 0;
    }
    
    if (i == ubound){
      course = 1;
    }
    course ? i-- : i++;
  }
}


/*
This time the flash rate will be 1 flash/second, but the LEDs should be controlled as
Simultaneously flash LED1 and LED5 for 2 seconds. 
Then simultaneously flash LED2 and LED4 for 2 seconds. 
Then flash only LED3 for 2 seconds.  Then simultaneously flash LED2 and LED4 for 2 seconds.

Continuously repeat the above process.
this function also provides functionality for differnt rate of flashing
*/

void glow2 (int input){
    int numflash = 1;                        // no of  flash/ no of seconds
    
   if (input == 4)       numflash = 5;                            // no of  flash/ no of seconds
   else if(input == 5)  numflash = 10;                           // no of  flash/ no of seconds
   else if(input == 6)  numflash = 15;                           // no of  flash/ no of seconds
   
  int ubound = 4;
  int lbound = 2;
  int i = lbound;
  int flashtime = ftime(numflash, 1000);     // flash time
  int course = 0 ;                           // 0 for ascending 1 for descending 

  while(1){
    int j = 0;
    int k = 0;
    long y = millis();
  
    while(millis() - y < x){
        digitalWrite(i, HIGH);
        digitalWrite(4 + 4 - i, HIGH);
        if (engage(flashtime)) return;
        
        digitalWrite(i, LOW);
        digitalWrite(4 + 4 - i, LOW);
        if (engage(flashtime)) return;
    }
    if (i == lbound){
      course = 0;
    }
    
    if (i == ubound){
      course = 1;
    }
    course ? i-- : i++;
  }
}


/*
This time all 5 LEDs will flash simultaneously, but each LED will flash at a different rate as shown below.
LED1 will flash at 1 flash/sec,  LED2 will flash at 2 flashes/sec, LED3 will flash at 3 flashes/sec,  
LED4 will flash at 4 flashes/sec, and  LED5 will flash at 5 flashes/sec,
*/

void glow3(int input){
  //This time all 5 LEDs will flash simultaneously, but each LED will flash at a different rate as shown below.
  //LED1 will flash at 1 flash/sec,  LED2 will flash at 2 flashes/sec, LED3 will flash at 3 flashes/sec,  LED4 will flash at 4 flashes/sec, and  LED5 will flash at 5 flashes/sec,
  struct flash {
    int ledpin;
    int timedelay;
    int mode;
    unsigned long lastchange;
  };
  int potChange = readPot();
  struct flash vflash[5]= { {2,ftime(1,x),1,0}, {3,ftime(2,x),1,0}, {4,ftime(3,x),1,0}, {5,ftime(4,x),1,0}, {6,ftime(5,x),1,0} }; 
  int j = 0;
  int i = 0;
    
  while(1){
    for(i = 0; i < 5; i++){
        if(readPot() != potChange){
          potChange = readPot();
          for (j = 0; j < 5; j++){
            (*(vflash + j)).timedelay = ftime(j +1,x);
          }
        }
        if(millis() - (*(vflash + i)).lastchange >= (*(vflash + i)).timedelay ){
          digitalWrite((*(vflash + i)).ledpin, (*(vflash + i)).mode ? --(*(vflash + i)).mode : ++(*(vflash + i)).mode );
          (*(vflash + i)).lastchange = millis();
        }
      }
    if(currval != readinput()) return ;
   giveUpdate();
   }
}

/* to initialize the pins*/
void setup() {
  Serial.begin(9600);  
  pinMode(11, INPUT);
  pinMode(12, INPUT);
  pinMode(13, INPUT);
  pinMode(potPin, INPUT);
  readPot(); 
  int i=0;
  for(i = 0; i < 5 ; i++){
    pinMode(2+i, OUTPUT);
  }
}

/*to reset the led incase of switch change*/
void resetled(){
  int i = 0;
  for(i = 0; i < 5 ; i++){
    digitalWrite(2+i, LOW);
  }  
}


/* looping fucnction to loop the code */
void loop() {
  readPot(); //reading potentiometer
  currval = readinput();  // reading swithes
  glow[currval](currval);
  resetled();
}



