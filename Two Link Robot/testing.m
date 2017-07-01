	deg = 180/pi; %variable to convert in to degrees
	rad = pi/180; %variable to convert in to radians

	L(1) = Revolute('d', 0,     'a', .10878, 'alpha', 0, ...
		'qlim', [125 -55] );
	L(2) = Revolute('d', .025, 'a', .1077, 'alpha', 0, ...
		'qlim', [-39 -169] );


	robot = SerialLink(L, 'name', 'robot', ...
		'manufacturer', 'Sunny', 'ikine', 'puma', 'comment', 'group 14');
       
    [w e] = textread('reco.txt'); 
        l = length(w);    
for i=1:1:l
tmat = robot.fkine([e(i) w(i)]*rad);
x(i) = tmat(1,4);
y(i) = tmat(2,4);
end
plot(x,y)