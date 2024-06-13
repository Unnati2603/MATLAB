1   clc;
clear all;
close all;
am=10;
ac=20;
fc=10;
fm=1;

t=0:0.001:5;

f1=1\t;
m=am.*cos(2.*pi.*fm.*t);
subplot(6,1,1);
plot (m);
title("Message Signal");

c=ac.*cos(2.*pi.*fc.*t);
subplot(6,1,2);
plot (c);
title("Carrier Signal");

y=m.*c;
subplot(6,1,3);
plot(y);
title("DSBSC Signal");

%demodulatiion of dsbsc
s1=y.*c;
[b,a]=butter(5,0.1);
s2=filter(b,a,s1);
subplot(6,1,4 );
plot(s2);
title("Demodulation of DSBSC");
