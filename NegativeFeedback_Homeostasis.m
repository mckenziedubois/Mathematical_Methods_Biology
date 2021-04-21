function x=NegativeFeedback_Homeostasis()

clear all
clc
close all
%Negative Feedback
%Parameters from Tyson paper
 
%rate constants and total concentrations from Tyson
%YOU HAVE TO FIX THESE TO BE THE CORRECT VALUES!!!!!!!!
k0= 1;
k2= 1;
k3= 0.5;
k4= 1;
J3= 0.01;
J4= 0.01;

 
 
%Signal values and output vectors for bifurcation diagram
svals  = [0:0.1:2];     %Vary signal from 0 to 7 in increments of 0.5.
[l,m] = size(svals);    %Find number of signal values
rmax = zeros(1,m);     %Initialize vectors to store rmin and rmax
rmin=zeros(1,m);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PLOT OF CONCENTRATION VS TIME for one choice of parameters
 
S=1;        %selected signal for part 1
Rp=0;       %initial amount of RP
xin=[Rp];      %xin is the initial values for ode45, here our initial value is just r
dt = 1;             %time step  
tfinal = 200;       %final time we are solving to
time = 0:dt:tfinal; %create a vector of times to solve our ODEs
  
%solve ODE for plot of variables vs time
[T,X] = ode45(@deriv,time,xin,[],k0,k2,k3,k4,J3,J4,S);
%Plot time series
figure(1)
plot(T,X(:,1))
legend('Rp')
set(gca,'FontSize',14) %Changes the font size of the axes
xlabel('Time(s)','FontSize',14)
ylabel('Concentration','FontSize',14)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BIFURCATION DIAGRAM (i.e. SIGNAL RESPONSE CURVE)
%Solve ODE for sweeping S and solve for max r and min r
%Loop over all values of the signal
for k = 1:m
    s = svals(k);   %pick out the particular value of s
    Rp=0;           %initial amount of R
    xin=[Rp];  %xin is the initial values for ode45, 
    dt = 10;        %time step for storing data
    tfinal = 100;  %final simulation time
    time = 0:dt:tfinal;     %Create vector to hold time
 
    %Solve system of equations with another ode solver. The inputs are the
    %same.
    [T,X] = ode15s(@deriv,time,xin,[],k0,k2,k3,k4,J3,J4,s);
    %pull out the values of  the last time
    xin=[X(end,1)];
    %Find the solution using the initial values taken at the end of the
    %last solve
    [T,X] = ode15s(@deriv,time,xin,[],k0,k2,k3,k4,J3,J4,s);
   
    %Pull out the maximum and minimum values of RP.
    rmax(k) = max(X(:,1));
    rmin(k) = min(X(:,1));
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
 
function y=deriv(t,x,k0,k2,k3,k4,J3,J4,S);
   %FILL THIS IN
  y = zeros(1,1);
  y = k0*goldkosh(k3,k4*x,J3,J4) - k2*S*x;
end
 
function x = goldkosh(u,v,j,k)
 
%GoldKosh.m The Goldbeter-Koshland function
 
num = 2*u*k;
s = sqrt((v-u+v*j+u*k).^2 - 4*(v-u).*u*k);
den = v-u+v*j+u*k+s;
 
x = num./den;
end   