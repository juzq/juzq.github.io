---
title: Docker常用命令
categories: [Development, Container]
tags: [Container, Docker]
---

## 容器操作

### 查看
`docker ps [OPTIONS]`

常用选项：
* -a：显示所有容器（默认只显示运行中的容器）

例：`docker ps -a`

### 启动/停止
语法：`docker start/stop [OPTIONS] {CONTAINER_ID} [CONTAINER_ID2...]`

例：`docker stop 45c567b3397b`

### 提交（打包为镜像）
语法：`docker commit [OPTIONS] {CONTAINER_ID} [REPOSITORY[:TAG]]`

例：`docker commit fb5c5b7f0388 jekyll:xxx`

## 镜像操作
