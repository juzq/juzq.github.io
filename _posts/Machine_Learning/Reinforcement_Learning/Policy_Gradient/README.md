## 策略梯度
策略梯度（Policy Gradient）的核心思想是提高获得高回报的动作的概率，降低获得低回报的动作的概率。是基于策略的算法，既可用于离散动作空间，也可用于连续动作空间。

目标：寻找策略$\pi_\theta$中的参数$\theta$，使累计奖励$R_\theta = \sum_{t=1}^Tr_t$最大。

由于actor和环境都具有随机性，因此定义$\overline{R}_\theta$为$R_\theta$的期望值。

定义轨迹 $\tau$ = {s1, a1, r1, s2, a2, r2, ..., $s_T$, $a_T$, $r_T$}，那么有

$$\overline{R}_\theta = \sum_{\tau}R(\tau)P(\tau|\theta) \approx \frac{1}{N}\sum_{n=1}^N R(\tau^n)$$ 
其中，$\tau^n$代表第n次轨迹。等式两边对$\theta$求梯度，有

$$\nabla\overline{R}_\theta = \sum_{\tau}R(\tau)\nabla P(\tau|\theta) = \sum_{\tau}R(\tau)P(\tau|\theta)\frac {\nabla P(\tau|\theta)} {P(\tau|\theta)} = \sum_{\tau}R(\tau)P(\tau|\theta)\nabla \log P(\tau|\theta) \approx \frac{1}{N}\sum_{n=1}^N R(\tau^n)\nabla \log P(\tau^n|\theta)$$

而根据$P(\tau|\theta)$的定义，有

$$P(\tau|\theta) = p(s_1)p(a_1, s_1|\theta)p(r_1, s_2|s_1, a_1)p(a_2, s_2|\theta)p(r_2, s_3|s_2, a_2)... = p(s1)\prod_{t=1}^Tp(a_t, s_t|\theta)p(r_t, s_{t+1}|s_t, a_t)$$

为了将累乘转化为累加，等式两边取对数：

$$\log P(\tau|\theta) = \log p(s_1) + \sum_{t=1}^T\log $$

### 分类
PG分为随机策略梯度（Stochastic PG）和确定性策略梯度（Deterministic PG）。

* 随机策略梯度

  置信域策略优化（True Region Policy Optimization）：确定一个使得回报函数单调不减的最优步长，以应对SPG学习速率难以确定的问题。

* 确定性策略梯度

  确定性策略梯度（DPG）：使用线性函数逼近行为值函数和确定性策略。
 
  深度确定性策略梯度（Deep DPG）：将线性函数扩展到非线性函数——神经网络。

### 行动者——评论家

* 行动者——评论家（AC）

  评论家用来对行为值函数参数进行更新，行动者根据更新后的行为值函数对策略函数参数进行更新。根据策略不同，AC也可分为随机AC和确定性AC。

* 优势行动者——评论家（A2C）

  用优势函数代替行为值函数，评论家直接对优势函数的参数进行更新。

* 异步优势行动者——评论家（A3C）

  在进行行为探索（采样）时，开启多个线程，每个线程相当于一个智能体在随机探索，多个智能体共同探索，并行计算策略梯度，维持一个总的更新量。
