function F = myfun(c,force)
F=0;
for i=1:size(c,2)
    F = F + c(1,i)*(force.^(i-1));
end;