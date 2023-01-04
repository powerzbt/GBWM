function a_2 = DP_plot(V, p_table, state_wealthspace, T, w0, G)
    G = 200;
    w0_idx = find(state_wealthspace>=w0-0.00000001);
    w0_idx = w0_idx(1);
    %% suggestions
    close all;
    a_2 = figure(2)
    cum = cumsum(p_table, 1);
    hold on
    for t = 1:T
        plot(log(state_wealthspace), cum(:,t));
    end
    hold off
    
    
    
    xticks([log(state_wealthspace(1)), log(150), log(200), log(state_wealthspace(length(state_wealthspace)))]);
    s1 = int2str(state_wealthspace(1));
    s2 = int2str(150);
    s3 = int2str(200);
    s4 = int2str(state_wealthspace(length(state_wealthspace)));
    xticklabels({s1,s2,s3,s4})
    legend("t = 1","t = 2","t = 3","t = 4","t = 5","t = 6","t = 7","t = 8","t = 9","t = 10")
    title("Distribution of Wealth in Portillos wrt Time");
    ylabel("Cumulative Distribution")
    xlabel("Wealth in Portillos (W(t))")
    
    
    
    %% best actions
    b_1 = figure(3)
    
    imagesc(V)

    G_idx = find(state_wealthspace>=G*0.95);
    G_idx = G_idx(1);


    yticks([1, w0_idx, G_idx, length(state_wealthspace)])
    s1 = int2str(state_wealthspace(1));
    s2 = int2str(state_wealthspace(w0_idx));
    s3 = int2str(state_wealthspace(G_idx));
    s4 = int2str(state_wealthspace(end));
    yticklabels({s1,s2,s3,s4})
    xlabel("t in Years");
    ylabel("Wealth in Portillos (W(t))");
    title("State - Value Mapping");

end

