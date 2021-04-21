function nagumo1d
%Solves the FitzHugh Nagumo equations in 1 spatial dimension and creates a
%movie.

Npulse = 1;
t_final = 200*Npulse;    %Sets the final time
pulse = t_final/Npulse;   %determines the length of time between pulses.
    
length = 1000;       %sets the length of the neuron/nerve
N = 200;            %sets the number of spatial steps
dx = length/N;      %determines the distance between spatial steps.
T = 400000;         %sets the final time.
dt = t_final/T;     %determines the time step taken

a= 0.01;         %threshold potential
b = 0.01;      %parameters in fitzhugh
gamma=0.5;        %parmater in fitzhugh
D=10;           %diffusion coefficient
I_mag = .1;    %magnitude of input current
i1 = 0.35;      %fraction of total length where current starts
i2 = 0.4;       %fraction of total length where current ends
dp = t_final/200;  %Set the duration of the current pulse
pulse_time = 0; %pulse time is used to store the time that the next pulse of current will happen
time = 0;       %time holds the current time, we are starting at zero

v = zeros(1,N);     %this vector holds all of the values of v along the length of the neuron
w = zeros(1,N);     %this vector holds all of the values of w along the length of the neuron
v_old = zeros(1,N); %this vector holds all of the previous values of v along the length of the neuron
w_old = zeros(1,N); %this vector holds all of the preivous values of w along the length of the neuron
dist = zeros(1,N);  %this vector holds all of the distances along the neuron where the FH-Nagumo equations are solved.

%Determine all of the positions where FHN equations are solved
for i = 1:N,
    dist(i) = (i-1)*dx;
end

II=zeros(1,N);          %this vector holds the values of the applied current along the length of the neuron
dptime = t_final/100;   %This sets the length of time frames that are saved to make a movie.
ptime = 0;              %holds the time when the next frame will be printed.
k=1;    %holds the frame number

while time<t_final,
    
    %the next two equations give how to solve for v and w on the left
    %boundary.
    v(1) = 0;
    %v(1) = v_old(1)+dt*(((D/(dx*dx))*(v_old(2)-2*v_old(1)+v_old(N)))-v_old(1)*(v_old(1)-1)*(v_old(1)-a)-w_old(1)+II(1));
    %w(1) = w_old(1)+dt*(b*(v_old(1)-gamma*w_old(1)));
    
    %Check to see if there should be a pulse
    if time>(pulse_time),
        for i=(floor(i1*N):floor(i2*N)),
            II(i) = I_mag;  %sets the region of the pulse to a current amplitude of I_mag
        end
        %checks to see if the pulse is over and then resets pulse_time to
        %the next pulse time.
        if time>(pulse_time+dp),
            pulse_time = pulse_time+pulse;
        end
    else
        II = zeros(1,N);
    end
        
    %Loop through and solve for v and w in the middle of the neuron
    for i = 2:N-1,
        v(i) = v_old(i)+dt*(((D/(dx*dx))*(v_old(i+1)-2*v_old(i)+v_old(i-1)))-v_old(i)*(v_old(i)-1)*(v_old(i)-a)-w_old(i)+II(i));
        w(i) = w_old(i)+dt*(b*(v_old(i)-gamma*w_old(i)));
    end
    
    %the next two equations give how to solve for v and w on the right
    %boundary.
    v(N) = 0;
    %v(N) = v_old(N)+dt*(((D/(dx*dx))*(v_old(1)-2*v_old(N)+v_old(N-1)))-v_old(N)*(v_old(N)-1)*(v_old(N)-a)-w_old(N)+II(N));
    %w(N) = w_old(N)+dt*(b*(v_old(N)-gamma*w_old(N)));
    
    %This is used to determine if the current time step will be a frame in
    %the movie
    if time>ptime,
        figure(1)
        plot(dist, v);
        axis([0 1000 -0.5 1.5]);
        xlabel('Distance (x)');
        ylabel('Electropotenital (v)');
        F(k) = getframe;    %add frame to the movie
        frame = getframe;
        k = k+1; 
        ptime = ptime+dptime;
    end
    
    time = time+dt; %update in time
    v_old = v;  %sets v from the current time step to the previous time step.
    w_old = w;  %sets w from the current time step to the previous time step.
    
end
   