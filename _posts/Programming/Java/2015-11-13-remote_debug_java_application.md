---
title: 远程调试Java程序
categories: [Programming, Java]
tags: [Java]
---


## java程序中加入启动参数 {#lauch-params}
* jdk1.5及以后：

`-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005`
* jdk1.4：

`-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005`
* jdk1.3及以下：

`-Xnoagent -Djava.compiler=NONE -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005`

## 连接调试 {#conn-dbg}

* Eclipse调试

`Run-> Debug Configuration-> Remote Java Application`
然后在输入ip和端口，点击Debug即可

* Intellij IDEA

`Run-> Edit Configurations...-> + -> Remote`
填写Host和Port，点击Ok即可

> 原文发表在我的cnblog博客：<https://www.cnblogs.com/emberd/p/4961358.html>，于2017/07/20迁入