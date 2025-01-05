
clc; clear all; close all;
% Delta Modulation and Demodulation
N = 10000; % Number of element in the time array
Fm = input('Frequency of the Message Signal = ');
Fs = input('Sampling Frequency = ');
Am = input('Amplitude of the message signal = ');



Tm = 1/Fm; Ts = 1/Fs;
t = 0:Tm/N:Tm;
m = Am.*(sin(2.*pi.*Fm.*t))+0.00001;o
subplot(2,1,1); plot(t,m);
xlabel('Time'); ylabel('Amplitude');
delta = 2.*pi.*Am.*(Fm./Fs);
stair = zeros(1,length(t)); bitseq = zeros(1,length(t));
for n=1:1:length(t)
 if t(n) == 0
 e(n) = m(n);
 eq(n) = delta.*sign(e(n));
 stair(1,n) = eq(n);
 bitseq(1,n) = sign(e(n));
 else if mod(t(n),Ts) == 0
 e(n) = m(n)- stair(1,n-1);
 eq(n) = delta.*sign(e(n));
 stair(1,n) = stair(1,n-1)+eq(n);
 bitseq(1,n) = sign(e(n));
 else
 stair(1,n) = stair(1,n-1);
 bitseq(1,n) = bitseq(1,n-1);
 end
 end
end
hold on;
subplot(2,1,1); plot(t,stair);
hleg = legend('Original Signal', 'Staircase approximated Signal');
subplot(2,1,2);
plot(t,bitseq);
xlabel('Time'); ylabel('Bits');
title('Bit Sequence Pulse');
% Demodulation
r = zeros(1,length(t)); radd = zeros(1,length(t));
for i=1:1:length(t)
 if bitseq(1,i)==1
 r(1,i) = delta;
 else
 r(1,i) = -delta;
 end
end
for i=2:1:length(t)
 if mod(t(i), Ts) == 0
 radd(1,i) = radd(1,i-1)+r(1,i);
 else
 radd(1,i) = radd(1,i-1);
 end
end;
figure
plot(t,radd);
xlabel('Time'); ylabel('Amplitude');
title('Demodulated Signal');

