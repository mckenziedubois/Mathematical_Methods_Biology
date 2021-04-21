x=0:0.1:2*pi;
y=sin(x);
plot(x,y,'k-*')
xlabel('x','Fontsize',14)
ylabel('sin(x)','Fontsize',14)
axis([0 2*pi -1.5 1.5])
set(gca, 'FontSize',14)