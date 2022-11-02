function V = Init_V(state_wealthspace, G, T)
    V = zeros(length(state_wealthspace), T);
    V(find(state_wealthspace >=G), T) = 1;
    
end

