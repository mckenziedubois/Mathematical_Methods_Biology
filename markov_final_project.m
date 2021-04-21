%  CLEAN UP THE WORKSPACE

clear
close all
clc


%  Set the variable "Selection" to 1, 2, 3, or 4 to try your code out with
%  the following matricies and probability vectors.  feel free to mess with
%  these if you really want to put your code throught its paces!
selection = 4;

switch selection
    case 1
        mat = [[1 0 0 0 0]; [0.2 0.6 0.2 0 0]; [0 0.2 0.6 0.2 0]; [ 0 0 0.2 0.6 0.2 ]; [ 0 0 0 0 1]]; % markov transistion matrix
        vec = [0 0.2 0.2 0.3 0.3]; % initial distribution
        
    case 2
        mat = [[0.8 0.2 0 0 0]; [0.2 0.6 0.2 0 0]; [0 0.2 0.6 0.2 0]; [ 0 0 0.2 0.6 0.2 ]; [ 0 0 0 0.2 0.8]]; % markov transistion matrix
        vec = [0 0.2 0.2 0.3 0.3]; % initial distribution
        
    case 3
        mat = [[0.6 0.2 0 0 0.2]; [0.2 0.6 0.2 0 0]; [0 0.2 0.6 0.2 0]; [ 0 0 0.2 0.6 0.2 ]; [ 0.2 0 0 0.2 0.6]]; % markov transistion matrix
        vec = [0 0.2 0.2 0.3 0.3]; % initial distribution
        
    case 4
        mat = [[0.3 0.5 0.2]; [0.6 0.3 0.1]; [0.6 0.3 0.1]]; % markov transistion matrix
        vec = [0.5 0.2 0.3]; % initial distribution
    otherwise
        disp('Please set selection to 1, 2, 3, or 4, and try again')
        return
end

%  YOU NEED TO SET THESE TO SOMETHING
precision = 4;
num_steps = 200;


%  Check the transition matrix
%  YOU NEED TO WRITE THIS FUNCTION, DEFINE THE INPUTS IT TAKES, AND DEFINE
%  THE OUTPUTS IT GIVES
if ~transition_check(mat, precision)
   return
end

%  Check the probablility vector
%  YOU NEED TO WRITE THIS FUNCTION, DEFINE THE INPUTS IT TAKES, AND DEFINE
%  THE OUTPUTS IT GIVES
if ~vec_check(vec, precision)
    return
end

%  Check to make sure that the markov matrix and probability vector are
%  compatible 
%  YOU NEED TO WRITE THIS FUNCTION, DEFINE THE INPUTS IT TAKES, AND DEFINE
%  THE OUTPUTS IT GIVES
if ~markov_match(mat, vec)
    return
end

%  Propagate the system
%  YOU NEED TO WRITE THIS FUNCTION, DEFINE THE INPUTS IT TAKES, AND DEFINE
%  THE OUTPUTS IT GIVES
markov_propagate(mat, vec, num_steps, precision);


 
 