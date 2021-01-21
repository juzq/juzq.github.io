---
title: 用LaTeX书写数学公式
categories: [Math]
tags: [Math]
math: true
---

## 介绍
为了更方便的书写数学公式，有多种语法支持，主要有TeX/LaTeX, MathML和AsciiMath，目前使用最多的是LaTeX。

## 公式渲染
虽然写好了LaTeX语法的数学公式，但是还需要渲染支持，才能将LaTeX语法渲染为公式，目前主流的渲染引擎为[MathJax](https://www.mathjax.org/)。Github默认是不支持渲染LaTeX的（Gitee支持），为了让Github支持渲染，还需要安装chrome浏览器插件[MathJax 3 Plugin for Github](https://chrome.google.com/webstore/detail/mathjax-3-plugin-for-gith/peoghobgdhejhcmgoppjpjcidngdfkod)。（FireFox暂时没有找到插件支持）

## LaTeX语法

### 界定符
公式分为陈列式（displayed mathematics）和行内式（in-line mathematics），有不同的界定符。
* 陈列式：`$$ ... $$`或`\[ ... \]`
  
  例：$$ y = ax_1 + bx_2 $$

* 行内式：`$ ... $`或`\( ... \)`

  例：\\( y = ax_1 + bx_2 \\)

**注：**
1. MathJax默认不渲染`$ ... $`类型，防止干扰文章中正常的`$`符号显示，[这里](http://docs.mathjax.org/en/latest/input/tex/delimiters.html#tex-delimiters)有详细解释。
2. 在MarkDown中由于`\`需要转义，因此需要写成`\\( ... \\)`和`\\[ ... \\]`
