
tspan = linspace(0,10,500);
xinit = [1; 0];
m=2; 
c=4; 
k=4;
[t,x] = ode45(@fname, tspan, xinit,[],m,c,k)
x1 = x(:,1); x2 = x(:,2); plot(t,x1); xlabel('t'); ylabel('x(t)');
