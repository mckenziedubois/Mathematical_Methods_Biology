%  This code looks at the difference between loops and vectorized code

%  Clean up the workspace
clear
close all
clc

%  Define the number of elements in a vector (CHANGE THIS!!!!!!!!)
number_of_elements = 1000000;

%  This is the number of times the code will run
num_trials = 100;

%  Create storage for an array of values
x_to_square = linspace(1,1000, number_of_elements);

%  Create storage for an array of values squared.  The FIRST ROW is from
%  squaring things one way, the SECOND ROW is from squaring things a
%  different way.
x_squared = nan(2, number_of_elements);

%  Create storage for how long each method takes
elapsed_time = nan(num_trials,3);

%  This computes x^2 three different ways, and times each way.  It does
%  this "num_trials" times, and then plots out the results so you can see
%  which way is the fastest.
for time_counter = 1:num_trials
    tic
    x0 = 0.1;
    for counter = 1:number_of_elements
        x_squared_raw(counter) = x_to_square(counter)^2;
    end
    x_squared(1,:) = x_squared_raw;
    elapsed_time(time_counter, 1) = toc;
    
    tic
    for counter = 1:number_of_elements
        x_squared(2,counter) = x_to_square(counter)^2;
    end
    elapsed_time(time_counter, 2) = toc;
    
    tic
    x_squared(3,:) = x_to_square.^2;
    elapsed_time(time_counter, 3) = toc; 
end

%  Plot out the results
plot(elapsed_time, 'o-')
legend('for_{raw}', 'for', 'vectorized')
title(['Time to make x^2 for ', num2str(number_of_elements), ' points'])
xlabel('Trial #')
ylabel('Run Time')