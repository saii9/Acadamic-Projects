C = set (gcf, 'WindowButtonMotionFcn', get (gca, 'CurrentPoint'));

set(gca,'XLimMode','manual','YLimMode','manual');  % Fix axes limits
hold on;
while 1
[x,y] = ginput(1);  % Select a point with the mouse
plot([x x],get(gca,'YLim'),'k--');  % Plot dashed line
plot(x,y,'r*');     % Mark intersection with red asterisk
disp('Intersection coordinates:');
disp([x y]);        % Display the intersection point
end