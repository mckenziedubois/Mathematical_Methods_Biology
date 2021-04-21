function dx = fname(t,x,m,c,k)
dx = zeros(size(x)); dx(1) = x(2); dx(2) = -(c/m)*x(2)-(k/m)*x(1);