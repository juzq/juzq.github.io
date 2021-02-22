## 强化学习

### 分类
* 按环境是否已知
  分为Model-Free（无模型）和Model-Based（基于模型）。
  
  强化学习算法大部分都是Model-Free RL，例如Monte-Carlo（蒙特卡罗）、Temporal Difference（时序差分）、Q-Learning系列和Policy-Gradient系列都是Model-Free算法。Model-Based RL主要有Dynamic-Programming（动态规划）、AlphaZero等。
  
* 按学习目标
  分为Value-Based（基于价值）和Policy-Based（基于策略）。
  
* 按更新方式
  分为Episode-Update（回合更新）和Step-Update（单步更新）。
  
* 按学习方式
  分为On-Policy（在线学习）和Off-Policy（离线学习）。

### 组织
* DeepMind

  核心人物是Richard Sutton（《Reinforcement learning: an introduction》的作者）以及他的博士生David Silver（AlphaGo和AlphaZero作者），推崇Value-based RL。

* OpenAI

  核心人物是Pieter Abbeel（导师是Andrew Ng），以及他的两位博士生Sergey Levine和John Schulman（TRPO与PPO作者），推崇Policy-based RL。
