clc;
clear all;
close all;
g=2:.01:128;
cm=.085*10^-15;
cd=.07*10^-15;
rm=2.5;
rd=35;
N=128;
l=((N./2*rm*cm)+((N./g)*rd*cd)+((g+2)*rd*cd)+((g+1)*rm*cm));
plot(g,l);
grid on;
title('variation of delay with grouping')
xlabel('no of bits in a group')
ylabel('bitline delay(sec)')