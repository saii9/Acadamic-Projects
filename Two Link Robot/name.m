total = 0;
res =0;

for i= 0:7
    for j= 0:7
        for k= 0:7
            for l= 0:7
                c = 0;
                c = abs(k-i) + abs(l-j);
                total = total + c;
                res = res + c - 1;
            end
        end
    end
end


(246/40) +(res*.25/(8*8*8*8))


