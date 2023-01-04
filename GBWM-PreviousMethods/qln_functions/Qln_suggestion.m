function [mus_qln, trace] = Qln_suggestion(Q, R, TP_cmf_j, state_wealthspace, qln_prams)
    T = qln_prams(1);
    w0 = qln_prams(2);
    alpha = qln_prams(4);
    gamma = qln_prams(5);
    

    w0_idx = find(state_wealthspace>=w0-0.00000001);
    w0_idx = w0_idx(1);
    
    mus_qln = [];
    trace = [];

    cs = w0_idx;

 
    t = 1;

    while(t<T)      % do not update for t = T
        trace = [trace cs];

        Q_actions = [];
        for itr = 1:size(Q,3)
            Q_actions = [Q_actions, Q(cs,t,itr)];

        end


        chosen_action = find(Q_actions >= max(Q_actions)-0.00000001);
        chosen_action = chosen_action(randi(length(chosen_action)));

        mus_qln = [mus_qln, chosen_action];
        %% state simulation
        seed_state = rand;
        cdf = [];
        for itr = 1:size(TP_cmf_j,4)
            cdf = [cdf, TP_cmf_j(cs, t, chosen_action, itr)];

        end

        ns = find(cdf >= seed_state);
        ns = ns(1);

        % TP_cmf_j   (i, t, a, j)

        Q(cs,t,chosen_action) = Q(cs,t,chosen_action) + alpha * (R(ns, t+1)+gamma* max(max(Q(ns, t+1,:))) - Q(cs,t,chosen_action));
        cs = ns;

        t = t + 1;
    end
    trace = [trace ns];
end