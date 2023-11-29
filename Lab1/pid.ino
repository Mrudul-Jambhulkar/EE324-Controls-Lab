int ENA = 4;
int IN1 = 3;
int IN2 = 2;

int sensed_output;
int control_signal;
int setpoint;
double Kp = 5;      //proportional gain
double Ki = 0.000000001;      //integral gain
double Kd = 2;      //derivative gain


int total_error=0;
int last_error=0;



int h=540; // it is the value corresponding to 180 degree rotation

void setup() {
  
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(A3, INPUT);

  Serial.begin(9600);

  //Potentiometer reading is recieved at A3;
  //IN1 and IN2 are input to motor terminals;
  
  int volt = analogRead(A3);
  /* Calculating the setpoint(point to reach after rotation of 180 degrees)
  To avoid going into non linear region we subtract h when initial starting point is 
  greater than h */
  
  
  
  
  if (volt<=h){
      setpoint=volt+h;
  }
  if (volt>h){
    setpoint=volt-h;
  }

   
 
}


void loop() {


  
  sensed_output = analogRead(A3);

    //delta time interval
  int error = (setpoint - sensed_output);
  total_error += error ;          //accumalates the error - integral term
  double delta_error = (error - last_error);  //difference of error for 
                                                derivative term

  
  
  control_signal = Kp * error + (Ki * total_error) + (Kd) * delta_error;  
  //PID control compute
 //we need to make sure the control signal doesn't exceed 255
  if (control_signal>=255)  
  {
    control_signal = 255;
  }
  if (control_signal <= -255)
  {
    control_signal = -255;
  }

  if (control_signal >=0){                //Setting the PWN value
                                          and direction of rotation
    analogWrite(IN2, (control_signal));
    analogWrite(IN1, 0);
  }
  
  // if control signal is negative then reverse the terminals
  
  else{
    analogWrite(IN1, -1*(control_signal));
    analogWrite(IN2, 0);
  }
  

  
  Serial.print(sensed_output);
  Serial.print(", ");
  Serial.println(control_signal);


  last_error = error;
}