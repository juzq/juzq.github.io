---
title: Windows Shell——Batch(批处理)
categories: [Operation_System, Windows]
tags: [Windows, Shell]
---

## 变量

### 定义变量
语法
```batch
set VARIABLE=value
```
注：“=”左右不能有空格

### 取变量值
语法
```batch
%VARIABLE%
```

### 取输入变量
* 提取第i个命令选项：`%i` 例如%1提取第1个option，i可以取值从1到9
* 取文件名（名+扩展名）：`%~0`
* 取全路径：`%~f0`
* 取驱动器名：`%~d0`
* 只取路径（不包括驱动器）：`%~p0`
* 只取文件名：`%~n0`
* 只取文件扩展名：`%~x0`
* 取缩写全路径名：`%~s0`
* 取文件属性：`%~a0`
* 取文件创建时间：`%~t0`
* 取文件大小：`%~z0`

以上选项可以组合起来使用。

> 原文发表在我的cnblog博客：<http://www.cnblogs.com/emberd/p/5911531.html>，于2017/07/20迁入