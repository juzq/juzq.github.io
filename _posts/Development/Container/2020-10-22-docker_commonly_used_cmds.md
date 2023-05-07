---
title: Docker常用命令
categories: [Development, Container]
tags: [Container, Docker]
---

## 登陆镜像仓库
`docker login [OPTIONS] [SERVER]`

SERVER为要登陆的仓库地址，若不指定，则默认登陆[Docker Hub](https://hub.docker.com)。

例：`docker login hub.digi-sky.com`

## 将普通用户添加到docker组
1. 将juzi用户添加到docker组：`sudo gpasswd -a juzi docker`
2. 刷新docker组：`newgrp docker`

## 容器操作

### 查看
ps命令可以查看容器的进程，类似于Linux的ps命令。

`docker ps [OPTIONS]`

常用选项：
* -a：显示所有容器（默认只显示运行中的容器）
* -l：只显示最后创建的容器
* -n x：只显示最后x个创建的容器，该选项与-l互斥

例：`docker ps -a`

### 启动/停止
类似于电脑的开机和关机，stop后的容器仍然存在（--rm启动的容器除外），可以用start命令再次启动。

`docker start/stop [OPTIONS] <CONTAINER_ID> [CONTAINER_ID2...]`

例：`docker stop 45c567b3397b`

### 执行
该命令可以在指定容器中执行指定命令。
`docker exec [OPTIONS] <CONTAINER_ID> <COMMAND> [ARGS]`

常用选项：
* -i：即使没有附加也保持STDIN 打开
* -t：分配一个伪终端

例：`docker exec -it 45c567b3397b /bin/bash`

### 提交
使用提交命令可将当前运行的容器打包为镜像，从而将容器中安装的环境保存下来。

`docker commit [OPTIONS] <CONTAINER_ID> [REPOSITORY[:TAG]]`

例：`docker commit fb5c5b7f0388 jekyll:xxx`

### 查看日志
由于-d运行的容器没有控制台输出，因此可通过logs命令查看容器的运行日志。

`docker logs [OPTIONS] <CONTAINER_ID>`

例：`docker logs 45c567b3397b`

### 删除容器
若容器启动时没有用--rm参数，则在其停止后会一直存在，需要用rm命令删除。

`docker rm [OPTIONS] <CONTAINER_ID> [CONTAINER...]`

删除所有容器：
```
docker rm `docker ps -a -q`
```

## 镜像操作

### 查看镜像列表
`docker images [OPTIONS] [REPOSITORY[:TAG]]`

或

`docker image ls [OPTIONS] [REPOSITORY[:TAG]]`

### 显示镜像详情
`docker image inspect [OPTIONS] <IMAGE_ID> [IMAGE...]`

### 运行镜像
从指定镜像来运行游戏。

`docker run [OPTIONS] <IMAGE_ID> [COMMAND] [ARG...]`

常用选项：
* -d：后台运行容器，并打印容器id
* -name：指定容器名字，若不指定，docker将会生成随机的单词组合
* -p：将容器的端口绑定到主机，前面是主机端口，后面是容器端口，例：`-p 4000:80`
* --rm：容器退出时自动删除
* --volume：绑定主机硬盘，前面是主机硬盘路径，后面是容器路径，例：`--volume="$PWD:/srv/jekyll"`。

### 构建镜像
从指定Dockerfile来构建镜像，可以用docker build也可以用docker image build。

`docker (image) build [OPTIONS] <PATH> | <URL> | -`

常用选项：
* -t：为镜像命名

例：`docker build -t getting-started .`

### 标记镜像
该命令可以给镜像取个别名，相当于是Linux的硬连接。

`docker image tag <SOURCE_IMAGE[:TAG]> <TARGET_IMAGE[:TAG]>`

### 精简镜像
该命令可以自动删除一些没有使用的镜像（构建过程中生成的中间镜像）。

`docker image prune [OPTIONS]`

### 删除镜像
` docker image rm [OPTIONS] IMAGE_ID [IMAGE_ID...]`

删除所有镜像
```
docker rmi `docker images -q`
```

### 拉取镜像
拉取镜像前，需要先登陆镜像仓库。

`docker pull [OPTIONS] NAME[:TAG|@DIGEST]`

若镜像为私有仓库镜像，那么镜像前需要加上`仓库地址/组名/`，例：`docker pull hub.digi-sky.com/aid/fighting_ice:latest`

### 推送镜像
推送镜像前，同样需要先登陆。

`docker push [OPTIONS] NAME[:TAG]`

若要推送的仓库为私有仓库，那么镜像前同样需要加上`仓库地址/组名/`，例：`docker push hub.digi-sky.com/aid/fighting_ice:latest`

## Dockerfile
Dockerfile是一个文本类型的包含Docker指令的脚本文件，用来创建Docker镜像。

官网语法参考：<https://docs.docker.com/engine/reference/builder/>

### FROM
指定基镜像，必须是文件的第一条指令

示例：`python:3.8.3`

### WORKDIR
为后续指令（ADD, COPY, CMD, ENTRYPOINT, RUN）指定工作目录

示例：`WORKDIR /app`

### ADD/COPY
从源路径拷贝拷贝到目标路径

示例：`ADD src dst`

ADD与COPY区别：COPY只能拷贝本地的文件（夹），ADD除此之外还能获取URL中的资源。

### ENV
添加环境变量

示例：`ENV LANG=C.UTF-8`

### RUN
在镜像中运行命令并将其作为新的layer提交到结果，一般是为了安装依赖。

示例：`RUN pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/`

### CMD/ENTRYPOINT
CMD或ENTRYPOINT指定了镜像的执行目标，一个镜像必须要指定CMD或ENTRYPOINT才能运行（通过docker run --entrypoint ...运行时指定也可以）。

执行目标分为可执行文件模式和shell模式，带[]的为可执行文件模式，该模式是docker推荐的。

CMD可在ENTRYPOINT的可执行文件模式下作为运行参数，若定义了shell模式的ENTRYPOINT则会覆盖CMD的执行目标，因此CMD常作为缺省执行目标来使用。

例：
```
CMD ["executable","param1","param2"] (exec form, this is the preferred form)
CMD ["param1","param2"] (as default parameters to ENTRYPOINT)
CMD command param1 param2 (shell form)
ENTRYPOINT ["executable", "param1", "param2"] (exec form, preferred)
ENTRYPOINT command param1 param2 (shell form)
```

多种配置组合对比：

||No ENTRYPOINT|ENTRYPOINT exec_entry p1_entry|ENTRYPOINT [“exec_entry”, “p1_entry”]|
||:------------|:-----------------------------|:------------------------------------|
|No CMD|error, not allowed|/bin/sh -c exec_entry|p1_entry 	exec_entry p1_entry|
|CMD [“exec_cmd”, “p1_cmd”]|exec_cmd p1_cmd|/bin/sh -c exec_entry p1_entry|exec_entry p1_entry exec_cmd p1_cmd|
|CMD [“p1_cmd”, “p2_cmd”]|p1_cmd p2_cmd|/bin/sh -c exec_entry p1_entry|exec_entry p1_entry p1_cmd p2_cmd|
|CMD exec_cmd p1_cmd|/bin/sh -c exec_cmd p1_cmd|/bin/sh -c exec_entry p1_entry|exec_entry p1_entry /bin/sh -c exec_cmd p1_cmd|