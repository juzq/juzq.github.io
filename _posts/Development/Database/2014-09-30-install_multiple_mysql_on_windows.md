---
title: Windows下安装多个MySQL数据库
categories: [Development, Database]
tags: [Database, MySQL]
---

## 安装mysql
运行MySQL数据库安装程序，正常安装数据库并做好相关配置。（Windows下的安装程序诸如：mysql-essential-5.1.40-win32.msi）

## 拷贝程序文件
拷贝原数据库安装目录下的所有文件，如：C:\Program Files (x86)\MySQL\MySQL Server 5.1拷贝至C:\Program Files (x86)\MySQL2\MySQL Server 5.1

## 拷贝数据文件
拷贝原数据库的数据文件，如：C:\ProgramData\MySQL\MySQL Server 5.1\data拷贝至C:\ProgramData\MySQL2\MySQL Server 5.1\data

## 修改新数据库的配置文件
1. 数据库端口：
```
[mysqld]
port=3306
[mysqld]
port=3306
```

2. 数据库安装路径：
```basedir="C:/Program Files (x86)/MySQL2/MySQL Server 5.1/"```

3. 数据文件路径：
```datadir="C:/ProgramData/MySQL2/MySQL Server 5.1/Data/"```

## 注册为系统服务
1. cmd命令进入新的数据库安装目录的bin文件夹下，例如：
```cd C:\Program Files (x86)\MySQL2\MySQL Server 5.1\bin```

2. 安装命令
```mysqld install MySQL2  --defaults-file="C:\Program Files (x86)\MySQL2\MySQL Server 5.1\my.ini"```

> 原文发表在我的csdn博客：<https://blog.csdn.net/emberd/article/details/39694663>，于2017/07/21迁入
