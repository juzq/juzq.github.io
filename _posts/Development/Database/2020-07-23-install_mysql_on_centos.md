---
title: CentOS系统安装MySQL
categories: [Development, Database]
tags: [Database, MySQL]
---

## 序言
从CentOS 7开始，MySQL源已经不包含在系统默认的源中，因此无法直接使用`sudo yum install mysql-community-server`来安装mysql，首先需要安装mysql源。

## 安装MySQL源
根据系统版本，从[官网](https://dev.mysql.com/downloads/repo/yum/)下载对应的源，下载后使用命令`sudo rpm -ivh mysql80-community-release-el7-3.noarch.rpm`安装。

## MySQL版本选择
该源包含的版本有：5.5, 5.6, 5.7, 8.0等几个版本，默认是安装8.0版本，因此如果你是想要安装非8.0版本，还需要做一些配置修改。

### 修改安装版本为5.7
编辑配置文件`sudo vi /etc/yum.repos.d/mysql-community.repo`
1. 将[mysql57-community]的enabled=0改为1
2. 将[mysql80-community]的enabled=1改为0

## 安装MySQL
跟安装一般的软件一样，使用命令`sudo yum install mysql-community-server`安装即可，可以看到版本号为5.7.32-1.el7，若还是8.0.x，则代表上一步没有修改成功。

## 启动mysqld服务
安装好MySQL之后，默认是未启动MySQL服务的，可以通过命令`systemctl status mysqld`查看，是inactive(dead)状态，表示未启动。执行命令`systemctl start mysqld`来启动，会提示输入root密码。

## 修改root密码
第一次启动MySQL时，会自动生成一个临时密码，可以通过命令`sudo tail -100 /var/log/mysqld.log|grep password`
```
[ljx@VM-0-11-centos download]$ sudo tail -100 /var/log/mysqld.log|grep password
2020-11-19T03:47:52.457626Z 1 [Note] A temporary password is generated for root@localhost: i3vqljR)A_dw
```
即临时密码为：i3vqljR)A_dw，使用该密码即可登陆root用户`mysql -uroot -p`。将密码修改为123456则可使用命令`alter user root@localhost identified by '123456';`但会提示密码不满足当前策略。
```
mysql> alter user root@localhost identified by '123456';
ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
```
因为MySQL默认的密码策略要求至少8位、有大小写字母、有特殊字符，因此如果一定要使用简单的密码，需要修改MySQL默认的密码策略，步骤如下：
1. `set global validate_password_policy=LOW;`：将密码策略改为低
2. `set global validate_password_length=4;`：设置密码最小长度为4（低于4会被强制改为4）
再执行之前的修改密码命令即可。

**特别提示：生产环境一定要对MySQL端口做好防火墙设置，如果不限制访问ip，请一定不要像我一样设置123456这种简单密码。**

## MySQL常用操作

### 数据库备份
安装好MySQL后，会附带安装备份工具mysqldump，位于/usr/bin下面。

命令格式为：`mysqldump -u<username> -p<password> <db_name> > <file_name>`

例：`mysqldump -uroot -p123456 goods > /home/ljx/backup/mysql/"goods-$(date +'%Y-%m-%d %H:%M:%S').db"`

## 其他资料
* 官网Yum相关教程

  <https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/>
