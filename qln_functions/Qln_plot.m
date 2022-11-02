function a_2 = Qln_plot(Q, R, TP_cmf_j, actions_mu_sig, state_wealthspace, qln_prams, total_itr)
    %% suggestions

    T = qln_prams(1);
    w0 = qln_prams(2); 
    G = qln_prams(6);

    w0_idx = find(state_wealthspace>=w0-0.00000001);
    w0_idx = w0_idx(1);
    
    close all
    [mus_qln, trace] = Qln_suggestion(Q, R, TP_cmf_j, state_wealthspace, qln_prams);
    
    mus = actions_mu_sig(:,1);
    a_1 = figure(1);


    hold on
    yyaxis left
    plot(1:T, state_wealthspace(trace));
    xlabel("t in monthes");
    ylabel("Wealth in portfolio, W(t)");

    yyaxis right
    scatter(2:T,mus(mus_qln));
    xlabel("t in monthes");
    ylabel("Wealth in portfolio, W(t)");
    
    title(" Dynamics of Wealth in Portfolio - Illustruction (w0=150)")


    hold off




 
    a_2 = figure(2);
    hold on

    trace_matrix = zeros(total_itr, T);
    mus_qln_matrix = zeros(total_itr, T-1);

    for itr = 1:total_itr
        [mus_qln, trace] = Qln_suggestion(Q, R, TP_cmf_j, state_wealthspace, qln_prams);
        trace_matrix(itr,:) = state_wealthspace(trace)';

        c = mus(mus_qln);
        mus_qln_matrix(itr,:) = c';
    end


    yyaxis left
    for itr = 1:total_itr
        trace = trace_matrix(itr,:);
        trace = trace';

        mus = actions_mu_sig(:,1);

        if trace(end) >= G
            plot(1:T, trace, '-o', 'Color', [min(0.8500+trace(end)/400, 1) 0.3250 0.0980]);
        else
            plot(1:T, trace, '-x', 'Color', [0 0.4470 min(0.7410+trace(end)/400, 1)]);
        end
    end
    xlabel("t in monthes");
    ylabel("Expected return \mu");



    yyaxis right
    for itr = 1:total_itr
        trace = trace_matrix(itr,:);

        c = mus_qln_matrix(itr,:);
        c = c';

        if trace(end) >= G
            scatter(2:T, c, 10, c, 'filled');
        else
            scatter(2:T, c, 10, c, "x");
        end

    end 
    xlabel("t in monthes");
    ylabel("Expected return \mu");

    
    title("Dynamics of Wealth in Portfolio (w0=150)");
    hold off

    
    
    
    %% best actions
    b_1 = figure(3);
    
    bext_actions = zeros(size(Q,1), size(Q,2));
    for cs = 1: size(Q,1)
        for t = 1:size(Q,2)
    
    
            Q_actions = [];
            for itr = 1:size(Q,3)
                Q_actions = [Q_actions, Q(cs,t,itr)];

            end


            chosen_action = find(Q_actions >= max(Q_actions)-0.00000001);
            chosen_action = chosen_action(randi(length(chosen_action)));
    
            bext_actions(cs, t) = chosen_action;
    
        end
    end
    imagesc(bext_actions)
    
    G_idx = find(state_wealthspace>=G-0.00000001);
    G_idx = G_idx(1);
    
    
    yticks([1, w0_idx, G_idx, length(state_wealthspace)])
    s1 = int2str(state_wealthspace(1));
    s2 = int2str(state_wealthspace(w0_idx));
    s3 = int2str(state_wealthspace(G_idx));
    s4 = int2str(state_wealthspace(end));
    yticklabels({s1,s2,s3,s4})
    xlabel("Optimal Strategy for Portfolio Optimization (with diff w0)");


end

