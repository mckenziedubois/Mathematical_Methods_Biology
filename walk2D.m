function walk2D(N);

%Simulates a random walker for N time steps that has an equally likely chance of moving
%left, right, up or down.
clf;
stepsize=1;   %enter the step size for the walker to take

x=zeros(1,N); %initialize vector to hold x positions
y=zeros(1,N); %initialize vector to hold y positions
x(1,1)=0;   %set initial position
y(1,1)=0;   %set initial position

for i=2:N, %loop through all of the time steps
    r = rand; %pick a random number between 0 and 1 to determine if you go left/right or up/down
    if r>0.47, %go left/right
        r1 = rand; %pick a random number between 0 and 1 to determine of you go left or right
        if r1>0.47, %go right
            y(1,i)=y(1,i-1);
            x(1,i)=x(1,i-1)+stepsize;    
        else %go left
            y(1,i)=y(1,i-1);
            x(1,i)=x(1,i-1)-stepsize;
        end
    else %go up/down
        r2=rand; %pick a random number between 0 and 1 to determine if you go up or down
        if r2>0.5, %go up
            x(1,i)=x(1,i-1);
            y(1,i)=y(1,i-1)+stepsize;    
        else %go down
            x(1,i)=x(1,i-1);
            y(1,i)=y(1,i-1)-stepsize;
        end
    end
end

%this is done to set axes
xmax = max(abs(x))+1;
ymax = max(abs(y))+1;

%hold on
plot(x,y,'r');    % plot the path
axis([-N/2 N/2 -N/2 N/2]);

axis square
title(['Two-dimensional ' int2str(N) '-step random walk']);
zoom on