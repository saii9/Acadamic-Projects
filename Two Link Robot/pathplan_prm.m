function pathplan_prm

    cd C:\Users\Bunny\Desktop\Work\RObotics\Workplace
    load('map3.mat');

    deg = 180/pi; %variable to convert in to degrees
    rad = pi/180; %variable to convert in to radians

    a = arduino('COM10');
    a.servoAttach(1);
    a.servoAttach(2);

    L(1) = Revolute('d', 0,     'a', 0.11, 'alpha', 0, ...
        'qlim', [129 -51] );
    % calling revolute function for the second joint
    L(2) = Revolute('d', .025, 'a', 0.108, 'alpha', 0, ...
        'qlim', [-31 -151] ); % specifying the joint limits with respec to Y axis

    robot = SerialLink(L, 'name', 'robot');

    goal = [30,70];
    start = [90, 20];
    % dx = Dstar(map, 'quiet')
    dx = PRM(map);
    dx.plan();
    dx.plot();
    p=dx.path(start,goal);
x= input('path generated. Hit enter to continue')
    
for i=1:4
    x = input('Hit enter to continue with the next method');
%while true
    j = [15 -115]*rad;
    Tmatx = robot.fkine(j);
    myMotors(a,j);   
 
    if i==1
        disp ('without any interpolatioin');
        pt = p;
        close(figure(1));
        readmap(p,pt);
    x = input('Hit enter to write');
    elseif i==2
        clear p;
        disp ('with spline interpolation');
        p = isSpline(pt);
        close(figure(1));
        readmap(p,pt);
    x = input('Hit enter to write');
    elseif i==3
        clear p;
        disp ('with mstraj');
        p = mstraj(pt(2:length(pt)-1,1:2), [pt(1,1),pt(1,2)], [], [pt(length(pt),1),pt(length(pt),2)],0.05,1);
        close(figure(1));
        readmap(p,pt);
         x = input('Hit enter to write');
     elseif i==4
        clear p;
        disp ('with linear Interpolation');
        p = linearInterpolation(pt,10)
        close(figure(1));
        readmap(p,pt);
        x = input('Hit enter to write');
   p=pt;
    end
    for k=1:length(p) 
%        disp (p(k,2)/5+9.6);

        Tmatx =  cat ( 2, Tmatx(1:4,1:3),[ p(k,2)/500+.045;-1*p(k,1)/500+.10; .025; 1]);
        j = robot.ikine(Tmatx,j,[1 1 0 0 0 0]);
        Tmatx = robot.fkine(j);

        myMotors(a,j);
    end
end
% function myMotors(a,j) % to write values in to servos
%     a.servoWrite(1,-1*round(j(1,1)*180/pi) + 129);      
%     a.servoWrite(2,-1*round(j(1,2)*180/pi) - 31);
%  
