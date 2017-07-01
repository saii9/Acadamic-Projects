clc
clear L
clear all
run startup_rvc.m

deg = 180/pi; %variable to convert in to degrees
rad = pi/180; %variable to convert in to radians

pen_up = 30;
pen_break = 70;
pen_down = 115;

xposmax =9;
xposmin=0;
yposmax=-9;
yposmin=-9;

xpos=9;
ypos=9
%
% Link1 code
%
L(1) = Revolute('d', 0,     'a', .10878, 'alpha', 0, ...
    'qlim', [125 -55] );
L(2) = Revolute('d', .025, 'a', .1077, 'alpha', 0, ...
    'qlim', [-39 -169] );


robot = SerialLink(L, 'name', 'robot', ...
    'manufacturer', 'Sunny', 'ikine', 'puma', 'comment', 'group 14');

%
a = arduino('COM10');

a.servoAttach(5);
a.servoWrite(5,pen_up);
a.servoAttach(1);
a.servoAttach(2);
%}

    [w e] = textread('sign.txt'); 
    l = length(w);    

        xpos=9;
        ypos=9;
        j = [99*rad  -108*rad];
        Tmatx = robot.fkine (j)
        Tmatx =  cat ( 2, Tmatx(1:4,1:3),[xpos/100; ypos/100; .025; 1]) ;
         j = robot.ikine(Tmatx,j,[1 1 0 0 0 0])
         jx = j;
         a.servoWrite(2,-1*round(j(1,2)*deg,0) - 39);
         a.servoWrite(1,-1*round(j(1,1)*deg,0) + 125);
         Tmat = Tmatx


    for i=1:1:l
        Tmat =  cat ( 2, Tmat(1:4,1:3),[xpos/100+e(i)/100; ypos/100+(1-w(i))/100; 2.5; 1]) ;
        j = robot.ikine(Tmat,j,[1 1 0 0 0 0])
        if(i==1)
              pause(.2);
            a.servoWrite(5,pen_down);
        end
        a.servoWrite(2,-1*round(j(1,2)*deg,0) - 39);
        a.servoWrite(1,-1*round(j(1,1)*deg,0) + 125);
     
        if(i==l)
                    a.servoWrite(5,pen_break);
        end;
    end;
a.servoWrite(5,pen_up);

clear L
