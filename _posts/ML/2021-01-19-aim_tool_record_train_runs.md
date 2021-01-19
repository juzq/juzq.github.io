---
title: 使用aim工具来记录机器学习训练
categories: [Machine_Learning]
tags: [Machine_Learning]
---

## 介绍
[aim](https://github.com/aimhubio/aim)能够非常简单方便地记录、搜索、对比机器学习训练的超参数。相比于tensorboard，它支持将多个指标合并到一张图上，并且支持类似sql的方式来搜索和对比超参数，可操控性会更加精细。

## 安装
1. 安装aim：`pip install aim`
2. 安装docker：`sudo apt install docker.io`

## 初始化aim仓库
命令：`aim init`

通过该命令，aim会在当前目录创建.aim文件夹，用于记录后续的训练数据，因此必须在数据记录前初始化aim仓库。

## 数据记录示例
```python
import aim
lrs = [1e-2,1e-3,1e-4]
bss = [64, 128, 256, 512]
layer_nums = [1, 2, 3]

x = 1
for lr in lrs:
    for bs in bss:
        for ln in layer_nums:
            hyperparam_dict={"lr":lr,"batch_size":bs,"layer_num":ln}
            sess = aim.Session(experiment='test')
            sess.set_params(hyperparam_dict, name='hparams')
            for epoch_number in range(1,10):
                sess.track(x/epoch_number+1, name='frames', step=epoch_number)
                sess.track(x/epoch_number, name='loss', step=epoch_number)
            x+=1
```

## 启动UI界面
命令：`aim up -h 192.168.102.65 -p 9901`

若不指定-h和-p参数，aim会默认使用127.0.0.1:43800作为监听地址。
