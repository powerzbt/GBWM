function Q = Qlearning(Q, R, TP_cmf_j, state_wealthspace, qln_prams)
    T = qln_prams(1);
    w0 = qln_prams(2);
    maxItr = qln_prams(3);
    alpha = qln_prams(4);
    gamma = qln_prams(5);
    

    w0_idx = find(state_wealthspace>=w0-0.00000001);
    w0_idx = w0_idx(1);


    %R = zeros(A,B,C);
    %R(:,:,C) = 1;

    %Q = R;

    for cnt_Itr = 1:maxItr 

        epsilon = max(0, 1-3*cnt_Itr/maxItr);
        cs = w0_idx;


        % for the following part, a is i, b is t
        t = 1;

        while(t<T)      % do not update for t = T
            %% action selection
            %if mod(cs,A) ~= 0 
            %
            %    b = int32(fix(cs / A) +1);
            %    a = int32(mod(cs,A));
            %else
            %    b = int32(fix(cs / A));
            %    a = A;
            %end
            
            idx_curr_actions = 1:size(Q,3);  % total # of actions

            seed_action = rand;
            if seed_action < epsilon  % explore
                chosen_action = idx_curr_actions(randi([1, length(idx_curr_actions)]));
            else
                
                
                Q_actions = [];
                for itr = 1:size(Q,3)
                    Q_actions = [Q_actions, Q(cs,t,itr)];

                end
                 

                chosen_action = find(Q_actions >= max(Q_actions)-0.00000001);
                chosen_action = chosen_action(randi(length(chosen_action)));
            end


            
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
    end
 
end





% c = containers.Map
% c('foo') = 1
% c(' not a var name ') = 2
% keys(c)
% values(c)      
% str2num('234');
% num2str(234);
% 
% ns = idx_actions(randi([1, length(idx_actions)],1,1))
%         max_q = Q;
%         actions = find(reward(nx,:)>0);
%         possible_actions = max(qvalue(idx_actions));

