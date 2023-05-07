---
title: Linux常用命令
categories: [Operation_System, Linux]
tags: [Linux]
---

## 网络相关

* Ping带时间：`ping 192.168.80.102 | awk '{ print strftime("%F %H:%M:%S",systime()) "\t"$0 }'`
  ```
    2021-03-11 15:12:31     PING 192.168.80.102 (192.168.80.102) 56(84) bytes of data.
    2021-03-11 15:12:31     64 bytes from 192.168.80.102: icmp_seq=1 ttl=125 time=0.340 ms
    2021-03-11 15:12:32     64 bytes from 192.168.80.102: icmp_seq=2 ttl=125 time=0.270 ms
    2021-03-11 15:12:33     64 bytes from 192.168.80.102: icmp_seq=3 ttl=125 time=0.319 ms
  ```
  注：Ubuntu需要安装gawk


## 硬件相关

* 查看内存插槽：`sudo dmidecode|grep -P -A5 "Memory\s+Device"|grep Size|grep -v Range`
  ```
    Size: No Module Installed
    Size: No Module Installed
    Size: No Module Installed
    Size: No Module Installed
    Size: 16384 MB
    Size: 16384 MB
    Size: 16384 MB
    Size: 16384 MB
  ```
  显示No Module Installed则表示该插槽上没有插内存条。

* 查看显卡参数：`nvidia-smi`

* 查看显卡型号：`nvidia-smi -L`

## Ubuntu

### 更新软件
`sudo apt upgrade -y`

### 模糊查找软件
`apt list *<keyword>* [--installed]`

其中*代表任意字符，例：`apt list *openjdk-11*`

### 删除软件
`sudo apt remove <software>`

该命令只能删除软件的可执行文件，在命令`dpkg -l|grep <keyword>`中还能看到，需要再使用`sudo dpkg -P <software>`才能将其完全删除（删除配置文件）。

### 安装sshd
```
sudo apt install openssh-server
service ssh start
```

### 安装驱动
```
sudo ubuntu-drivers autoinstall
```