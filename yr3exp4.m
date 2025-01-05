clc; clear all; close all;

% BPSK Modulation and Demodulation

% Parameters
N = 8000; % Number of elements in the time array
Fc = input('Frequency of the Carrier Signal (Hz) = '); % Carrier frequency
Fm = input('Message Frequency (Hz) = '); % Message frequency
Fs = input('Sampling Frequency (Hz) = '); % Sampling frequency
Tb = input('Bit Duration (s) = '); % Bit duration
Ac = input('Amplitude of the Carrier Signal = '); % Amplitude of the carrier signal
Am = input('Amplitude of the Message Signal = '); % Amplitude of the message signal

% Time vector for one bit duration
Ts = 1/Fs; % Sampling interval
t = 0:Ts:(Tb-Ts); % Time vector

% Input binary sequence
input_bits = input('Enter an 8-bit binary sequence (e.g., [1 0 1 0 1 0 1 0]): ');

% Ensure that the time vector is long enough
time_signal = [];

% BPSK Modulation
for i = 1:length(input_bits)
    if input_bits(i) == 0
        % Message signal (sinusoidal) multiplied by carrier signal (cosine)
        modulated_signal = Am .* sin(2 .* pi .* Fm .* t) .* Ac .* cos(2 .* pi .* Fc .* t);
    else
        % Phase shift by 180 degrees for bit 1
        modulated_signal = Am .* sin(2 .* pi .* Fm .* t) .* Ac .* cos(2 .* pi .* Fc .* t + pi);
    end
    time_signal = [time_signal, modulated_signal];
end

% Plot the BPSK Modulated Signal
figure;
plot(linspace(0, Tb * length(input_bits), length(time_signal)), time_signal);
title('BPSK Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% BPSK Demodulation
demod_bits = [];
for i = 1:length(input_bits)
    % Extract the signal corresponding to the ith bit
    bit_signal = time_signal((i-1)*N + 1 : i*N);
    
    % Multiply by the in-phase carrier signal
    reference_carrier = Ac * cos(2*pi*Fc*t);
    product = bit_signal .* reference_carrier;
    
    % Integrate over the bit period to make a decision
    decision = sum(product);
    
    % If the decision is positive, the bit is '0', otherwise it's '1'
    if decision > 0
        demod_bits = [demod_bits, 0];
    else
        demod_bits = [demod_bits, 1];
    end
end

% Display the demodulated bits
disp('Demodulated bits:');
disp(demod_bits);

% Plot the received signal after demodulation (optional)
figure;
plot(linspace(0, Tb * length(input_bits), length(time_signal)), time_signal .* reference_carrier);
title('Received Signal After Demodulation');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
