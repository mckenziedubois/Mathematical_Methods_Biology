function x=NegativeFeedback_Oscillator()

clear all
clc
close all
%Negative Feedback
%Parameters from Tyson paper

%rate constants and total concentrations from Tyson
k0=0;
k1=1;
k2=0.01;
k2_prime=10;
k3=0.1;
k4=0.2;
k5=0.1;
k6=0.05;
YT=1;
RT=1;
Km3=0.01;
Km4=0.01;
Km5=0.01;
Km6=0.01;

%Signal values and output vectors for bifurcation diagram
svals  = [0:0.5:7];     %Vary signal from 0 to 7 in increments of 0.5.
[l,m] = size(svals);    %Find number of signal values
rmax = zeros(1,m);     %Initialize vectors to store rmin and rmax
rmin=zeros(1,m);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PLOT OF CONCENTRATION VS TIME for one choice of parameters

S=3;        %selected signal for part 1
X=0;        %initial amount of X
Yp=0;       %initial amount of YP
Rp=0;       %initial amount of RP
xin=[X Yp Rp];      %xin is the initial values for ode45, here our initial value is just r
dt = 1;             %time step  
tfinal = 200;       %final time we are solving to
time = 0:dt:tfinal; %create a vector of times to solve our ODEs
  
%solve ODE for plot of variables vs time
[T,X] = ode45(@deriv,time,xin,[],k0,k1,k2,k2_prime,k3,k4,k5,k6,YT,RT,Km3,Km4,Km5,Km6,S);
%Plot time series
figure(1)
plot(T,X(:,1),T,X(:,2),T,X(:,3))
legend('X','Yp','Rp')
set(gca,'FontSize',14) %Changes the font size of the axes
xlabel('Time(s)','FontSize',14)
ylabel('Concentration','FontSize',14)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BIFURCATION DIAGRAM (i.e. SIGNAL RESPONSE CURVE)
%Solve ODE for sweeping S and solve for max r and min r
%Loop over all values of the signal
for k = 1:m
    s = svals(k);   %pick out the particular value of s
    X=0;            %initial amount of X
    Yp=0;           %initial amount of Y
    Rp=0;           %initial amount of R
    xin=[X Yp Rp];  %xin is the initial values for ode45, 
    dt = 10;        %time step for storing data
    tfinal = 2000;  %final simulation time
    time = 0:dt:tfinal;     %Create vector to hold time

    %Solve system of equations with another ode solver. The inputs are the
    %same.
    [T,X] = ode15s(@deriv,time,xin,[],k0,k1,k2,k2_prime,k3,k4,k5,k6,YT,RT,Km3,Km4,Km5,Km6,s);
    %pull out the values of  the last time
    xin=[X(end,1), X(end,2),X(end,3)];
    %Find the solution using the initial values taken at the end of the
    %last solve
	[T,X] = ode15s(@deriv,time,xin,[],k0,k1,k2,k2_prime,k3,k4,k5,k6,YT,RT,Km3,Km4,Km5,Km6,s);
   
    %Pull out the maximum and minimum values of RP.
    rmax(k) = max(X(:,3));
    rmin(k) = min(X(:,3));
end

%Plot bifurcation diagram
figure(2)
clf
plot(svals,rmax,'o-',svals,rmin,'o-')
xlabel('Signal')
ylabel('Response')
title('Bifurcation Diagram')

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Other functions

function y=deriv(t,x,k0,k1,k2,k2_prime,k3,k4,k5,k6,YT,RT,Km3,Km4,Km5,Km6,S)
        %write down the equations for the system of differential equations
        %Note that x(1) = X, x(2) = YP and x(3) = RP
        y=zeros(3,1);
        %initialize a vector that will hold the values of y(1) = dX/dt, y(2)
        %= dYP/dt and y(3)=dRP/dt
        y(1)=k0+k1*S-k2*x(1)-k2_prime*x(3)*x(1);
        y(2)=(k3*x(1)*(YT-x(2)))./(Km3+YT-x(2))-(k4*x(2))./(Km4+x(2));
        y(3)=(k5*x(2)*(RT-x(3)))./(Km5+RT-x(3))-(k6*x(3))./(Km6+x(3));
    end

function x = goldkosh(u,v,j,k)

%GoldKosh.m The Goldbeter-Koshland function

num = 2*u*k;
s = sqrt((v-u+v*j+u*k).^2 - 4*(v-u).*u*k);
den = v-u+v*j+u*k+s;

x = num./den;
end