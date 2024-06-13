clc;
clear all;
close all;

%generation of lines
Fm1=input('Enter Fm1:');
Am1=input('Enter Am1:');
Fm2=input('Enter Fm2:');
Am2=input('Enter Am2:');
Fs=input('Enter Fs:');
tm1=1/Fm1;
tm2=1/Fm2;
tres=0.001;
t=-3:tres:3;

Ts=1/Fs;
mt1= Am1*cos(2*pi*Fm1*t);
mt2= Am2*cos(2*pi*Fm2*t);

it1=zeros(size(t));
it1(1:round(Ts/tres):end)=1;

it2=zeros(size(t));
it2(round(Ts/2/tres):round(Ts/tres):end)=1;
sampled1=it1.*mt1;
sampled2=it2.*mt2;

signal=sampled1+sampled2;


sum1=zeros(size(t));
sum2=zeros(size(t));
for i=round(Ts/2/tres):round(Ts/tres):length(t)
    sum2(i)=signal(i);
end
for i=1:round(Ts/tres):length(t)
    sum1(i)=signal(i);
end

maximum = max(Fm1,Fm2);

[b, a] = butter(10, maximum/Fs, 'low');
% Demultiplexing using matched filter
rec1 = filter(b, a, sampled1) / Ts;
rec2 = filter(b, a, sampled2) / Ts;

%messagesignal
subplot(4,1,1);
plot(t,mt1,'r');
title('Message Signal 1');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

%impulse train 1
subplot(4,1,2);
plot(t,it1,'r');
title('Impulse Train 1');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

%message signal 2
subplot(4,1,3);
plot(t,mt2,'b');
title('Message Signal 2');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

%impulse train 2
subplot(4,1,4);
plot(t,it2,'b');
title('Impulse Train 2');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

figure;
%sampled signal
subplot(3,1,1);
plot(t,sampled1,'r');
title('First Sampled Signal');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

%sampled signal
subplot(3,1,2);
plot(t,sampled2,'b');
title('Second Sampled Signal');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

%tdm signal
subplot(3,1,3);
plot(t,sampled1, 'r',t,sampled2,'b');
title('Time Division Multiplexed Signal');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

figure;
subplot(4, 1, 1);
plot(t, sum1,'r');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
title('Demultiplexed Signal 1');
grid on;

subplot(4, 1, 2);
plot(t, sum2,'b');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
title(' Demultiplexed Signal 2');
grid on;

subplot(4, 1, 3);
plot(t, rec1, 'r');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
title('Reconstructed Message Signal 1');
grid on;

subplot(4, 1, 4);
plot(t, rec2, 'b');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
title('Reconstructed Message Signal 2');
grid on;