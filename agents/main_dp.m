clear
clc
close all
%% Action Space

% ------- mu--------

% parms to define action space
n_actions = 15;% size of action space

mus_l = 0.0526;  % left end of mu vector
mus_r = 0.0886;  % right end of mu vector
mus = mus_l: (mus_r-mus_l)/(n_actions-1): mus_r;



% ------- sigma--------
% prams to get sigs
avg_arr = [0.0493, 0.0770, 0.0886];
cov_mat = [ [0.0017, -0.0017, -0.0021];[-0.0017, 0.0396, 0.03086];[-0.0021, 0.0309, 0.0392] ];



% mu_sig pairs
actions_mu_sig = zeros(n_actions, 2); % action space = [mu1, sigma1;
                                               %mu2, sigma2; ]
[a,b,c] = action_prams_to_get_sigs(avg_arr,cov_mat);
actions_mu_sig(:,1) = mus';
actions_mu_sig(:,2) = action_get_sigs(actions_mu_sig(:,1), a,b,c);
                                               


%% State Space


w0 = 150;
G = 200;
rho = 1;  % may not be that gamma
T = 10;
cash = zeros(T,1);
state_wealthspace = state_gen_wealthgrid(w0, cash, actions_mu_sig, rho); % find all possible wealth 




%% Transition Probability
            % for                       (i, t, a, j)
[TP, TP_cmf_j] = Init_TP(state_wealthspace, actions_mu_sig, cash, T);

 
%% Initilize V table   
            % for state(money, t)       (i, t)
V = Init_V(state_wealthspace, G, T);


%% train Q learning agent -- w0 = 150
maxItr = 10;
alpha = 0.2;
gamma = 0.9;
dp_prams = [T, w0, maxItr, alpha, gamma, G];
[V, p_table] = DynamicProgramming(V, TP, state_wealthspace, dp_prams);


%% DP suggestion   -- w0 = 150
a_2 = DP_plot(V, p_table, state_wealthspace, T, w0, G)













 
