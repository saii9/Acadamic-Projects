f =3.*(1-X).^2.*exp(-X.^2-(Y+1).^2)-10.*(X/5-X.^3-Y.^5).*exp(-X.^2-Y.^2)-1/3.*exp(-(X+1).^2-Y.^2);
[X,Y] = meshgrid(-3:3);
mesh(X,Y,f)
axis([-3 3 -3 3 -10 10])
title('project 6')