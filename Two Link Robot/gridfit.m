
function out = isSpline(p)
 l = length(p);
 sl = 0;
 breakpoint = 0;
     for i= 1:l-1
        for j = breakpoint(length(breakpoint)):i
                if j ==0
                    j=1;
                end
            if (p(j,1) == p(i,1)) && (p(j,2) == p(i,2))
                breakpoint = cat(1, breakpoint, i);
            end
        end 
     end     
end

function xx = doSpline(p1)
    try
    x = p1(1:numrows(p1),1:1);
    y = p1(1:numrows(p1),2:2);
    if p1(numrows(p1),1) < p1(1,1)
        d = -0.25;
    elseif(p1(numrows(p1),1) > p1(1,1))
            d=.25;
    end
    
    xx = p1(1,1):d:p1(numrows(p1),1);
               disp xx
       size(xx)
    yy = spline(x,y,xx);
           disp yy
       size(yy)
    xx = cat(2, xx', yy');
           disp xx1
       size(xx)
    catch me
disp exp
        p1
    end
end
    