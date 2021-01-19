---
title: Linux常用设置
categories: [Linux]
tags: [linux]
---

## CentOS
### 设置系统日志等级为notice
默认的，CentOS会每分钟记录用户slice日志到/var/log/messages中，会产生大量无用日志：
```
Jan 19 14:10:01 VM-0-11-centos systemd: Created slice User Slice of xxx.
Jan 19 14:10:01 VM-0-11-centos systemd: Started Session 12699 of user xxx.
Jan 19 14:10:01 VM-0-11-centos systemd: Started Session 12700 of user root.
Jan 19 14:10:01 VM-0-11-centos systemd: Removed slice User Slice of xxx.
```
解决方案：

1. systemd默认日志等级为info，修改为notice
  命令：`systemd-analyze set-log-level notice`

  可以将系统日志等级设置为notice，从而屏蔽上述日志。
  
2. 添加过滤器来忽略该类型日志
