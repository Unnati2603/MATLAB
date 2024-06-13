
clc;
clear all;
close all;

% Parameters
fm = 2; % Message frequency
am = 10; % Message amplitude
fs = 10; % Sampling frequency
as = 20; % Amplitude of sawtooth

% Time vector
tres = 0.0001;
t = -2:tres:2;

% Message signal
mt = am * cos(2*pi*fm*t);
st = as * sawtooth(2*pi*fs*t);

% Plotting message and sawtooth signals
subplot(6,1,1);
plot(t, mt, 'r');
title('Message Signal');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

subplot(6,1,2);
plot(t, st, 'r');
title('Sawtooth Signal');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

% Comparing signals for PWM 
pwm = zeros(size(t)); 
%ppm = zeros(size(t)); 

for i = 1:length(mt)
    if mt(i) > st(i)
        pwm(i) = 1;
    end
end

%plotting pwm 
subplot(6,1,3);
plot(t, pwm, 'b');
title('PWM Signal');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;


tau = (2.*t)/3;
w = round(tau/tres);
ppm = zeros(size(t)); 

ppm(1:w:end)=0;
for i = 1:length(mt)
  
    if pwm(i) > pwm(i+1)
        ppm(i:i+100)=1;
    end
end
ppm=ppm(1:length(mt));





% Plotting PPM 
subplot(6,1,3);
plot(t, pwm, 'b');
title('PWM Signal');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

subplot(6,1,4);
plot(t, ppm, 'b');
title('PPM Signal');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
grid on;

