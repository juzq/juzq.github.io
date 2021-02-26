---
title: Windows常用批处理脚本
categories: [Operation_System, Windows]
tags: [Windows, Shell]
---

## 批量停止进程
```batch
:: ------------------------------------------------------------------------------
:: Author : Juzi
:: Date : 2021/02/24
:: Description: 批量停止进程
:: ------------------------------------------------------------------------------

@echo off

:: 进程名（不包含.exe）
set process=Dante

set list=tasklist /fi "imagename eq %process%.exe" /nh
for /f "tokens=2" %%i in ('%list%') do (
    ::echo %%i
    taskkill /F /PID %%i
)

pause
```