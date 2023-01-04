
<h1 align="center"> Dynamic Goals-Based Wealth Management with Reinforcement Learning </h1>
 
## **Overview**:

This project suggests using reinforcement learning to address portfolio optimization challenges. It is mentored by Mathworks'
**[Valerio Sperandeo](https://wiza.co/d/the-mathworks_2/d598/valerio-sperandeo)** and **[Alejandra Pena-Ordieres](https://www.linkedin.com/in/alejandra-pena-ordieres)**.

Simply put, the purpose is to optimize the probability of meeting the target after making periodic investments in a particular portfolio by altering weights based on remaining time and wealth in hand.

This is a sequential decision-making problem, at which reinforcement learning excels. In this project, we developed a reinforcement learning system that provides investors with regular investment recommendations based on their investing goals. We researched the  different reward 
While what intestors should perform is straightforward:

If you know the combination of stocks you want to invest in and tell our system what sort of rate of return you want after how many years, our system will be able to swiftly and dynamically give you with the best feasible option in order to reach your goal.


## **To run**:

Set up and run **[GBWM-RLToolbox/main.mlx](https://github.com/powerzbt/GBWM/blob/main/GBWM-RLToolbox/main.mlx)** by

1. Specifying the symbols of stocks want to invest in
2. Specifying the period of investment (in years) 
3. Specifying the total expected return 


## **Demo**:

```matlab:Code 
initDate = '2017-01-01';
endDate = '2018-01-01';
initDate = datetime(initDate, 'InputFormat','yyyy-MM-dd');
endDate = datetime(endDate, 'InputFormat','yyyy-MM-dd');
portfolio = ["URTH"; "HYG";"LQD";"DBC"];
c = containers.Map;
for k=1:length(portfolio)
   symbol = portfolio(k);
   data = Yahooscraper(convertStringsToChars(symbol), initDate, endDate, '1d');
   TT = table2timetable(data(:,[1,4]));
   TT.Properties.VariableNames = {convertStringsToChars(symbol)};
   c(symbol) = TT;
end
f = @(i) c(portfolio(i));
T = synchronize(f(1),f(2),f(3), f(4), 'Intersection');
prices = [T.URTH, T.HYG, T.LQD, T.DBC];
ts = timeseries(prices, datestr(T.Date));
ts.Name = " Portfolio Prices over Time";
plot(ts);
legend({'URTH'; 'HYG';'LQD';'DBC'});
...

```
  
### Training with Mylti-Factor Environment
```matlab:Code
env =  MultiFactorGBWMEnvironment(G, T, grid, cash, w0_idx, pwgt, pret, prsk, line, simulate_n_periods, simulate_dt, simulate_n_trials);

``` 


Optimal Policy (Indicated by color, the colder the riskier):

<img src="GBWM-RLToolbox/images/MultiFactor_policy.png" style="width: 550px;"/>

100 Investment Trials with Optimal Policy: (Red Lines: successful investments)

<img src="GBWM-RLToolbox/images/MultiFactor_investment.png" style="width: 550px;"/>

Training Episodes:

<img src="GBWM-RLToolbox/images/LineReward_training.png" style="width: 550px;"/>


### Training with Line Reward Environment
```matlab:Code
env =  LineGoalGBWMEnvironment(G, T, grid, cash, w0_idx, pwgt, pret, prsk, line, simulate_n_periods, simulate_dt, simulate_n_trials);

``` 

 <p float="left">
  <img src="GBWM-RLToolbox/images/LineReward_policy.png" height="250px" />
  <img src="GBWM-RLToolbox/images/LineReward_investment.png" height="250px" /> 
  <img src="GBWM-RLToolbox/images/LineReward_training.png" height="250px" />
</p>
  
### Training with Scale Goal Environment
```matlab:Code
env =  ScaleGBWMEnvironment(G, T, grid, cash, w0_idx, pwgt, pret, prsk, gamma, simulate_n_periods, simulate_dt, simulate_n_trials);

``` 

 <p float="left">
  <img src="GBWM-RLToolbox/images/ScaleGoal_policy.png" height="250px" />
  <img src="GBWM-RLToolbox/images/ScaleGoal_investment.png" height="250px" /> 
  <img src="GBWM-RLToolbox/images/ScaleGoal_training.png" height="250px" />
</p>
  
  
 ### Training with Sparse Goal Environment
```matlab:Code
env =  SparseGoalGBWMEnvironment(G, T, grid, cash, w0_idx, pwgt, pret, prsk, simulate_n_periods, simulate_dt, simulate_n_trials);

``` 

 <p float="left">
  <img src="GBWM-RLToolbox/images/SparseGoal_policy.png" height="250px" />
  <img src="GBWM-RLToolbox/images/SparseGoal_investment.png" height="250px" /> 
  <img src="GBWM-RLToolbox/images/SparseGoal_training.png" height="250px" />
</p>
  
-------------------------------------------------------

<h2 align="left"> Previous Methods </h2>
Portfolio Optimization by Reinforcement Learning (Q-learning) and Dynamic Programming with **[MATLAB](https://www.mathworks.com/products/matlab.html)**.


## **To run**:
Reinforcement-learning:
	Open and run **[agent/main_qln.m](https://github.com/powerzbt/GBWM/blob/main/agents/main_rl.m)** 
OR
	**[rl_demo.mlx](https://github.com/powerzbt/GBWM/blob/main/rl_demo.mlx)**.

Dynamic Programming:
	Open and run **[agent/main_dp.m](https://github.com/powerzbt/GBWM/blob/main/agents/main_dp.m)** 
OR
	**[dp_demo.mlx](https://github.com/powerzbt/GBWM/blob/main/dp_demo.mlx)**.


## **Demonstration**:
Open 
	**[rl_demo.pdf](https://github.com/powerzbt/GBWM/blob/main/rl_demo.pdf)** 
OR
	**[dp_demo.pdf](https://github.com/powerzbt/GBWM/blob/main/dp_demo.pdf)**.


## **DEMO - RL**:

```matlab:Code
clear
clc
```
  
### Training with Fixed Initial Wealth 
```matlab:Code
total_itr = 100;
[mus_qln, trace] = Qln_suggestion(Q, R, TP_cmf_j, state_wealthspace, qln_prams);
n = Qln_plot(Q, R, TP_cmf_j, actions_mu_sig, state_wealthspace, qln_prams, total_itr);
``` 

Sample Investment Sequence (2-D State Space: investment period & wealth in hand):

<img src="rl_demo_images/figure_0.png" style="width: 550px;"/>

Optimal Q-learning Policy (Indicated by color, the colder the riskier):

<img src="rl_demo_images/figure_2.png" style="width: 550px;"/>

100 Investment Trials with Optimal Policy: (Red Lines: successful investments)

<img src="rl_demo_images/figure_1.png" style="width: 550px;"/>

```matlab:Code

```
 

### Training with different Initial Wealth (Explore the state space more sufficiently)
```matlab:Code
w0 = 150;
total_itr = 100;
qln_prams = [T, w0, maxItr, alpha, gamma, G];
[mus_qln, trace] = Qln_suggestion(Q, R, TP_cmf_j, state_wealthspace, qln_prams);
n = Qln_plot(Q, R, TP_cmf_j, actions_mu_sig, state_wealthspace, qln_prams, total_itr);
```
 
<img src="rl_demo_images/figure_5.png" style="width: 550px;"/> 
 
<img src="rl_demo_images/figure_4.png" style="width: 550px;"/>

Higher hitting rate achieved!


```matlab:Code

```
 


## **DEMO - DP**:
 <img src="dp_demo_images/figure_0.png" style="width: 550px;"/>

```matlab:Code
traces = dp_plot_2(ef, total_itr, T, w0_idx, G, best_ms, tp_tables, grid);
```
   
<img src="dp_demo_images/figure_2.png" style="width: 550px;"/> 


```matlab:Code

```

### Baseline Policy

```matlab:Code
Q = Init_Q(state_wealthspace, actions_mu_sig, T);
[mus_qln, trace] = Qln_suggestion(Q, R, TP_cmf_j, state_wealthspace, qln_prams);

total_itr = 100;
n = Qln_plot(Q, R, TP_cmf_j, actions_mu_sig, state_wealthspace, qln_prams, total_itr);
```
 
<img src="rl_demo_images/figure_8.png" style="width: 550px;"/>   

*Author: Botao Zhang (bz2462@columbia.edu) 
* **[Bowen Fang](https://github.com/bwfbowen/RL_GBWM)** (bf2504@columbia.edu)
*Chongyi Chie (cc4893@columbia.edu)
*Yichen Yao (yy3204@columbia.edu)

