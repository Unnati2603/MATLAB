% Number of points in the constellation
M = 16; 

% Generate the in-phase (I) and quadrature (Q) components
n = sqrt(M); % Number of points along each axis
I = -(n-1):2:(n-1); % In-phase levels
Q = -(n-1):2:(n-1); % Quadrature levels

% Generate the grid of constellation points
[I_grid, Q_grid] = meshgrid(I, Q);
constellation_points = I_grid(:) + 1j * Q_grid(:);

% Plot the signal constellation
figure;
plot(real(constellation_points), imag(constellation_points), 'bo', 'MarkerSize', 10, 'LineWidth', 1.5);
grid on;
xlabel('In-phase (I)');
ylabel('Quadrature (Q)');
title('16-QAM Signal Constellation');
axis equal;
