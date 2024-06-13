% Initialization
clc;                            % Clears the command window
close all;                      % Closes all figure windows
clear all;                      % Clears all the variables from the workspace

% Input Parameters
fs = 10; % input('Enter Fs value: ');
fm1 = 1; %input('Enter Fm value: ');
fm2 = 2;
Am1 = 1; %input('Enter Am value: ');
Am2 = 2;
tres=0.0001;
fcut=fs/4;

Ts = 1 / fs;

% Time axis and Message Signal 1
ts = 1/fs;                       % Sampling Period
t  = -2:0.0001:2;                % Time Axis
mt1 = Am1.*sin(2.*pi.*fm1.*t);      % Message Signal

% Plotting of Message Signal 1
subplot(5,2,1);
plot(t,mt1);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal 1');

%Message Signal 2
mt2 = Am2.*sin(2.*pi.*fm2.*t);      % Message Signal
 
% Plotting of Message Signal 2
subplot(5,2,2);
plot(t,mt2);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal 2');


% Generation of Impulse train
%it = zeros(size(t));             % Contains all zero  elements
%for i=1:length(it)
   % if rem(t(i), 1) == 0 %<0.0000001)
   
   %this will generate random as 0.000000000001 ko bhi 0 le leta h
   
    %    it(i) = 1;
    %end
%end
% it(1:round(Ts/0.0001):end) = 1;


%impulse 1
IT1=zeros(size(t));
IT1(1:round(ts/tres):end)=1;

% Plotting of Impulse train1
subplot(5,2,3);
plot(t,IT1);
xlabel('Time');
ylabel('Amplitude');
title('Impulse Train 1');

%start from the half 
%ipulse 2
IT2=zeros(size(t));
IT2(round(ts/(2*tres)):round(ts/tres):end)=1;

% Plotting of Impulse train 2
subplot(5,2,4);
plot(t,IT2);
xlabel('Time');
ylabel('Amplitude');
title('Impulse Train 2');


% Sampled Signal 

st1=mt1.*IT1;
st2=mt2.*IT2;

%plotting
subplot(5,2,5);
plot(t,st1);
xlabel('Time');
ylabel('Amplitude');
title('sampled 1');

%plotting
subplot(5,2,6);
plot(t,st2);
xlabel('Time');
ylabel('Amplitude');
title('sampled 2');
order=4;


sum=st1+st2;
%plotting
subplot(5,2,7);
plot(t,sum);
xlabel('Time');
ylabel('Amplitude');
title('total sampled');

wc=(fcut/fs/2);


[b,a]=butter(order, wc, 'low');
%[x,y]=butter(order, wc, 'low');
msg1=filter(b,a,sum);
%plotting
subplot(5,2,8);
plot(t,msg1);
xlabel('Time');
ylabel('Amplitude');
title('signal 1');


