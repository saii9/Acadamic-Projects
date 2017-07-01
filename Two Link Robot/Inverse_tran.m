
function bRa = Inverse_tran( aRTbh) 
%{TO find the inverse of a homogeneous transform
aRb = aRTbh(1:3,1:3);
Tb = aRTbh(1:3,4:4);
bRa = cat( 1 , cat ( 2, aRb' , -1 .* aRb' * Tb ) , [ 0 0 0 1 ] );
end