clc;
close all;
clear all;

fm=1;
fc=20;
Am=1;;
Ac=1;

tc=1/fc;
tm=1/fm;
t=-2:0.001:2;
f=-2:0.001:2;
mt1= Am.*cos(2*pi*fm*t);
subplot(5,1,1);
plot(t,mt1);
title ("Message Signal")
mt2= hilbert(mt1);



ct1= Ac.*cos(2*pi*fc*t);
subplot(5,1,2);
plot(t,ct1);
title ("Carrier Signal")
ct2= Ac.*sin(2*pi*fc*t);
subplot(5,1,3);
plot(t,ct2);
title ("Carrier2 Signal")


usb=mt1.*cos(2*pi*fc*t)-mt2.*sin(2*pi*fc*t);
subplot(5,1,4);
plot(t,usb);
title ("usb Signal")

lsb=mt1.*cos(2*pi*fc*t)+mt2.*sin(2*pi*fc*t);
subplot(5,1,5);
plot(t,lsb);
title ("lsb Signal")


% Demodulation
demod_lsb = lsb .* cos(2*pi*fc*t);
demod_usb = usb .* cos(2*pi*fc*t);

% Low-pass filter
lpf_cutoff = 2.5 * fm; % Set cutoff frequency for the low-pass filter
[b, a] = butter(6, lpf_cutoff/(0.5*fc));
demod_lsb_filtered = filter(b, a, demod_lsb);
demod_usb_filtered = filter(b, a, demod_usb);

% Plot demodulated signals
figure;
subplot(2,1,1);
plot(t, demod_lsb_filtered);
title("Demodulated LSB Signal");

subplot(2,1,2);
plot(t, demod_usb_filtered);
title("Demodulated USB Signal");






