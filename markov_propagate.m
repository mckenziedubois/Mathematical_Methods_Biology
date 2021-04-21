%  Propagate the system
%  YOU NEED TO WRITE THIS FUNCTION, DEFINE THE INPUTS IT TAKES, AND DEFINE
%  THE OUTPUTS IT GIVES

function markov_propagate(mat, vec, num_steps, precision)

steady_state_time_step = 0; 

size_of_vec= size(vec) %tells me how many rows/columns my vec has
num_states = size_of_vec(2) %counts the number of columns so I know how many states I have

statestoplot = zeros(num_states,200); %creates array w/ a row for each state

statestoplot(:,1) = vec %sets the inital value of the statestoplot

for i=1:num_steps
    pN = (vec*(mat^i));
    pN = round(pN, precision)
    statestoplot(:,i+1) = pN;

end

for i=1:num_steps-2
    if (statestoplot(:,i) - statestoplot(:,i+1)) ==0
        steady_state_time_step = i;
        for j=i:length(statestoplot)-2
            statestoplot(:,j+2) = NaN;
        end


end 
end
for i=1:num_states
    plot(statestoplot(i,:))
    hold on
end

legend('State 1', 'State 2','State 3','State 4','State 5')
xlabel('Time Step')
ylabel('Probability')
disp(steady_state_time_step)



