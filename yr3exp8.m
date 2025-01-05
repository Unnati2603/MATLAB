clc;
clear;
close all;

% Parameters
fs = 10000;            % Sampling frequency (Hz)
T = 1;                 % Time duration (seconds)
t = 0:1/fs:T;          % Time vector
f_message = 5;         % Frequency of message signal (Hz)
f_sawtooth = 50;       % Frequency of the sawtooth signal (Hz)
message_amplitude = 1; % Amplitude of the message signal

% Generate sinusoidal message signal
message_signal = message_amplitude * sin(2 * pi * f_message * t);

% Generate sawtooth signal
sawtooth_signal = sawtooth(2 * pi * f_sawtooth * t);

% Comparator to generate PWM signal
pwm_signal = message_signal > sawtooth_signal;

% Pass PWM signal through a monostable multivibrator to generate PPM signal
ppm_signal = diff([0 pwm_signal]) > 0; % Monostable multivibrator output

% Ensure PPM signal length matches time vector t
ppm_signal_padded = zeros(1, length(t));  % Initialize the PPM signal
ppm_signal_padded(1:length(ppm_signal)) = ppm_signal;  % Assign PPM values

% Demodulation process (detect pulse positions)
pulse_positions = find(ppm_signal_padded == 1);  % Detect pulse edges (PPM signal)
demodulated_signal = zeros(1, length(t));

% Reconstruct the message based on the pulse positions
slot_duration = fs / f_sawtooth;
for i = 1:length(pulse_positions)
    demodulated_signal(pulse_positions(i):end) = message_amplitude * sin(2*pi*f_message*t(pulse_positions(i)));
end

% Plot all signals in one figure
figure;

% 1. Plot the message signal
subplot(5,1,1);
plot(t, message_signal, 'b', 'LineWidth', 1.5);
title('Message Signal (Sinusoidal)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% 2. Plot the sawtooth signal
subplot(5,1,2);
plot(t, sawtooth_signal, 'g', 'LineWidth', 1.5);
title('Sawtooth Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% 3. Plot the PWM signal
subplot(5,1,3);
plot(t, pwm_signal, 'r', 'LineWidth', 1.5);
title('PWM Signal (Comparator Output)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% 4. Plot the PPM signal
subplot(5,1,4);
plot(t, ppm_signal_padded, 'k', 'LineWidth', 1.5);
title('PPM Signal (Monostable Multivibrator Output)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% 5. Plot the demodulated signal vs the original message signal
subplot(5,1,5);
plot(t, demodulated_signal, 'b', 'LineWidth', 1.5);
hold on;
plot(t, message_signal, 'r--');
title('Demodulated Signal vs Original Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Demodulated Signal', 'Original Message Signal');
