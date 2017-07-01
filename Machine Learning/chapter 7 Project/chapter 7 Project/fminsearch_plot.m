
X= [-3 : 0.25 :3];
Y= [-3 : 0.25 :3];
[x,y] = meshgrid(X,Y);
f =100*(x-y.^2).^2+(1-x).^2;
mesh(x,y,fun)
xlabel('X');
ylabel('Y');
zlabel('F');
title('the surface chapter 7');

% using fminsearch algorithm to get min

disp Initialcondition1
x0 = [-1 -5]
[x fval] = fminsearch('minsearch', x0)

disp Initialcondition2
x0=[-1.2 2]
[x fval] = fminsearch('minsearch', x0)
 
disp Initialcondition3
x0=[18 -30]
[x fval] = fminsearch('minsearch', x0)

disp Initialcondition4
x0=[35 -20]
[x fval] = fminsearch('minsearch', x0)

disp Initialcondition5
x0=[10 40]
[x fval] = fminsearch('minsearch', x0)
