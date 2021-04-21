%  Check the probablility vector
%  YOU NEED TO WRITE THIS FUNCTION, DEFINE THE INPUTS IT TAKES, AND DEFINE
%  THE OUTPUTS IT GIVES
function result = vec_check(vec, precision)
    vec = round(vec,precision);
    vsum = round(sum(vec,2),precision)
    if vsum == 1
        result = true; 
    else
        result = false;
        disp('The probability matrix is not admissable as it does not sum to 1')
    end
return 