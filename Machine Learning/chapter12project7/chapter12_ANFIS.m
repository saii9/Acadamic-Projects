mf_count=2;
epoch_count=200;
point_count = 6;
x = linspace(1, 6, point_count);
y = linspace(1, 6, point_count);
z = linspace(1, 6, point_count);
train_data = zeros(length(x)*length(y)*length(z), 4);
count = 1;
for i = x,
  for j = y;
    for k = z;
      output = (1+i^0.5+j^(-1)+k^(-1.5))^2;
      train_data(count, :) = [i j k output];
      count = count + 1;
    end
  end
end
point_count = 5;
x = linspace(1.5, 5.5, point_count);
y = linspace(1.5, 5.5, point_count);
z = linspace(1.5, 5.5, point_count);
chk_data = zeros(length(x)*length(y)*length(z), 4);
count = 1;
for i = x,
  for j = y;
    for k = z;
      output = (1+i^0.5+j^(-1)+k^(-1.5))^2;
      chk_data(count, :) = [i j k output];
      count = count + 1;
    end
  end
end
ss = 0.1;
ss_drate = 0.9;
ss_irate = 1.1;
mf_type = 'gbellmf';
input_mat = genfis1(train_data, mf_count, mf_type);
[train_out_fmat train_error step_size chk_output_fismat chk_error] = ...
anfis(train_data, input_mat, ...
[epoch_count nan ss ss_drate ss_irate], [1,1,1,1], chk_data);

figure(1);
plotmf(input_mat, 'input', 1);
title('Initial Membership-Function X, Y and Z');
grid on;

figure(2);
plotmf(train_out_fmat, 'input', 1);
title('Initial Membership-Function Y');
grid on;

figure(3);
plotmf(train_out_fmat, 'input', 2);
title('Final Membership-Function X');
grid on;

figure(4);
plotmf(train_out_fmat, 'input', 3);
title('Final Membership-Function Y');
grid on;

figure(5);
plot(1:epoch_count, [train_error chk_error]);
legend('training error', 'checking error');
xlabel('epoch num'); 
ylabel('RMS error');
title('error curve');
grid on;

figure(6);
plot(1:epoch_count, step_size);
xlabel('epoch num');
ylabel('step');
title('step size curve');
grid on;
