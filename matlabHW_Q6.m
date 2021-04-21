susan=[1800 1400 900 600 350 100 50];
julia=[1900 1350 800 500 130 60 0];
kim=[1700 1150 700 350 100 30 0];
average=mean([susan; julia; kim]);
standard_deviation=std([susan; julia; kim]);
time=[0 10 20 30 40 50 60];
plot(time,average,'k-*')
hold on 
axis([0 60 0 2000])
set(gca, 'FontSize',14)
xlabel('Time (minutes)','FontSize',16) 
ylabel('Concentrations of R (ug/mL)','FontSize',16) 
errorbar(time,average,standard_deviation,'k*-')