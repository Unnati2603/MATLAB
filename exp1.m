clc;
close all;
clear all;


t=-20:0.001:20;

%unit impulse
y=zeros(size(t));
for i=1:length(t)
    if t(i)==0
        y(i)=1;
    else
        y(i)=0;
    end
end
subplot(6,1,1);
plot(t,y);
xlabel("t");;
ylabel("val");
title("Unit Impulse");


% trin impulse func

% Create a vector of zeros with the same size as t
y = zeros(size(t));


% Generate impulse train using a loop and numel
for i = 1:1:numel(t)
    % Check if the current element is a multiple of the spacing
    if rem(t(i), 1) == 0
        y(i) = 1;
    end
end

% Plot the impulse train
subplot(6, 1, 2);
plot(t, y);
xlabel("t");
ylabel("val");
title("Impulse Train");


 


