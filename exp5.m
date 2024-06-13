clc;
close all;
clear all;
% parameters

fs=10000;
ac=1;
am=1;
fm=1;
fc=10;
b=10;
t=[-10:0.001:10];

mt=am.*cos(2.*pi.*fm.*t);
subplot(4,1,1);
plot(t, mt);
title("Message Signal");

ct=ac.*cos(2.*pi.*fc.*t);
subplot(4,1,2);
plot(t, ct);
title("Carrier Signal");


sfmt=ac .*cos(2.*pi.*fc.*t+b.* sin(2.*pi.*fm.*t));
subplot(4,1,3);
plot(t, sfmt);
title("fm");

%demodulation
differen=diff(sfmt);
%envelope detector
yt=hilbert(differen);
demod=abs(yt);

subplot(4,1,4);
plot(t(1:end-1),demod);
title("demod");

