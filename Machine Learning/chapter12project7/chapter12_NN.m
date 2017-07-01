point_count = 6;
x = linspace(1, 6, point_count);
y = linspace(1, 6, point_count);
z = linspace(1, 6, point_count);
train_data = zeros(length(x)*length(y)*length(z), 4);
count = 1;
for i = x,
  for j = y;
    for k = z;
      out = (1+i^0.5+j^(-1)+k^(-1.5))^2;
      train_data(count, :) = [i j k out];
      count = count + 1;
    end
  end
end
P=[train_data(:,[1,2,3])]';
T=[train_data(:,4)]';
network = newff([1 6;1 6;1 6],[10 1],{'tansig' 'purelin'});
Y = sim(network,P);
network.trainParam.goal= 0.0;
network.trainParam.epochs = 200;
network = train(network,P,T);
point_count = 5;
x = linspace(1.5, 5.5, point_count);
y = linspace(1.5, 5.5, point_count);
z = linspace(1.5, 5.5, point_count);
chk_data = zeros(length(x)*length(y)*length(z), 4);
count = 1;
for i = x,
  for j = y;
    for k = z;
      out = (1+i^0.5+j^(-1)+k^(-1.5))^2;
      chk_data(count, :) = [i j k out];
      count = count + 1;
    end
  end
end
Packing = [chk_data(:,[1,2,3])]';
Testing=[chk_data(:,4)]';
Yck = sim(network,Packing);
Y = sim(network,P);
figure(1);
plot(Yck(1,:)-Testing,'k');
title('checking data error');
xlabel('time');
figure(2);
plot(Y(1,:)-T,'r');
title('training data error');
xlabel('time');
sum=0;
for i= 1 :size(T,2)
    sum=(abs(T(i)-Y(i))/abs(T(i)))+sum;
end
APE=sum/size(T,2)
sum=0;
for i= 1 :size(Testing,2)
    sum=(abs(Testing(i)-Yck(i))/abs(Testing(i)))+sum;
end
APEck=sum/size(T,2)
