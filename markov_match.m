%  Check to make sure that the markov matrix and probability vector are
%  compatible 
%  YOU NEED TO WRITE THIS FUNCTION, DEFINE THE INPUTS IT TAKES, AND DEFINE
%  THE OUTPUTS IT GIVES
function result = markov_match(mat, vec)
    
    msize = size(mat); 
    psize = size(vec);

    mcol = msize(1);
    prow = psize(2);

    if mcol == prow; 
         result = true
    else;
        result = false
        disp('The matrices are not compatible')
    end
    
return
