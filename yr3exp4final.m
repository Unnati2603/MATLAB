clc;
clear all;
close all;
x = input('Enter an array of 8 binary bits (e.g., [1 0 0 1 1 0 1 0]): ');

% Validate input to ensure it is an array of 8 binary bits
while length(x) ~= 8 || any(~ismember(x, [0 1]))
    disp('Invalid input. Please enter an array of 8 binary bits.');
    x = input('Enter an array of 8 binary bits (e.g., [1 0 0 1 1 0 1 0]): ');
end

bp = 0.000001;        % Bit period
disp('Binary information at Transmitter :');
disp(x);

%% Representation of transmitting binary information as digital signal
bit = [];
for n = 1:length(x)
    if x(n) == 1
        se = ones(1, 100);
    else
        se = zeros(1, 100);
    end
    bit = [bit se];
end

t1 = bp/100:bp/100:100*length(x)*(bp/100);
figure;
subplot(5,1,1);
plot(t1, bit, 'r', 'linewidth', 2.5);
grid on;
axis([0 bp*length(x) -.5 1.5]);
ylabel('Amplitude (V)');
xlabel('Time (s)');
title('Transmitting information as digital signal');

%% Carrier signal
br = 1/bp;   % Bit rate
f = br*10;   % Carrier frequency
t2 = bp/99:bp/99:bp;
carrier = cos(2*pi*f*t2);

subplot(5,1,2);
plot(t2, carrier, 'k', 'linewidth', 2.5);
grid on;
ylabel('Amplitude (V)');
xlabel('Time (s)');
title('Carrier signal');

%% ASK modulation
A1=input("Amplitude of carrier signal 1 ");   %10   % Amplitude of carrier signal for information 1
A2=input("Amplitude of carrier signal 2 ");     %0  % Amplitude of carrier signal for information 0

ss = length(t2);
m = [];
for i = 1:length(x)
    if x(i) == 1
        y = A1 * carrier;
    else
        y = A2 * carrier;
    end
    m = [m y];
end

t3 = bp/99:bp/99:bp*length(x);
subplot(5,1,3);
plot(t3, m, 'b', 'linewidth', 2.5);
grid on;
xlabel('Time (s)');
ylabel('Amplitude (V)');
title('ASK modulated waveform');

%% Intermediate waveforms during ASK demodulation
mn = [];
intermediate_waveform = [];  % To store the intermediate waveform for plotting

for n = ss:ss:length(m)
    t = bp/99:bp/99:bp;
    y = carrier;
    
    % Check if the modulated signal is 0
    if all(m((n-(ss-1)):n) == 0)
        mm = zeros(size(t));  % Set intermediate waveform to 0 if modulated signal is 0
    else
        mm = y .* m((n-(ss-1)):n);
    end
    
    intermediate_waveform = [intermediate_waveform mm];  % Store intermediate waveform
    
    subplot(5,1,4);
    plot(bp/99:bp/99:bp*length(intermediate_waveform)/ss, intermediate_waveform, 'm', 'linewidth', 2.5);
    grid on;
    ylabel('Amplitude (V)');
    xlabel('Time (s)');
    title('Intermediate waveform during demodulation');
    
    z = trapz(t, mm);  % Integration
    zz = round((2*z/bp));
    if zz > 5         % Decision threshold
        a = 1;
    else
        a = 0;
    end
    mn = [mn a];
end

disp('Binary information at Receiver :');
disp(mn);

%% Representation of binary information as digital signal which achieved after ASK demodulation
bit = [];
for n = 1:length(mn)
    if mn(n) == 1
        se = ones(1, 100);
    else
        se = zeros(1, 100);
    end
    bit = [bit se];
end

t4 = bp/100:bp/100:100*length(mn)*(bp/100); 
subplot(5,1,5); 
plot(t4, bit, 'g', 'linewidth', 2.5); 
grid on;
axis([0 bp*length(mn) -.5 1.5]); 
ylabel('Amplitude (V)'); 
xlabel('Time (s)');
title('ASK demodulated waveform');