clc;
close all;
clear all;

t=-20:0.001: 20;
y=zeros(size(t));
for i=1:numel(t)
    if t(i)<0
        y(i)=-1;
    end
    if t(i)==0
        y(i)=0;
    end
    if t(i)>0
        y(i)=1;
    end
    
end

subplot(2,1,1);
plot(t, y);
xlabel('Time');
ylabel('Amplitude');
title('Cont sgn');


%discrcete
t = -20:0.001:20;
y1 = zeros(size(t));
for i = 1:numel(t)
    if rem(t(i),1) == 0 && t(i) < 0
        y1(i) = -1;
    end
    if rem(t(i),1) == 0 && t(i) == 0
        y1(i) = 0;
    end
    if rem(t(i),1) == 0 && t(i) > 0
        y1(i) = 1;
    end
end

subplot(2,1,2);
plot(t, y1); % Using stem plot for discrete signal
xlabel('Time');
ylabel('Amplitude');
title('Discrete sgn');
