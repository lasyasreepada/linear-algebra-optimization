function [dx, dy, Bx, By] = interpnatxy(x,y, show_plot)
% This version uses the natural end condition
% Uses Matlab \ to solve linear systems
% Input points: two column vectors of x and y coordinates of dim N+1
%
%  This version uses x_0, x_1, ..., x_{N-1}, x_N to compute the Bezier
%  points and the subdivision version of the de Casteljau algorithm
%  to plot the Bezier segments (bspline2b and drawbezier_dc)

points_array = cat(2,x,y);

rows = size(points_array,1);
k = size(points_array,2);
N = rows - 1;

% compute A matrix
if N > 2
    A = zeros(N-1);
    A(1, [1, 2]) = [4, 1];
    A(N-1,[N-2, N-1]) = [1, 4];

else
    A = 4;

end

for i = 2:N-2
    A(i, [i-1, i, i+1]) = [1, 4, 1];
end

% construct de Boor Control Points from A
d_pts = zeros(N+3,k);

for col = 1:k
    x_ = zeros(max(N-1,1),1);

    if N > 2

        % Compute start and end conditions
        x_(N-1,1) = 6 * points_array(N,col) - points_array(N+1, col);
        x_(1, 1) = 6 * points_array(2, col) - points_array(1, col);
    
        x_(2:N-2,1) = 6 * points_array(3:N-1,col);

        % Solve Bezier interpolation
        X = transpose(A \ x_);
        d_pts(3:N+1,col) = X;
    end
end
 
 % Start and end conditions
 d_pts(1,:) = points_array(1,:);
 d_pts(N+3,:) = points_array(N+1,:);

 % Second to last de Boor point based on end conditions
 one_third = (1.0/3.0);
 two_thirds = (2.0/3.0);
 d_pts(2, :) = (two_thirds)*points_array(1, :) + (one_third)*d_pts(3, :);
 d_pts(N+2, :) = ((one_third)*d_pts(N+1, :) + (two_thirds)*points_array(N+1, :));

 dx = d_pts(:,1);
 dy = d_pts(:,2);


%
%  This version outputs the x and y coordinates dx and dy of the de Boor control
%  points d_{-1}, d_0, d_1, ..., d_{N+1} as column vectors
%  and the x and y coordinates of the Bezier control polygons
%  Bx and By
%

% Plots the spline
Nx = size(dx,1)-1;
fprintf('Nx = %d \n', Nx)
nn = 6; % subdivision level
drawb = true;
% hold on
[Bx, By] = bspline2b(dx,dy,Nx,nn,drawb);
hold on
plot(x,y,'b+'); % Plot x's as blue +
hold off;
end
