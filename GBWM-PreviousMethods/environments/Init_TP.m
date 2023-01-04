function [TP, TP_cmf_j] = Init_TP(state_wealthspace, actions_mu_sig, cash, T)
    n_actions = size(actions_mu_sig, 1);
    TP = zeros(length(state_wealthspace), T, n_actions, length(state_wealthspace));
    TP_cmf_j = TP;
    for i = 1: length(state_wealthspace)
        for t = 1: T
            for a = 1: n_actions
                mu = actions_mu_sig(a,1);
                sig = actions_mu_sig(a,2);
                
                for j = 1: length(state_wealthspace)
                    x = 1 / sig * (log(state_wealthspace(j) / (state_wealthspace(i) + cash(t))) - (mu - sig ^ 2 / 2));
                    TP(i,t,a,j) = exp ( (-x ^ 2 / 2)) / (2 * pi) ^ 0.5;
                end
                
                TP(i,t,a,:) = TP(i,t,a,:) ./ sum(TP(i,t,a,:));
                cum = cumsum(TP,4);
                TP_cmf_j(i,t,a,:) = cum(i,t,a,:);
            end
        end
    end
end

