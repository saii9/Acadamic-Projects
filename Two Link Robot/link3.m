
clear L
deg = pi/180;
L(1) = Revolute('d', 0,     'a', 5, 'alpha', 1.571);%, ...
   % 'qlim', [140 -40]*handles.deg );
% calling revolute function for the second joint

L(2) = Revolute('d', 0, 'a', 10, 'alpha', 0);%, ...rorr
 %   'qlim', [-25 -175]*handles.deg ); % specifying the joint limits with respec to Y axis

% L(3) = Revolute('d', 0, 'a', 5, 'alpha', 0);%, ...
 %   'qlim', [-25 -175]*handles.deg ); 

 link_3 = SerialLink(L, 'name', 'link_3');
 
 q = [pi pi/2];
 
T = link_3.fkine(q)