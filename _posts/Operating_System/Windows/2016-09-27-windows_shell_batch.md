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

## 循环

### for循环（集合）
语法：
```
for %%i in $collection do (
    $statement
)
```
1. collection为要循环的值的集合，例如：`(2, 1, 8)`
2. `%%i`为定义的循环变量，变量名不能超过1位（例如`%%ab`是**错的**）
3. `%%i`取值时要用`%%i%`

### for循环（范围）
/l参数代表以增量形式从开始到结束的一个数字序列，语法：
```
for /l %%i in ($start, $step, $end) do (
    $statement
)
```
1. `start`为起始值（包含）
2. `step`为步长
3. `end`为终止值（若能取到则包含）
4. 例：`(10, 2, 20)`的取值为`10, 12, 14, 16, 18, 20`


