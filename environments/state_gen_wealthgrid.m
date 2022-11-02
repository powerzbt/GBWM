function grid = state_gen_wealthgrid(w0, cash, actions_mu_sig, rho)

 
    z_min = -3;
    z_max = 3;                  % standard gaussian
    h = 1;
    
    t = length(cash);                  % include t0           % cash flows      total time (T)
    mu_tmp = actions_mu_sig(:,1);           % all the mu for all possible efficient frontier
    sig_tmp = actions_mu_sig(:,2);          % all the sigma for all possible efficient frontier
    mu_min = min(mu_tmp);
    mu_max = max(mu_tmp);
    sig_max = max(sig_tmp);
    sig_min = min(sig_tmp);
    emap_max = zeros(length(cash),1);
    emap_min = zeros(length(cash),1);
    
    I = 1:length(cash);
    emap_max = exp(1) .^ ((mu_max - sig_max ^ 2 / 2) * h * I + z_max * sig_max * (h * I .^ 0.5));
    emap_min = exp(1) .^ ((mu_min - sig_max ^ 2 / 2) * h * I + z_min * sig_max * (h * I .^ 0.5));
    
    %for i = 1: len(cash)       %  state space for all possible time     
    %    emap_max(i) = exp(1) ^ ((mu_max - sig_max ^ 2 / 2) * h * i + z_max * sig_max * (h * i ^ 0.5));
    %    emap_min(i) = exp(1) ^ ((mu_min - sig_max ^ 2 / 2) * h * i + z_min * sig_max * (h * i ^ 0.5));
    %end

    w_min = 1/0;
    w_max = -1/0;
     
    
    for i =1:t
        
        cur_min = w0 * emap_min(i) + sum(cash(1:i)' .* emap_min(i:-1:1));
        cur_max = w0 * emap_max(i) + sum(cash(1:i)' .* emap_max(i:-1:1));
        
        w_min = min(cur_min, w_min);
        w_max = max(cur_max, w_max);
    end
        
        
        
    grid = [];
    cur = log(w_min);
    log_max = log(w_max);
    % print(cur, log_max, sig_min)
    while cur < log_max                        
        grid = [grid , [cur]];                        % state space
        cur = cur+ h ^ 0.5 * sig_min / rho;
    end
    grid= [grid , [log_max]];
    % print(grid)
    log_w0 = log(w0);
    shift = 1/0;
    % w0_idx = 0;
    for i = 1:length(grid)
        x = grid(i);
        if x - log_w0 >= shift && x - log_w0 >= 0
                                        % when this is satisfied, w0_idx = index of w0
        else
            shift = x - log_w0;     % insure that it is non-decreasing
            w0_idx = i;          % try to find the index of w0
        end
    end
    
    grid = grid - shift;               % make it to be w0 centered
    grid = exp(grid);
    grid = grid';
     


end

