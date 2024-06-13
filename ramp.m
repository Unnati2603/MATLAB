clc;
close all;
clear  all;

t=-20:0.001:20;
y=zeros(size(t));

for i=1:1:length(t)
    if t(i)>=0
        y(i)=t(i);
    end
end


subplot(1,1,1);
plot(t, y);

