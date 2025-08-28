% function to draw a Bezier segment
% using de Casteljau subdivision
% nn = level of subdivision
% used by bspline4_dc
% also plots the Bezier control polygons if drawb = 1
%
function drawbezier_dc(B,nn,drawb)
 % nn is the subdivision level

 %%% DRAW CURVE HERE %%%'
 [x, y] = show_decas_subdiv2(B,nn);
 plot(x,y,'-')
 hold on

%Plotting the de-Boor points
%
 % Plot the curve segment as a random color
 if drawb == 1 
    %%% Plot the Bezier points and segments  as red + %%% 
    plot(B(1,:),B(2,:),'r+-')
    hold on
 else
    %%% Plot the Bezier points as red + %%%
    plot(B(1,:),B(2,:),'r+-')
    hold on
 end
 legend('de Boor Pts','Bezier Curve')

end