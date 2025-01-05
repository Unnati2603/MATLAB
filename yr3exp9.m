clc;
close all;
clear all;
n = input('Enter n value for n-bit PCM system : ');
n1 = input('Enter number of samples in a period : ');

L = 2^n;   % Levels
% Sampling Operation
x = 0:2*pi/n1:4*pi;   % n1 number of samples have to be selected
s = 8*sin(x);         % Amplitude of signal is 8
subplot(3,1,1);
plot(s);
title('Analog Signal');
ylabel('Amplitude');
xlabel('Time');

subplot(3,1,2);
stem(s);
grid on;
title('Sampled Signal');
ylabel('Amplitude');
xlabel('Time');

% Quantization Process
vmax = 8;
vmin = -vmax;
del = (vmax - vmin) / L;             % Level are between vmin and vmax
part = vmin:del:vmax;                % Contains Quantized values
code = vmin - (del/2):del:vmax + (del/2);  % Contains Quantized values with difference of del
[ind, q] = quantiz(s, part, code);   % Quantization process, ind contains index number and q contains quantized values

l1 = length(ind);
l2 = length(q);

for i = 1:l1
    if ind(i) ~= 0
        ind(i) = ind(i) - 1;    % Start from 0 to N
    end
end

for i = 1:l2
    if q(i) == vmin - (del/2)
        q(i) = vmin + (del/2);  % Make quantize value in between
    end
end

subplot(3,1,3);
stem(q);
grid on;
title('Quantized Signal');
ylabel('Amplitude');
xlabel('Time');

% Encoding Process
figure
code = de2bi(ind, 'left-msb');   % Convert the decimal to binary
k = 1;
for j = 1:l1
    for i = 1:n
        coded(k) = code(j,i);   % Convert code matrix to a coded row
        k = k + 1;
    end
end

subplot(2,1,1);
plot(coded);
grid on;
axis([0 100 -2 3]);
title('Encoded Signal');
ylabel('Amplitude');
xlabel('Time');

% Demodulation of PCM signal
qunt = reshape(coded, n, length(coded) / n);
index = bi2de(qunt', 'left-msb');    % Get back the index in decimal form
q = del * index + vmin + (del/2);    % Get back quantized values

subplot(2,1,2);
plot(q);
grid on;
title('Demodulated Signal');
ylabel('Amplitude');
xlabel('Time');