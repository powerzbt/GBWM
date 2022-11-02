function R = Init_R(state_wealthspace, G, T)
    R = zeros(length(state_wealthspace), T);
    R(find(state_wealthspace >=G), T) = 1;
    
end

