clc;
clear all;
close all;
N=10000;
fm = input('fm = ');
fs = input('fs = ');
A = input('Amplitude = ');
ts = 1/fs;
tm = 1/fm;
% Generation of Sinewave
t = 0:tm/N:tm;
% n = 0:1:tm/ts;
% tn1 = 0:tm/(length(n)-1):tm;
x = A.*sin(2.*pi.*fm.*t);
subplot(3,1,1);
plot(t,x);
xlabel('Time (Second)');
ylabel('x(t)');
del=0.4;

% generation of delayed impulse signal;
for i = 1:length(x)-1
 if mod(t(i),ts) == 0
    delimp(i) = 1;
 else
    delimp(i) = 0;
 end
end
subplot(3,1,2); plot(t,delimp);
xlabel('Time (Second)');
ylabel('Impulse Train');
% Generation of Sampled Signal
xsamp = x.*delimp;
subplot(3,1,3);plot(t,xsamp);
xlabel('Time (Second)'); ylabel('Sampled Signals');
% Reconsruction of Original Signal
figure;
delsinc = zeros(length(t),tm/ts);
for i = 1:1:(tm/ts)
 for k=1:1:length(t)
 delsinc(k,i) =
A.*sin(2.*pi.*fm.*(i.*ts)).*sinc((fs/fm).*fm.*((t(k) -
i.*ts)));
 end
hold on;subplot(2,1,1);
plot(t,delsinc);
xlabel('Time (Second)');
ylabel('Collection of signals at the receiver');
end
delsincsum = zeros(length(t),1);
k=1;
for i=1:1:length(t)
 delsincsum(i,1) = sum(delsinc(k,:));
 k=k+1;
end
subplot(2,1,2); plot(t,delsincsum);
xlabel('Time (Sec)'); ylabel('X_R(t)'); title('Signal
Reconstruction');
