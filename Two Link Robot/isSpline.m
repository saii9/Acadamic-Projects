function out = isSpline(p)
 l = length(p);
 breakpoint = 0;
     for i= 2:l
        for j = breakpoint(length(breakpoint)):i-1
                if j ==0
                    j=1;
                end
            if (p(j,1) == p(i,1))
                
                breakpoint = cat(1, breakpoint, i);
                break;
            end
        end 
     end  
     
     out = [p(1,1) p(1,2)];
     breakpoint(1) = 1;
     breakpoint = cat(1, breakpoint, length(p)+1);
    for i=2:length(breakpoint)
        if breakpoint(i) - breakpoint(i-1) > 1
                        out = cat(1, out, doSpline(p(breakpoint(i-1) :breakpoint(i)-1,1:2)));        
        else
            if i==length(breakpoint)
            
            else

                cat(1, out, [p(breakpoint(i),1) p(breakpoint(i),2)])            
            end
        end
    end
    cat(1, out, [p(length(p),1) p(length(p),2)])
end
function xx = doSpline(p1)
    try
    x = p1(1:numrows(p1),1:1);
    y = p1(1:numrows(p1),2:2);
    if p1(numrows(p1),1) < p1(1,1)
        d = -0.1;
    elseif(p1(numrows(p1),1) > p1(1,1))
            d=.1;
    end
    
    xx = p1(1,1):d:p1(numrows(p1),1);
    yy = spline(x,y,xx);
    xx = cat(2, xx', yy');
           
    catch me
disp exp
        p1
    end
end
    