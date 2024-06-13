clc;
clear all;
close all;

%generation 
Fm=1; %input('Enter Fm:');
Am=10 ;%input('Enter Am:');
Fs=2 ; %input('Enter Fs:');

tm=1/Fm;
tres=0.001;
t=0:tres:3;

Ts=1/Fs;
tau=(2.*Ts)/3;
w=round(tau/tres);

it=zeros(size(t));

it(1:w:end)=1;
for i = 1:w:length(t)
   it(i:i+w)=1;
end
it=it(1:length(t));
mt= Am*cos(2*pi*Fm*t);

%messagesignal
subplot(4,1,1);
plot(t,mt,'r');
title('Message Signal 1');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;
f


% pulse func

% Create a vector of zeros with the same size as t
%y = zeros(size(t));

% Generate impulse train using a loop and numel
%
    % Check if the current element is a multiple of the spacing
%    if rem(t(i), 1) == 0
%       for j = 1:1:100
%           y(j) = 1;
%       end
 %   end
%end
%it=zeros(size(t));
%it(1:round(Ts/tres):end)=1;



%pulse
subplot(4,1,2);
plot(t,it,'r');
title('Pulse Train ');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;


sig= mt.*it;
subplot(4,1,3);
plot(t,sig,'b');
title('Pulse Amplitude Modulation  ');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;













