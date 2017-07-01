function write14
	clc
	clear L
	clear all
	run startup_rvc.m

	deg = 180/pi; %variable to convert in to degrees
	rad = pi/180; %variable to convert in to radians

	pen_up = 30
	pen_break = 70;
	pen_down = 95;
	motor1 =1; 
	motor2 =2;
	motor3 =5;

	xposmax =19;
	xposmin=0;
	yposmax=9;
	yposmin=-9;

	xpos=9;
	ypos=9
	
fid = fopen('reco.txt','w');
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

	a.servoAttach(motor3);
	a.servoWrite(motor3,pen_up);
	a.servoAttach(motor1);
	a.servoAttach(motor2);
	%}

	disp k;
	text='hi dorothy how are u';
	textascii = double(text);

    for k=1:length(textascii)
        disp(textascii(k));
    
        if ((textascii(k)<97 && textascii(k)~=32) || (textascii(k)>122))
            continue;
        end
        
        disp(num2str(textascii(k)))
        [w e] = textread(strcat(num2str(textascii(k)), '.txt')); 
        l = length(w);    

        if (k==1)
            xpos=17;
            ypos=9;
            j = [50*rad  -66*rad];
            Tmatx = robot.fkine (j)
            Tmatx =  cat ( 2, Tmatx(1:4,1:3),[xpos/100; ypos/100; .025; 1]) ;
             j = robot.ikine(Tmatx,j,[1 1 0 0 0 0])
             jx = j;
             myMotors(a,j,fid);
             Tmat = Tmatx
        else
            ypos = ypos - 1

            if (ypos < yposmin)
                xpos = xpos -1;
                ypos = yposmax;

                Tmatx =  cat ( 2, Tmatx(1:4,1:3),[xpos/100; ypos/100; 2.5; 1]) ;
                jx = robot.ikine(Tmatx,jx,[1 1 0 0 0 0])
                j = jx;
                Tmat = Tmatx;
                myMotors(a,j,fid);
            else

                Tmat =  cat ( 2, Tmat(1:4,1:3),[xpos/100; ypos/100; 2.5; 1]) ;
                j = robot.ikine(Tmat,j,[1 1 0 0 0 0]);
                myMotors(a,j,fid);
            end;
        end;
        
        for i=1:1:l
            Tmat =  cat ( 2, Tmat(1:4,1:3),[xpos/100+e(i)/100; ypos/100+(1-w(i))/100; 2.5; 1]) ;
             j = robot.ikine(Tmat,j,[1 1 0 0 0 0])
            
             if(i==1)

                   myMotors(a,j,fid)
                   a.servoWrite(motor3, pen_down);
              
             else if (w(i) == 0)
                    
                        a.servoWrite(motor3, pen_break);
                        Tmat =  cat ( 2, Tmat(1:4,1:3),[xpos/100+e(i+1)/100; ypos/100+(1-w(i+1))/100; 2.5; 1]) ;
                        j = robot.ikine(Tmat,j,[1 1 0 0 0 0]);

                        myMotors(a,j,fid)
                        i = i+1;

                        a.servoWrite(motor3, pen_down);
            else

                myMotors(a,j,fid)
                 end
            if(i==l)
                        a.servoWrite(motor3, pen_break);
            end;
        end;
    end;
    end;
    
	a.servoWrite(motor3, pen_up);

	clear L;
    fclose(fid);
    function myMotors(a,j,fid)
        
	deg = 180/pi; %variable to convert in to degrees
	rad = pi/180; %variable to convert in to radians
        
        format='%f %f\n';
        a.servoWrite(1,-1*round(j(1,1)*deg,0) + 125);
                      
        a.servoWrite(2,-1*round(j(1,2)*deg,0) - 39);
                
                fprintf(fid,format,round(j(1,2)*deg,0),round(j(1,1)*deg,0));
       