function[lpoly2] = subdivstep(lpoly)
l=size(lpoly,3);

%initiate control polygons

for i=1:l
    [ud,ld] = subdecas(lpoly(:,:,i));
    lpoly2(:,:,2*i - 1) = ud;
    lpoly2(:,:,2*i) = ld;
   
end

end


