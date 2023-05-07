---
title: Ubuntu系统CUDA失效的解决方法
categories: [Operation_System, Linux]
tags: [Linux, Ubuntu, CUDA]
---

## 问题
平常使用Pytorch在Ubuntu上进行训练，每隔一段时间就会发现CUDA失效。
```py
import torch
torch.cuda.is_available()
```
结果为`False`。

并且使用`nvidia-smi`查看显卡信息时会提示错误：`NVML: Driver/library version mismatch`。

## 原因排查
既然已经提示了错误原因是驱动版本不匹配，那么来仔细看下驱动的版本：

### 查看已安装的驱动版本
命令：`apt list *nvidia* --installed`

可以看到版本为`460.73.01`

### 查看内核模块的驱动版本
命令：`cat /proc/driver/nvidia/version`

可以看到内核模块版本为`450.102.04`

因此造成了驱动版本不匹配，导致CUDA失效。

## 解决方案

### 方案一：重启大法

由于内核模块被系统进程所使用，因此无法跟着驱动版本动态更新，这才导致了驱动版本版本不一致。所以将机器重启后，内核模块版本也会更新到最新版本，从而与驱动版本一致。

### 方案二：手动更新内核模块

* 查看nvidia的mod：`lsmod | grep nvidia`
* 卸载nvidia的mod及依赖其的mod：`sudo rmmod xxx`
* 若卸载时提示占用，则kill掉相关进程：`sudo lsof -n -w  /dev/nvidia*`

但我没有成功，我把相关进程都kill掉之后，还是提示mod占用。

> 参考：<https://comzyh.com/blog/archives/967/>


### 方案三：禁用驱动更新（亡羊补牢）

* 维持驱动版本：
```bash
sudo apt-mark hold nvidia-compute-utils-460 nvidia-dkms-460 nvidia-driver-460 nvidia-kernel-common-460 nvidia-kernel-source-460 nvidia-modprobe nvidia-prime nvidia-settings nvidia-utils-460
```
* 禁止Ubuntu自动更新：
`sudo vi /etc/apt/apt.conf.d/20auto-upgrades`将"1"改为"0"。修改后的内容如下：
```
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Unattended-Upgrade "0";
```

> 参考：<https://chrisalbon.com/deep_learning/setup/prevent_nvidia_drivers_from_upgrading/>