x = 0:1:100;
y=exp(x.*(6.5/200)).*sin(x.*(6.5/100));

a = readfis('mamdani.fis');
[xa ya za]= gensurf(a);

figure(1);
plot(xa,za,'r');
hold on
plot(x,y,'b');

title('mamdani FIS: red - F(x)/ blue - f(x)')
grid on;


b = readfis('sugeno.fis');
[xb yb zb]= gensurf(b);

figure(2);
plot(xb,zb,'r');
hold on
plot(x,y,'b');

title('sugeno FIS: red - F(x)/ blue - f(x)')
grid on;
