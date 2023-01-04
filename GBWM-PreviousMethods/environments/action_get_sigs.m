function sigs = action_get_sigs(mus,a,b,c)
    sigs = (a * mus .^ 2 + b * mus + c) .^ .5;
     
    
end

