n = 10; % Number of concentric circles
theta = linspace(0, 2*pi, 100); % Angle values for the circles

figure;
hold on;
for r = 1:n % Radii ranging from 1 to 10
    x = r * cos(theta); % x-coordinates
    y = r * sin(theta); % y-coordinates
    z = r * ones(size(theta)); % z-coordinates increase with radius
    plot3(x, y, z, 'LineWidth', 1.5); % Plot in 3D
end
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
axis equal;
view(45, 30); % Adjust the 3D view angle
hold off;
