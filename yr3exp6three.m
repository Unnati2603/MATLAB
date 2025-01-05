%MATLAB PROGRAM TO IMPLEMENT FREQUENCY SHIFT KEY MODULATION AND 
%DEMODULATION
%% INITIAL STATEMENTS
clc;
clear all;
close all;
%% Initialize the data
fm=input('Please enter the frequency of the message signal = ');
fc=input('Please enter the frequency of the carrier signal = ');
ac=input('please enter the amplitude of the carrier signal  = ');
tm=1/fm;
tc = 1/fc;
disp('Please enter the 8 bit data in the form of 1 and -1 ');
for i=1:8
    data=input('Enter the data = ');
        x(i)=data;
end
%% GENERATION OF THE MESSAGE SIGNAL 
i=1;
for n=1:800
    x1(n)=x(i);
    if n==i*100
        i=i+1;
    end
end
%% GENERATION OF THE CARRIER SIGNAL
t=0:(tm/100):15.98/(0.02/(tm/100));
s1=ac.*sin(2*pi*fc*t);
%% generation of the frequency modulated signal 
delf = (10./(2.*tm));
fsk=ac.*sin(2.*pi.*fc.*t+2.*pi.*((x1+1)/2).*delf.*t);
%% GENERATION OF FSK DEMODULATED SIGNAL
dm1 = fsk.*ac.*sin(2.*pi.*fc.*t);
dm2 = fsk.*ac.*sin(2.*pi.*(fc+delf).*t);
dm3 = dm2-dm1;
% add = 0;
% n=1; m = 1;
dm4 = zeros(1,length(t));
sumval = zeros(1,8);
sumval(1,1) = sum(dm3(1:100));
for k=2:1:8
 sumval(1,k) = sum(dm3((k-1)*100:k*100));
end
i=1;
for n=1:800
    if sumval(1,i)>0 
        dm4(1,n) = 1;
        if n==i*100
            i=i+1;
        end
    else
    dm4(1,n) = -1;
    if n==i*100
            i=i+1;
        end
    end
end
%% Plot and Display Values
disp(['Entered Bit Sequence are :', num2str(x)]);
subplot(3,1,1);plot(t,x1);
xlabel('time '); ylabel('amplitude '); title('message signal ');
subplot(3,1,2);plot(t,s1);
xlabel('time '); ylabel('amplitude '); title('carrier signal ');
subplot(3,1,3);plot(t,fsk);
xlabel('time '); ylabel('amplitude '); title('X_F_S_K(t)');
figure;
subplot(4,1,1);
plot(t,dm1,'r');
xlabel('time '); ylabel('amplitude '); title('1st stage demodulated');
subplot(4,1,2);
plot(t,dm2,'k');
xlabel('time '); ylabel('amplitude '); title('2nd stage demodulated');
subplot(4,1,3);
plot(t,dm3,'m');
xlabel('time '); ylabel('amplitude '); title('1st - 2nd stage');
subplot(4,1,4);
plot(t,dm4,'b');
xlabel('time '); ylabel('amplitude '); title('FSK Demdulated Signal');

