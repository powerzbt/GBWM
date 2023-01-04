function [a,b,c] = action_prams_to_get_sigs(avg_arr,cov_mat)
    if size(avg_arr,1) == 1         % row vector
        avg_arr = avg_arr';         % to a column vector
    end
 
    % g, h
    o = ones(size(avg_arr));
    inv_cov = inv(cov_mat);
    
    % k, l, p
    k = avg_arr' * inv_cov * o;
    l = avg_arr' * inv_cov * avg_arr;
    p = o' * inv_cov * o;

    g = (l * inv_cov * o - k * inv_cov * avg_arr) / (l * p - k ^ 2);
    h = (p * inv_cov * avg_arr - k * inv_cov * o) / (l * p - k ^ 2);

    % a, b, c
    a = h' * cov_mat * h;
    b = 2 * g' * cov_mat * h;
    c = g' * cov_mat * g;
  

end

