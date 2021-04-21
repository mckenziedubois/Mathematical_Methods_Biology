function zombielab
%
m=1/80;         %The probability of a natural death for each individual per year
alpha=20;        %Rate that an encounter would infect an individual over the course of a year.
z= 0.9;         %Rate that the dead turn into a zombie over the course of a year.
beta = 0.1; %Rate that susceptible individuals become infected but do not recover/die/or become zombies
k = 0.5;        %Rate that a zombie is killed in an encounter with a human.
gamma = 0.2; % Rate that people go from being infected to being dead 
Z0= 0.1;         %Initial proportion of the population that is zombies.
D0=0;  
U0=0.05; 
I0 =0; %The initial proportion of the infected.
S0=1-Z0-D0-U0-I0;     %The initial proportion of susceptibles
MaxTime=1;      %Maximum time simulated

S=S0; Z=Z0; D=D0; U=U0; I=I0  %Set each state variable to its initial condition

% The main iteration, use ode45 to solve this system of ODE's 
[t, y]=ode45(@ZombieSZD,[0 MaxTime],[S Z D U I],[],[m alpha k z beta gamma]);

S=y(:,1); Z=y(:,2); D=y(:,3); U=y(:,4); I=y(:,5); %set each state variable equal to the solution
T = y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5);


% plots the graphs with scaled colours
l=figure(1);
subplot(2,1,1)
h=plot(t,S,'-g',t,Z,'-k'); 
legend('Susceptible', 'Zombie');
xlabel 'Time';
ylabel 'Susceptibles and Zombies'

subplot(2,1,2) 
h=plot(t,I,'b',t,D,'-r');
xlabel 'Time';
legend('Infected', 'Dead');
ylabel 'Infected and Dead'


%save the figure as zombieSZD-Z0-0p1.jpg. Change the name to not write over
%the file
saveas(l,'zombieSZDU-Z0-0p01.jpg')

% Calculates the differential rates used in the integration.
function dy=ZombieSZD(t,y, parameter)

% Set each parameter equal to its value in the parameter vector
m=parameter(1); alpha=parameter(2); k = parameter(3); z = parameter(4); beta = parameter(5); gamma = parameter(6);
%Set each state variable equal to its value from the y vector
S=y(1); Z=y(2); D=y(3); U=y(4); I=y(5) 

%Initialize the dPop vector
dy=zeros(5,1);

%The system of equations below is what is to be solved
dy(1)= -alpha*S*Z - m*S  -beta*S; %the equation for dS/dt
dy(2)= z*U - k*S*Z; %the equation for dZ/dt
dy(3)= m*S + k*S*Z; %the equation for dD/dt
dy(4)= alpha*S*Z - z*U; %The equation for dU/dt
dy(5)= beta*S - I*gamma; %The equation for dI/dt
