---
title: Java启动参数
categories: [Programming, Java]
tags: [Java]
---

## -Xms、-Xmx、-Xmn

堆内存大小（初始、最大、年轻代）

例：-Xms1M -Xmx2M -Xmn 512K

## -Xss

虚拟机栈内存大小

例：-Xss2M

## -XX:SurvivorRatio

Eden区与Survivor区（单个）的比例

例：-XX:SurvivorRatio=8

## -XX:+UseParNewGC、-XX:+UseConcMarkSweepGC

使用的垃圾回收器（ParNew、CMS）
### 可选的垃圾回收器
* 年轻代：Serial, ParNew, Parallel Scavenge, G1
* 老年代：CMS, Serial Old（MSC）, Parallel Old, G1

## -Djava.nio.channels.spi.SelectorProvider

NIO的Selector（选择器）

例：

使用epoll作为nio算法：-Djava.nio.channels.spi.SelectorProvider=sun.nio.ch.EPollSelectorProvider
