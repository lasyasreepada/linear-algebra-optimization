function[lpoly] = itersubdiv(cpoly,n)

lpoly=cpoly;

for i=1:n
    lpoly2 = subdivstep(lpoly);
    lpoly = lpoly2;
end
