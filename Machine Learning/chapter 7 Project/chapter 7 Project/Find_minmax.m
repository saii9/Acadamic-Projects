% Finding Local and Global Maxima and Minima
lowerbound = -3;
upperbound =  3;

globalminf=0;
globalminx=[0 0];
globalmaxf =0;
globalmaxx=[0 0];

for x=-3:.5:2.5
    k = '';
    k= strcat(k,strcat('intervel[',strcat(num2str(x),strcat(',',strcat(num2str(x+.5),']')))));
    disp(k);
    disp('--------------------')
    x0=[x,x+.5];  %starts at x0
    [x,fval] = fmincon(@negfun,x0,[],[],[],[],lowerbound,upperbound)
    if(-1*fval > globalmaxf)
        globalmaxf = -1*fval;
        globalmaxx = x;
    end;
    [x,fval] = fmincon(@posfun,x0,[],[],[],[],lowerbound,upperbound)
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