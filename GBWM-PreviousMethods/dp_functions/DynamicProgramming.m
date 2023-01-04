function [V, p_table] = DynamicProgramming(V, TP, state_wealthspace, dp_prams)

    T = dp_prams(1);
    w0 = dp_prams(2); 
    maxItr = dp_prams(3); 

    w0_idx = find(state_wealthspace>=w0 * 0.95);
    w0_idx = w0_idx(1);
    Optimal_policy = zeros(size(TP,1), size(TP,2));
             % for                       (i, t, a, j)
             
    %% v-table
    for itr = 1: maxItr
        for i = 1:size(TP,1)
            for t = T-1:-1:1
                tp_slice = TP(i, t, :, :);
                wj = V(:,t+1);
                WJ = zeros(1,1,size(TP,3), size(TP,4));
                for a = 1: size(TP,3)

                    WJ(1,1,a,:) = wj;
                end

                % total_prob = sum(sum(tp_slice));

                V_a = sum(WJ .* tp_slice, 4);

                V_a_simple = zeros(1,length(V_a) );
                for idx = 1:length(V_a)
                    V_a_simple(idx) = V_a(idx);
                end

                best_action_idx = find(V_a_simple>=(max(V_a_simple)*0.95));
                best_action = best_action_idx(1);

                V(i,t) = max(V_a);
                Optimal_policy(i, t) = best_action;

            end

        end
    end

    
    
    
    
    %% prob.
    p_table = zeros(size(TP,1), size(TP,2));
    p_table(w0_idx, 1) = 1;
    
    
    
    
    for t = 2:size(TP, 2)
        for j = 1: size(TP, 4)
            
            trans_p = zeros(size(TP,1), 1);
            for i = 1:size(TP,1)
                trans_p(i) = TP(i, t-1, Optimal_policy(i, t-1), j);
            end
            
             
            
            p_table(j,t) = sum(p_table(:,t-1)' * trans_p);
            
        
        end
    end
    
     
    
    
    
end

