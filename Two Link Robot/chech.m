k = 96

for i=1:26
    j=i+k;
    [w e]= textread(strcat(num2str(j),'.txt'));
    plot(w,e)
pause(.5);
end;