function out = getSpline(p)
 l = length(p);
 sl = 0;
 
 
 for i= 1:l-1
     disp point
     disp(i)
     disp(p(i,1))
     disp(p(i,2))
     disp(p(i+1,1))
     disp(p(i+1,2))
     
     disp sloper
     
    slope = (p(i+1,2) - p(i,2))/(p(i+1,1) - p(i,1))
 if i>65
     
     disp k
 end
    
    if i ==1 
        out = [p(i,1) p(i,2)];
        p1 = [p(i,1) p(i,2)];
        sl = slope;
    else 
        if isinf([slope])
            disp naner
            if  exist('p1','var') == 0
                out = cat(1, out, [p(i,1) p(i,2)]);        
            elseif numrows(p1) < 2
                out = cat(1, out, p1);    
            else
                disp doinysplinr
                out = cat(1, out, doSpline(p1));
            end;
            
            clear p1    
            continue;
        end
        
        if sl * slope < 0 
            if slope ~= 0
            sl = slope;
            end 
            
            if  exist('p1','var') == 0
                p1 = [p(i,1) p(i,2)];                
            elseif numrows(p1) < 2
                out = cat(1, out, p1);    
            else
                out = cat(1, out, doSpline(p1));
            end
            clear p1;
            p1= [p(i,1) p(i,2)];
        else
            if exist('p1','var')
                p1 = cat(1, p1, [p(i,1) p(i,2)]);
            else
                p1= [p(i,1) p(i,2)];
            end
            if i == l-1
           
                p1 = cat(1, p1, [p(i+1,1) p(i+1,2)]);
       disp out
       size(out)
                out = cat(1, out, doSpline(p1));                       
            end
        end
    end
 end
end

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
    

%