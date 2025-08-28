%
%  To display a cubic B-spline given by de Boor control points
%   d_0, ..., d_N  
%
% Input points: left click for the d's then press enter (or return, or right click)  
%
%  Performs a loop from 1 to N - 2 to compute the Bezier
%  points using de Casteljau subdivision
%  nn is the subdivision level
%
%  This version also outputs the x-coodinates and the y-coordinates
%  of all the control points of the Bezier segments stored in
%  Bx(N-2,4) and By(N-2,4)
%

function [Bx, By] = bspline2b(dx,dy,N,nn,drawb)
% Works if N >= 4.

Bx = zeros(N-2,4);
By = zeros(N-2,4);

for i=1:(N-2)
    if i==1
        Bx(i,1) = dx(1); By(i,1) = dy(1);
        Bx(i,2) = dx(2); By(i,2) = dy(2);
        Bx(i,3) = dx(2)/2 + dx(3)/2; By(i,3) = dy(2)/2 + dy(3)/2;

        if N==4
            Bx(i,4) = dx(2)/4 + dx(3)/2 + dx(4)/4; By(i,4) = dy(2)/4 + dy(3)/2 + dy(4)/4;
        else 
            Bx(i,4) = dx(2)/4 + 7*dx(3)/12 + dx(4)/6; By(i,4) = dy(2)/4 + 7*dy(3)/12 + dy(4)/6;
        end

    elseif i==2 && i~=(N-2) 
        
        Bx(i,1) = dx(2)/4 + 7*dx(3)/12 + dx(4)/6; By(i,1) = dy(2)/4 + 7*dy(3)/12 + dy(4)/6;
        Bx(i,2) = 2*dx(3)/3 + dx(4)/3; By(i,2) = 2*dy(3)/3 + dy(4)/3;
        Bx(i,3) = dx(3)/3 + 2*dx(4)/3; By(i,3) = dy(3)/3 + 2*dy(4)/3;
        
        if N==5
            Bx(i,4) = dx(N-2)/6 + 7*dx(N-1)/12 + dx(N)/4; By(i,4) = dy(N-2)/6 + 7*dy(N-1)/12 + dy(N)/4;
        else 
            Bx(i,4) = dx(3)/6 + 2*dx(4)/3 + dx(5)/6; By(i,4) = dy(3)/6 + 2*dy(4)/3 + dy(5)/6;
        end 

    elseif (i>=3) && (i<=N-4)
        Bx(i,1) = dx(i)/6 + 2*dx(i+1)/3 + dx(i+2)/6; By(i,1) = dy(i)/6 + 2*dy(i+1)/3 + dy(i+2)/6;
        Bx(i,2) = 2*dx(i+1)/3 + dx(i+2)/3; By(i,2) = 2*dy(i+1)/3 + dy(i+2)/3;
        Bx(i,3) = dx(i+1)/3 + 2*dx(i+2)/3; By(i,3) = dy(i+1)/3 + 2*dy(i+2)/3;
        Bx(i,4) = dx(i+1)/6 + 2*dx(i+2)/3 + dx(i+3)/6; By(i,4) = dy(i+1)/6 + 2*dy(i+2)/3 + dy(i+3)/6;
    
    elseif (i==N-3)
        Bx(i,1) = dx(N-3)/6 + 2*dx(N-2)/3 + dx(N-1)/6; By(i,1) = dy(N-3)/6 + 2*dy(N-2)/3 + dy(N-1)/6;
        Bx(i,2) = 2*dx(N-2)/3 + dx(N-1)/3; By(i,2) = 2*dy(N-2)/3 + dy(N-1)/3;
        Bx(i,3) = dx(N-2)/3 + 2*dx(N-1)/3; By(i,3) = dy(N-2)/3 + 2*dy(N-1)/3;
        Bx(i,4) = dx(N-2)/6 + 7*dx(N-1)/12 + dx(N)/4; By(i,4) = dy(N-2)/6 + 7*dy(N-1)/12 + dy(N)/4;

    elseif (i==N-2)
        if N==4
            Bx(i,1) = dx(2)/4 + dx(3)/2 + dx(4)/4; By(i,1) = dy(2)/4 + dy(3)/2 + dy(4)/4;
        else
            Bx(i,1) = dx(N-2)/6 + 7*dx(N-1)/12 + dx(N)/4; By(i,1) = dy(N-2)/6 + 7*dy(N-1)/12 + dy(N)/4;
        end
        
        Bx(i,2) = dx(N-1)/2 + dx(N)/2; By(i,2) = dy(N-1)/2 + dy(N)/2;
        Bx(i,3) = dx(N); By(i,3) = dy(N);
        Bx(i,4) = dx(N+1);  By(i,4) = dy(N+1);

    else
        print("error")
    end
end

% nn is the subdivision level
% fprintf('numpt = %d \n', numpt)
figure;
dim_data = 2;
B = zeros(dim_data,4);
plot(dx,dy,'or-');   % plots d's as red circles
hold on;
for i = 1:N-2       
    B(1,:) = Bx(i,:); B(2,:) = By(i,:);
    drawbezier_dc(B,nn,drawb);
end
hold off;
end

