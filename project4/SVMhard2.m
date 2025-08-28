function [lamb,mu,w,b] = SVMhard2(rho,u,v)
%  
%   Runs hard margin SVM version 2   
%
%   p green vectors u_1, ..., u_p in n x p array u
%   q red   vectors v_1, ..., v_q in n x q array v
%
%   First builds the matrices for the dual program
%
p = size(u,2); q = size(v,2); n = size(u,1);
[A,c,X,Pa,qa] = buildhardSVM2(u,v);
%
%  Runs quadratic solver
%
tolr = 10^(-10); tols = 10^(-10); iternum = 180000;
[lam,U,nr,ns,kk] = qsolve1(Pa, qa, A, c, rho, tolr, tols, iternum);
if kk > iternum
   fprintf('** qsolve did not converge. Problem not solvable ** \n')
end
lamb = lam(1:p,1); 
mu = lam(p+1:p+q,1);

%%%%%%
%%% Solve for w and b here, as well as numsvl1 and numsvm1
%%% numsvl1 is the count for nonzero lambda and numsvm1 is the number of nonzero mu
%%%%%%
wu = zeros(size(u(:,1)));
wv = zeros(size(v(:,1)));

for i=1:p
    wu = wu + lamb(i)*u(:,i);
end

for j=1:q
    wv = wv + mu(j)*v(:,j);
end

w = wu - wv;

svl1 = find(lamb>0);
svm1 = find(mu>0);
numsvl1 = length(find(lamb>0));
numsvm1 = length(find(mu>0));

su = zeros(n,1);
sv = zeros(n,1);

for k=1:numsvl1
    i = svl1(k);
    su = su + u(:,i);
end

for k=1:numsvm1
    j = svm1(k);
    sv = sv + v(:,j);
end

su = su / numsvl1;
sv = sv / numsvm1;

b = w' * (su + sv) / 2;

% Some additional error checking
nw = sqrt(w'*w);   % norm of w
fprintf('nw =  %.15f \n',nw)
delta = 1/nw;
fprintf('delta =  %.15f \n',delta)
if   delta < 10^(-9)
     fprintf('** Warning, delta too small, program does not converge ** \n')  
end

if n == 2
   [ll,mm] = showdata(u,v);
   if numsvl1 > 0 && numsvm1 > 0 
      showSVMs2(w,b,1,ll,mm,nw)
   end
end
end

