function [ud,ld] = subdecas(cpoly)
n = size(cpoly,2);
m = n - 1;
t = 0.5;

cpoly = cpoly';

%initiate control polygons
ud=cpoly(1,:)';
ld=cpoly(end,:)';

for i=1:m
    for j=1:(m-i+1)
        cpoly(j,1)=(1-t)*cpoly(j,1)+t*cpoly(j+1,1);
        cpoly(j,2)=(1-t)*cpoly(j,2)+t*cpoly(j+1,2);
    end

    ud=[ud,cpoly(1,:)'];
    ld=[cpoly(end-i,:)',ld];
end
end