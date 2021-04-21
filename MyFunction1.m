function MyFunction1 (x0,x1,b)
% x0 is the lower bound of x and x1 is the upper bound 
x=x0:b:x1; 
y=sin(x); 
plot(x,y,'g-');
hold on; 
z=(x.^2)/100; 
plot(x,z,'b:');
xlabel('x'); 
ylabel('y, z'); 
legend('sin(x)', 'x^2/100'); 
hold off; 
