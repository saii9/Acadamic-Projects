clear L
deg = pi/180;
%
% Link1 code
%
L(1) = Revolute('d', 0, 'a', 5, 'alpha', 1.57); 
    
%
% Link2 code
%
L(2) = Revolute('d', 0, 'a', 10, 'alpha', 0);
   
%
link = SerialLink(L, 'name', 'link', ...
    'manufacturer', 'Praneeth');

link.model3d = 'Praneeth/link';
