function readmap(p,k)
    figure(1)
   load('map3.mat');
    c=0
    x=zeros(100)
    y=zeros(100)
    for i=1:100

        for j = 1:100
           if (map(j,i)>0)
               c=c+1;
               x(c)=i;
               y(c)=j;
           end
        end
    end

    plot(x,y,'r.');

    hold on

    plot(p(1:length(p),1:1),p(1:length(p),2:2),'g')
    hold on
    plot(k(1:length(k),1:1),k(1:length(k),2:2),'c')

end