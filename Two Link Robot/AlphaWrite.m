
deg = 180/pi; %variable to convert in to degrees
rad = pi/180; %variable to convert in to radians
%{
a = arduino('COM4');
a.servoAttach(1);
a.servoAttach(2);
a.servoAttach(5);
a.servoWrite(5,30);

%a.servoWrite(1,50);
%a.servoWrite(2,51);
a.servoWrite(5,115);
%}
j1 = 85;
j2= -86;

%a.servoWrite(2,-1*round(j2,0) - 39);
%a.servoWrite(1,-1 * round(j1,0) + 125);

L(1) = Revolute('d', 0,     'a', .10878, 'alpha', 0, ...
    'qlim', [125 -55] );
L(2) = Revolute('d', .025, 'a', .1077, 'alpha', 0, ...
    'qlim', [-39 -169] );

robot = SerialLink(L, 'name', 'robot');

[w e] = textread('97.txt');
l = length(w);
disp k;
for i=1:1:1
Tmat = robot.fkine ([j1 j2]*rad);
Tmat
%Tmat =  cat ( 2, Tmat(1:4,1:3),[11+w(i); 11+e(i); 2.5; 1]) ;
[qt, hist] = robot.ikine(Tmat,[j1 j2]*rad,[1 1 0 0 0 0])

end;
