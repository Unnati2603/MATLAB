clc;
clear all;
close all;
Am=input('Am:');
Fm=input('Fm:');
As=input('As:');
t=-2:0.001:2;
Fs=8*Fm;
Tau=1/(5*Fs);
mt=Am*sin(2*pi*Fm*t);
st=As*sawtooth(2*pi*Fs*t);
pwm=zeros(size(t));
ppm=zeros(size(t));
ord=3;
Tres=0.001;
Fres=1/Tres;
wn=((1.5*Fm)/(Fres/2));
[b,a]=butter(ord,wn,'low');

for i=1:numel(t)
    if mt(i)>st(i)
        pwm(i)=1;
    end
end

for i=1:numel(t)-round(Tau/Tres)-1
    if pwm(i)>pwm(i+1)
        ppm(i:round(i+(Tau/Tres)))=1;
    end
end

reconst=filter(b,a,pwm);
subplot(5,1,1);
plot(t,mt);
title('Message Signal');
xlabel('Time(s)');
ylabel('Amplitude');

subplot(5,1,2);
plot(t,st);
title('Sawtooth signal');
xlabel('Time(s)');
ylabel('Amplitude');

subplot(5,1,3);
plot(t,pwm);
title('PWM signal');
xlabel('Time(s)');
ylabel('Amplitude');

subplot(5,1,4);
plot(t,ppm);
title('PPM signal');
xlabel('Time(s)');
ylabel('Amplitude');

subplot(5,1,5);
plot(t,reconst);
title('Reconstructed signal');
xlabel('Time(s)');
ylabel('Amplitude');