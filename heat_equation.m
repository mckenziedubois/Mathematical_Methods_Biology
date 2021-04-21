%  Lab to look at implementation and diffusion

%  Clean up the workspace
clear
close all
clc

%  Define the number of time steps and spatial steps
num_x = 1000;
num_t = 100;

%  Define several diffusivity values
D = [1, 10, 100, 1000];


%  Define limits for the lower and upper bounds
x_limits = 10;
t_lower = 1;
t_upper = 100;
x = linspace(-x_limits, x_limits, num_x)';
t = linspace(t_lower, t_upper, num_t)';



%  Define an array that will hold how long it takes to compute the heat
%  equation in both vectorized and non_vectorized ways)
elapsed_time = nan(1, 2);

%  Number of diffusivity values
num_d = length(D);

%  Compute the heat equation using non-vectorized methods
tic
for d_counter = 1:num_d
    for x_counter = 1:num_x
        for t_counter = 1:num_t
            u_inefficent(x_counter,t_counter,d_counter) = ...
                         (1/sqrt(4*pi*D(d_counter)*t(t_counter)))*exp(-(x(x_counter).^2)./(4.*D(d_counter).*t(t_counter)));
        end
    end
end
elapsed_time(1) = toc;


%  Compute the heat equation using vectorized methods
u_efficient = nan(num_x, num_t, num_d);
[T, X] = meshgrid(t,x);

tic
for d_counter = 1:d_counter
    u_efficient(:,:,d_counter) = (1./sqrt(4*pi*D(d_counter).*T)).*exp( -(X.^2)./(4.*D(d_counter).*T));
end
elapsed_time(2) = toc;

%  Record the final x values for plotting
final_x = squeeze(u_efficient(:,end,:));


%  Plot out the results in subplots
for counter = 1:num_d
    subplot(num_d,1,counter)  %  If you change this line to figure, you will get multiple figure windows instead of a subplot
    surf(t, x, u_efficient(:,:,counter), 'linestyle', 'none')
    title(['D = ', num2str(D(counter))])
    xlabel('Time (s)')
    ylabel('x (m)')
    view([0, 90])
    colorbar
end

figure
plot(x, final_x, 'o-')
d_cell = cell(size(D));
for counter = 1:num_d
    d_cell{counter} = ['D = ', num2str(D(counter))];
end
legend(d_cell, 'location', 'northeastoutside')
title('Temperature distribution at the final time')
xlabel('x')
ylabel('Temperature')

%  Display (in the command window) how long each way took to run, and the
%  ratio "non_vectorized/vectorized".
disp(['Elapsed time for vectorized grid =     ', num2str(elapsed_time(2))])
disp(['Elapsed time for non-vectorized grid = ', num2str(elapsed_time(1))])
disp(['Ratio of non-vectorized to vectorized time = ', num2str(elapsed_time(1)/elapsed_time(2))])
disp(' ')