function getMouse
C = set (gcf, 'WindowButtonMotionFcn', @mouseMove); % to listen to mous3e
%plot(round(C(1,1),2), round(C(1,2),2));
plot(0,0,'r*');
xlim([.4 .7]);
ylim([0 1.2]);
xlabel('x')


function C = mouseMove (object, eventdata)
filename = '108.txt';

C = get (gca, 'CurrentPoint');
fid=fopen(filename,'a');% opening a file

format = '%f %f\n';% format
fprintf(fid,format,round(C(1,1),4),round(C(1,2),4));
fclose(fid); %closing file

xlim(gca,[0 1]);
ylim(gca,[0 1.2]);
title(gca, ['(X,Y) = (', num2str(round(C(1,1),3)), ', ',num2str(round(C(1,2),3)), ')']);
   