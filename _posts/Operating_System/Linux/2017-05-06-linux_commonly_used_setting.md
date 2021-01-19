---
title: Linux常用设置
categories: [Linux]
tags: [Linux]
---

## CentOS

### 设置yum源为阿里云
Centos默认的yum源较慢，可将其更换为阿里云：
1. 备份旧源:`mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup`
2. 下载新的源文件:`wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo` （可将7换成6、5等等，根据系统版本而定）
3. 下载EPEL源:`wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo`
4. 重新生成缓存：`yum clean all`和`yum makecache`

### 设置系统日志等级为notice
CentOS会每分钟记录用户slice日志到/var/log/messages中，会产生大量无用日志：
```
Jan 19 14:10:01 VM-0-11-centos systemd: Created slice User Slice of xxx.
Jan 19 14:10:01 VM-0-11-centos systemd: Started Session 12699 of user xxx.
Jan 19 14:10:01 VM-0-11-centos systemd: Started Session 12700 of user root.
Jan 19 14:10:01 VM-0-11-centos systemd: Removed slice User Slice of xxx.
```
解决方案：

* 修改日志等级
  systemd默认日志等级为info，修改为notice：

  1. 使用命令：`systemd-analyze set-log-level notice`
  2. 修改配置文件：`/etc/systemd/system.conf`将`LogLevel=info`修改为`LogLevel=notice`

  可以将系统日志等级设置为notice，从而屏蔽上述日志。
  
* 添加过滤规则
  1. 编辑文件`/etc/rsyslog.d/ignore-systemd-session-slice.conf`，添加内容：`if $programname == "systemd" and ($msg contains "Starting Session" or $msg contains "Started Session" or $msg contains "Created slice" or $msg contains "Starting user-" or $msg contains "Removed Slice" or $msg contains "Stopping user-") then stop`
  2. 重启rsyslog：`systemctl restart rsyslog`

  从而过滤掉上述日志。
