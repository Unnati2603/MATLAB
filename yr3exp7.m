clc;
clear all;
close all;

% Input Length of Random Bit Sequence
cvx = input('Enter Length of Random Bit Sequence: ');

% Generate random bit sequence
d = round(rand(1, cvx));
l = cvx;

% Create x values and cosine functions
x = 0:0.01:l*2*pi;
cc = cos(x);
cs = cos(x + pi/2);

% Length of the cosine signal
k = length(cc);
k1 = k / l;

% Convert 0s to -1s
d(d == 0) = -1;

% Initialize variables for odd and even bit streams
dd1 = zeros(1, l * 2); 
dd2 = zeros(1, l * 2);

% Separate into odd and even bit streams
i = 1;
j = 1;
while i < l
    dd1(j) = d(i);
    dd1(j + 1) = d(i);
    dd2(j) = d(i + 1);
    dd2(j + 1) = d(i + 1);
    j = j + 2;
    i = i + 2;
end

% Initialize t and prepare for signal generation
t = 1;
dd = zeros(1, l * k1);
d1 = zeros(1, l * k1);
d2 = zeros(1, l * k1);

for i = 1:l
    for j = 1:k1
        dd(t) = d(i);
        d1(t) = dd1(i);
        d2(t) = dd2(i);
        t = t + 1;
    end
end

% Plot the bit streams
subplot(6, 1, 1);
stairs(dd);
axis([0 t -2 2]);
title('Input Bit Stream');

subplot(6, 1, 2);
stairs(d1);
%axis([0 t -2 2]);
title('Odd Bit Stream');

subplot(6, 1, 3);
stairs(d2);
%axis([0 t -2 2]);
title('Even Bit Stream');

% Limit length for plotting
len = min(length(d1), k);

% Generate modulated waveforms
qcc = zeros(1, len);
qcs = zeros(1, len);

for i = 1:len
    qcc(i) = cc(i) * d1(i); % odd streams multiplied with I waveform
    qcs(i) = cs(i) * d2(i); % even streams multiplied with Q waveform
end

% Plot modulated waveforms
subplot(6, 1, 4);
plot(qcc);
axis([0 len -2 2]);
title('Modulated Wave of I-Component');

subplot(6, 1, 5);
plot(qcs);
axis([0 len -2 2]);
title('Modulated Wave of Q-Component');

% QPSK output
qp = qcc + qcs;
subplot(6, 1, 6);
plot(qp);
axis([0 len -2 2]);
title('QPSK Waveform');

% Constellation diagram
figure;
scatter(dd1, dd2, 40, '*r');
title('Constellation Diagram of QPSK');