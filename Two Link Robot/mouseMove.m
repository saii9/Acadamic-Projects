function getM
C = set (gcf, 'WindowButtonMotionFcn', @mouseMove);
%plot(round(C(1,1),2), round(C(1,2),2));
plot(0,0,'r*');
xlim([0 10]);
ylim([0 1]);
xlabel('x')

