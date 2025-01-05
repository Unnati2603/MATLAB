clc;
close all;
t=-2:0.0001:2;
random_bits = round(rand(1, length(t)));

for i=1:length(random_bits)
    if random_bits(i)==0
        random_bits(i)=-1;
    end
end

tm = 1000;
Am= input("Am=");
Ac=Am;
Fc= input("Fc=");
mt = zeros(size(t));
ct = Ac*cos(2*pi*Fc*t);

tSamp=0.0001;
fSamp=1/tSamp;
ord=7;
wn=(Fc)/(fSamp/2);

for i=1:tm:length(t)-tm
    mt(i:i+tm)= random_bits(i);
end

bpsk = mt.*ct;

[b,a]=butter(ord,wn,'low');
intermediate=filter(b,a,bpsk.*ct);

reconst= zeros(size(t));

for i=1:length(t)
    if(intermediate(i)>0)
        reconst(i) = 1;
    else
        reconst(i) = -1;
    end
end

%message signal
subplot(3,1,1);
plot(t,mt);
title('Message Signal');
xlabel('Time(s)');
ylabel('Amplitude');

%carrier signal
subplot(3,1,2);
plot(t,ct);
title('Carrier Signal');
xlabel('Time(s)');
ylabel('Amplitude');

%BPSK signal
subplot(3,1,3);
plot(t,bpsk);
title('BPSK Signal');
xlabel('Time(s)');
ylabel('Amplitude');
figure;
%intermediate signal
subplot(2,1,1);
plot(t,intermediate);
title('After passing through LPF');
xlabel('Time(s)');
ylabel('Amplitude');

%reconstructed signal
subplot(2,1,2);
plot(t,reconst);
title('Reconstructed Signal');
xlabel('Time(s)');
ylabel('Amplitude');