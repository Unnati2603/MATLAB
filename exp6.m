% Initialization
clc;                            % Clears the command window
close all;                      % Closes all figure windows
clear all;                      % Clears all the variables from the workspace

% Input Parameters
fs = 16; % input('Enter Fs value: ');
fm = 1; %input('Enter Fm value: ');
Am = 1; %input('Enter Am value: ');

% Time axis and Message Signal
Ts = 1/fs;                       % Sampling Period
t  = -2:0.0001:2;                % Time Axis
mt = Am.*sin(2.*pi.*fm.*t);      % Message Signal

% Generation of Impulse train
it = zeros(size(t));             % Contains all zero  elements
for i=1:length(it)
    if (abs(rem(t(i),Ts))   ==0) %<0.0000001)
        it(i) = 1;
    end
end
% it(1:round(Ts/0.0001):end) = 1;

% Sampled Signal and Sample Vector
m1t = mt.*it;
Sample_Vector = mt(it==1);  % Contains only the Samples

% Reconstruction of the original Signal
rct = zeros(size(t));       % Contains only Zeros
for N=1:length(Sample_Vector) 

    % When time axis is symmetric in positive and negative time axis
    n = N - ceil(length(Sample_Vector)/2); 

    SincFn = sinc(fs*(t-n*Ts)); 
    rct = rct + Sample_Vector(N)*SincFn;
end

% Plotting of Message Signal
subplot(4,1,1);
plot(t,mt);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal');

% Plotting of Impulse train
subplot(4,1,2);
plot(t,it);
xlabel('Time');
ylabel('Amplitude');
title('Impulse Train');

% Plotting of Sampled Signal
subplot(4,1,3);
plot(t,m1t);
xlabel('Time');
ylabel('Amplitude');
title('Sampled Signal');

% Plotting of Reconstructed Signal
subplot(4,1,4);
plot(t,rct);
xlabel('Time');
ylabel('Amplitude');
title('Reconstructed Signal');