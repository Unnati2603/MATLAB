clc;
close all;
clear  all;

t=-20:0.001:20;
y= zeros(size(t));


for i=1:numel(t)
    if t(i)>0
        y(i)=t(i).^2;
    end
end

subplot(2,1,1);
plot(t, y);


y1=t.^2;
subplot(2,1,2);
plot(t, y1);


