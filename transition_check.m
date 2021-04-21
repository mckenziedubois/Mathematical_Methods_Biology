%  Check the transition matrix
%  YOU NEED TO WRITE THIS FUNCTION, DEFINE THE INPUTS IT TAKES, AND DEFINE
%  THE OUTPUTS IT GIVES
function result = transition_check(mat,precision)
    mat = round(mat,precision);
    msize = size(mat); 
    matsum = round(sum(mat,2),precision)
    if all(matsum ==1) 
        result = true
    else;
        result = false
        disp('The transition matrix is not admissable, the sum across  all rows does not sum to 1')
    end
return
