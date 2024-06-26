clc;
close all;
Fm=input('Fm:');
Fc=input('Fc:');
Am=input('Am:');
Ac=input('Ac:');
tc=1/Fc;
tm=1/Fm;
t=-2:0.001:2;
f=-2:0.001:2;
mt= Am*cos(2*pi*Fm*t);
ct= Ac*cos(2*pi*Fc*t);
st=mt.*ct;
tSamp=0.001;
fSamp=1/tSamp;
ord=6;
wn=Fc/(fSamp/2);
[b,a]=butter(ord,wn,'low');
LPin=st.*ct;
MsgRec=filter(b,a,LPin);
subplot(5,1,1);
plot(t,ct);
title('Carrier Signal');
xlabel('Time(s)');
ylabel('Amplitude');
subplot(5,1,2);
plot(t,mt);
title('Message Signal');
xlabel('Time(s)');
ylabel('Amplitude');
subplot(5,1,3);
plot(t,st);
title('Modulated Signal');
xlabel('Time(s)');
ylabel('Amplitude');
subplot(5,1,4);
plot(t,LPin);
title('Input to LPF');
xlabel('Time(s)');
ylabel('Amplitude');
subplot(5,1,5);
plot(f,MsgRec);
title('After passing through LPF');
xlabel('freq(Hz)');
ylabel('Amplitude');