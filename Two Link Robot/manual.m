rx=0*pi/180;
ry=0*pi/180;
rz=90*pi/180;

rxm=[ 1 0 0 ; 0 cos(rx) -sin(rx) ; 0 sin(rx) cos(rx)];
rym=[ cos(ry) 0 -sin(ry) ; 0 1 0 ; sin(ry) 0 cos(ry)];
rzm=[ cos(rz) -sin(rz) 0 ; sin(rz) cos(rz) 0 ; 0 0 1];

aRb = rzm * rym * rxm; %this is the required matrix
Tb = [ 10 0 0]';
Tb1 = cat ( 1 , Tb , [ 1 ]' ); 
aRTb = cat( 2 , aRb , Tb );
aRTbh = cat( 1 , aRTb , [ 0 0 0 1 ] )



%{ To find the vector P form Frame A
%{
Pb = [ x y z ]';
Pb1 = cat( 1 , pa , [1]' );
aPb1 = aRTb1 * pb1 ;
%}

bRa = Inverse_tran( aRTbh) 
