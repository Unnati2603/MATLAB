% MATLAB code for Minimum Shift Keying (MSK) Modulation

%% Initial Statements
clc;
clear all;
close all;

%% Input Statements
fm = input('Enter the message signal frequency (fm): '); % Message signal frequency
fc = input('Enter the carrier signal frequency (fc): '); % Carrier signal frequency
disp('Enter 8 bits of data in the form of 1 and -1: ');

x = zeros(1, 8); % Initialize the data array
for i = 1:8
    x(i) = input(['Enter bit ' num2str(i) ': ']); % Input data bit by bit
end

%% Parameters and Time Vector
tm = 1 / fm; % Time period of message signal
tc = 1 / fc; % Time period of carrier signal
t = 0:tm/100:17.98/(0.02/(tm/100)); % Time vector

%% Generation of Message Signal
n = 1;
x1 = zeros(1, length(t)); % Initialize message signal
for i = 1:length(t)
    if i >= 100
        n = n + 1;
    end
    if i >= 800 && i <= 900
        x1(i) = 0;
    else
        x1(i) = x(mod(n-1, 8) + 1); % Wrap around the data bits
    end
end

%% Generation of ODD BITS and EVEN BITS
x_odd = x(1:2:end);   % Extract odd-indexed bits
x_even = x(2:2:end);  % Extract even-indexed bits

% Ensure both x_odd and x_even are the same length as t by repeating their values
x_odd = repelem(x_odd, ceil(length(t) / length(x_odd)));
x_odd = x_odd(1:length(t)); % Trim to match exactly
x_even = repelem(x_even, ceil(length(t) / length(x_even)));
x_even = x_even(1:length(t)); % Trim to match exactly


%% Plots for Signals
figure;
subplot(5, 1, 1);
plot(t, x1);
xlabel('time');
ylabel('amplitude');
title('Message Signal');

subplot(5, 1, 2);
plot(t, x_odd);
xlabel('time');
ylabel('amplitude');
title('Odd Bits Message Signal');

subplot(5, 1, 3);
plot(t, x_even);
xlabel('time');
ylabel('amplitude');
title('Even Bits Message Signal');

subplot(5, 1, 4);
plot(t, sin(2 * pi * (fm / 4) * t));
xlabel('time');
ylabel('amplitude');
title('sin(2*pi*(fm/4)*t)');

subplot(5, 1, 5);
plot(t, cos(2 * pi * (fm / 4) * t), 'k');
xlabel('time');
ylabel('amplitude');
title('cos(2*pi*(fm/4)*t)');

%% MSK Modulation
b_even = x_even .* sin(2 * pi * (fm / 4) * t);
b_odd = x_odd .* cos(2 * pi * (fm / 4) * t);

figure;
subplot(2, 1, 1);
plot(t, b_even);
xlabel('time');
ylabel('amplitude');
title('b_{even} * sin(2*pi*(fm/4)*t)');

subplot(2, 1, 2);
plot(t, b_odd);
xlabel('time');
ylabel('amplitude');
title('b_{odd} * cos(2*pi*(fm/4)*t)');

%% MSK Modulated Signal
msk = ((x_odd + x_even) / 2) .* sin(2 * pi * 1.5 * fm * t) + ...
      ((x_odd - x_even) / 2) .* sin(2 * pi * fm * t);

figure;
subplot(3, 1, 1);
plot(t, sin(2 * pi * 1.5 * fm * t));
xlabel('time');
ylabel('amplitude');
title('sin(2*pi*1.5*fm*t)');

subplot(3, 1, 2);
plot(t, sin(2 * pi * fm * t));
xlabel('time');
ylabel('amplitude');
title('sin(2*pi*fm*t)');

subplot(3, 1, 3);
plot(t, msk);
xlabel('time');
ylabel('amplitude');
title('MSK Modulated Signal');
