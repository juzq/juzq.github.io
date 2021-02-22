## 强化学习

### 分类
* 按环境是否已知

  分为Model-Free（无模型）和Model-Based（基于模型）。
  
  强化学习算法大部分都是Model-Free RL，例如Monte-Carlo（蒙特卡罗）、Temporal Difference（时序差分）、Q-Learning系列和Policy-Gradient系列都是Model-Free算法。Model-Based RL主要有Dynamic-Programming（动态规划）、AlphaZero等。
  
* 按学习目标

  分为Value-Based（基于价值）和Policy-Based（基于策略）。
  
  Value-Based是基于求解值函数，当值函数最优时，可以获得最优策略，即在状态s下，最大动作价值函数（q）对应的动作。而Policy-Based是将策略参数化，寻找最优的参数\\(\theta\\)，使得累计回报的期望E最大。
  
  区别：
  1. Value-Based只能处理动作为离散的情况。
  
* 按更新方式

  分为Episode-Update（回合更新）和Step-Update（单步更新）。
  
* 按学习方式

  分为On-Policy（在线策略）和Off-Policy（离线策略），也有书将其翻译为同轨策略和离轨策略（俞凯翻译的《强化学习第2版》）。
  
  关键点在于，搜集数据的（行动）策略与要学习的（目标）策略是否为同一个，若是同一个则是On-Policy，若不是，则是Off-Policy。
  
  

### 组织
* DeepMind

  核心人物是Richard Sutton（《Reinforcement learning: an introduction》的作者）以及他的博士生David Silver（AlphaGo和AlphaZero作者），推崇Value-based RL。

* OpenAI

  核心人物是Pieter Abbeel（导师是Andrew Ng），以及他的两位博士生Sergey Levine和John Schulman（TRPO与PPO作者），推崇Policy-based RL。
