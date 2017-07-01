% Illustration of polynomial fitting
% J.-S. Roger Jang 1993
function spring()
force = [1.1; 1.9; 3.2; 4.4; 5.9; 7.4; 9.2];
leng  = [1.5; 2.1; 2.5; 3.3; 4.1; 4.6; 5.0];
x = (0:0.5:11)';

for i=1:1:4
   c = ones(1,i+1).*10;   % define parameter 
    disp(strcat(num2str(i),' order coiffecients'));
   coeff = lsqcurvefit('myfun', c ,force ,leng)
 
    y=0;
   for j = 1:1:size(coeff,2)
       y = y + coeff(1,j)*(x.^(j-1));
   end
   
figure(i)
plot(x, y, '-', force, leng, '*');
axis([0 10 1 5.5]);
xlabel('Force'); 
ylabel('Length');
title(strcat(num2str(i),' order'));

end

