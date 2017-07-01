% Finding Local and Global Maxima and Minima
lowerbound = -3;
upperbound =  3;
[x,fval] = ga(@negfun,2,[],[],[],[],lowerbound,upperbound);% for maximum
disp maximum
[x -1*fval]
disp minimum
[x fval]


for x=-3:.5:2.5
    k = '';
    k= strcat(k,strcat('intervel[',strcat(num2str(x),strcat(',',strcat(num2str(x+.5),']')))));
    disp(k);
    disp('--------------------')
    x0=[x,x+.5];  %starts at x0
    lowerbound=x;
    upperbound=x+.5;
    disp maximum
    
    [x,fval] = ga(@negfun,2,[],[],[],[],lowerbound,upperbound);% for maximum;
    x
    -1*fval
    if(-1*fval > globalmaxf)
        globalmaxf = -1*fval;
        globalmaxx = x;
    end;
    disp minimum
    [x,fval] = ga(@posfun,2,[],[],[],[],lowerbound,upperbound)
    if(fval < globalminf)
        globalminf = fval;
        globalminx = x;
    end;
end 
disp('global max');
globalmaxf
globalmaxx

disp('global min');
globalminf
globalminx