function out = linearInterpolation( p, d )
     out = [p(1,1) p(1,2)];
    for i = 1:length(p)-1
        m = (p(i+1,2) - p(i,2))/(p(i+1,1) - p(i,1));%caluculating slope
        
        c = p(i,2) - m *p(i,1)
        dx = (p(i+1,1) - p(i,1))/d;
        out = cat(1, out, [p(i,1) p(i,2)])            
        for j= 1:d
            out = cat(1, out, [(p(i,1) + dx*j) (m*(p(i,1) + dx*j)+c)]);
        end
       
    end

end

