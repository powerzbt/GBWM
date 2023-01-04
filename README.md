
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

