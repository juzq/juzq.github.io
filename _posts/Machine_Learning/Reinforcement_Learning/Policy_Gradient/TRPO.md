## 置信域策略优化（Trust Region Policy Optimization）
策略梯度的参数更新公式为：

$$ \theta_{new} = \theta_{old} + \alpha\triangledown_{\theta}J $$

### 问题
无法选择一个合适的步长\\( \alpha \\)，使得学习算法单调收敛。步长太长，策略容易发散；步长太短，收敛速度太慢。

TRPO要解决的问题就是确定一个合适的更新步长，使得策略更新后，回报函数的值单调不减。

总体思路：证明最大化某个替代回报函数可以保证策略的单调不减改进，然后对这个理论上正确的替代算法进行一系列近似，得到一个实用的算法。

### 概念

* 累计回报

  \\( Q_{\pi}(s_t, a_t) \\) 表示在状态\\(s_t\\)下采用动作\\(a_t\\)的期望累计回报：
  
  $$ Q_{\pi}(s_t, a_t) =  E_{s_{t+1}, a_{t+1}, ...} \left [ \sum_{l = 0}^{\infty}\gamma^l r(s_{t+l}) \right ] $$

* 状态价值
  
  \\( V_{\pi}(s_t) \\) 表示状态\\(s_t\\)的价值，可以理解成各种动作产生的回报的均值：
  
  $$ V_{\pi}(s_t) =  E_{a_{t}, s_{t+1}, ...} \left [ \sum_{l = 0}^{\infty}\gamma^l r(s_{t+l}) \right ] $$
  
* 优势函数

  \\( A_{\pi}(s, a) \\) 用来描述某个动作的优劣，表示状态s下使用动作a产生的回报与状态s下所有动作产生的回报的均值的差：
  
  $$ A_{\pi}(s, a) =  Q_{\pi}(s, a) - V_{\pi}(s) $$

### TRPO等式

新策略与旧策略的关系等式：

$$ \eta(\tilde{\pi}) = \eta(\pi) + E_{s_0, a_0, s_1, a_1, ...} \left [ \sum_{t=0}^{\infty}\gamma^tA_{\pi}(s_t, a_t) \right ] $$
