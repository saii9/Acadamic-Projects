
x = p(1:numrows(p),1:1);
y = p(1:numrows(p),2:2);
k = 5; % quintic spline as you desire
sp = spapi( optknt(x',k), x', y' );
xx = 0:.005:1; % desired sampling
yy = fnval(xx,sp);
plot (xx,yy) %
Good Luck