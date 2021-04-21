% This part looks at what happens when you have something slightly more complicated

%  Clean up the workspace
clear
close all
clc

%  Define the number of elements in the grid (CHANGE THIS!!!!!!)
number_of_elements = 10000;


%  Define the number of trials
num_trials = 100;

%  Define an x-y grid
x = linspace(-10, 10, number_of_elements);
y = linspace(-10, 10, number_of_elements);

%  Make storage for the time elapsed
elap_time = nan(num_trials,2);

%  Compute a 2D exponential using vectorized and built-in MATLAB methods
for t_counter = 1:num_trials
    tic
    [X, Y] = meshgrid(x, y);
    f1 = exp(X.^2 + Y.^2);
    elap_time(t_counter, 1) = toc;
end

%  Compute a 2D exponential using nested for loops
for t_counter = 1:num_trials
    tic
    f2 = nan(length(x), length(y));
    for x_counter = 1:length(x)
        for y_counter = 1:length(y)
            f2(x_counter, y_counter) = exp(x(x_counter)^2 + y(y_counter)^2);
        end
    end
    elap_time(t_counter,2) = toc;
end

%  Plot the results out, and label the plot
plot(elap_time);
legend('Vectorized', 'Not Vectorized')
title(['Time to make each exponential for a grid that is ', num2str(number_of_elements),...
       ' by ', num2str(number_of_elements)]);
xlabel('Trial Number')
ylabel('Elapsed Time')