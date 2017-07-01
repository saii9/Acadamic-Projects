function myMotors(a,j) % to write values in to servos
    a.servoWrite(1,-1*round(j(1,1)*180/pi) + 137);      
    a.servoWrite(2,-1*round(j(1,2)*180/pi) - 35);