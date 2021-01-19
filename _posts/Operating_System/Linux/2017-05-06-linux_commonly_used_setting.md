---
title: Linux常用设置
categories: [Linux]
tags: [Linux]
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

* 修改日志等级
  systemd默认日志等级为info，修改为notice：

  1. 使用命令：`systemd-analyze set-log-level notice`
  2. 修改配置文件：`/etc/systemd/system.conf`将`LogLevel=info`修改为`LogLevel=notice`

  可以将系统日志等级设置为notice，从而屏蔽上述日志。
  
* 添加过滤规则
  1. 编辑文件`/etc/rsyslog.d/ignore-systemd-session-slice.conf`，添加以下内容：
  ```if $programname == "systemd" and ($msg contains "Starting Session" or $msg contains "Started Session" or $msg contains "Created slice" or $msg contains "Starting user-" or $msg contains "Removed Slice" or $msg contains "Stopping user-") then stop
  ```
  2. 重启rsyslog：`systemctl restart rsyslog`

  从而过滤掉上述日志。
