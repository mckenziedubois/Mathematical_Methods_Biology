susan=[1800 1400 900 600 350 100 50];
julia=[1900 1350 800 500 130 60 0];
kim=[1700 1150 700 350 100 30 0];

time=[0 10 20 30 40 50 60]

plot(time,susan,'b-*')
hold on 
plot(time,julia,'r-o')
hold on 
plot(time,kim,'k-+')

set(gca, 'FontSize',14)
axis([0 60 0 2000])
xlabel('Time (minutes)','FontSize',14) 
ylabel('Concentrations of R (ug/mL)','FontSize',14) 
legend('Susan','Julia','Kim','FontSize',14)
