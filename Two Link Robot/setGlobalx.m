function setGlobalx(vx,vy)
global x
global y
global p
if p ~=0
    if(x(p)~=vx || y(p)~=vy)
        p = p + 1;
        x(p)=vx;
        y(p)=vy;
    end
else
    p = 1;
       x(p)=vx;
        y(p)=vy;    
end
