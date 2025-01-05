clc;  
close all; 
clear all;

N = 1000;
fm = input('Please Enter the message signal frequency: '); % Message signal frequency
fc = input('Please Enter the Carrier Frequency: '); % Carrier frequency
t = 1; % Duration of the signal
n = 0:1/N:t; 
n = n(1:end-1); % Time vector
duty = 10; % Duty cycle in percentage

% No. of samples in one square wave period
per = N/fc; 
% No. of samples in the ON time
on_t = per * duty / 100; % Convert duty cycle to a fraction

% Generate the carrier square wave
s = square(2 .* pi .* fc .* n, duty);
s(find(s < 0)) = 0; % Rectify the square wave to get a pulse train

% Generate the message signal m = sin(2 .* pi .* fm .* n)
m = sin(2 .* pi .* fm .* n); % Define the message signal

% Carrier Sawtooth
a = 1.25;
c = a .* sawtooth(2 .* pi .* fc .* n); % Carrier sawtooth wave

ppm = zeros(1, length(s)); % Initialize PPM signal

% Find indices where carrier is greater than message signal
id = find(c > m); 
idd = diff(id);
iddd = find(idd ~= 1);
temp(1) = id(1);
temp(2:length(iddd) + 1) = id(iddd + 1);

% Generate PPM signal
for i = 1:length(temp)
    ppm(temp(i):temp(i) + on_t - 1) = 1;
end

% Demodulate the PPM signal (assuming a demodulation function is defined)
x = demod(ppm, fc, N, 'PPM'); 

% Plotting the signals
grid on;
subplot(4,1,1);
plot(n, m); 
title('Message Signal');
hold on; 
plot(n, c); 
xlabel('Time'); 
ylabel('Amplitude');
grid on;

subplot(4,1,2); 
plot(n, s); 
xlabel('Time'); 
ylabel('Amplitude'); 
title('Pulse Train Signal');
grid on;

subplot(4,1,3); 
plot(n, ppm); 
xlabel('Time'); 
ylabel('Amplitude'); 
title('PPM Signal');
grid on;

subplot(4,1,4); 
plot(n(1:length(x)), x); % Ensure x is plotted over the correct time range
xlabel('Time');
ylabel('Amplitude'); 
title('Demodulated Signal');
