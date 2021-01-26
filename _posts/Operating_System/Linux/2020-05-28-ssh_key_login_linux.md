---
title: Linux系统操作——SSH私钥登陆
categories: [Operation_System, Linux]
tags: [Linux]
---

## 步骤
1. 进入用户目录：`cd`或`cd /home/xxx`
2. 创建.ssh文件夹：`mkdir .ssh`
3. **修改.ssh文件夹权限为700**：`chmod 700 .ssh`
4. 进入.ssh文件夹：`cd .ssh`
5. 创建或编辑authorized_keys文件：`vi authorized_keys`，将公钥添加到文件末尾。
6. **修改authorized_keys权限为600**：`chmod 600 authorized_keys`
7. 修改sshd服务配置文件，允许公钥登陆：`sudo vi /etc/ssh/sshd_config`
```
# 允许私钥登陆
PubkeyAuthentication yes
# 指定私钥文件
AuthorizedKeysFile .ssh/authorized_keys
```
8. 重启sshd服务：`systemctl restart sshd.service`

## sshd_config配置说明

<https://www.freebsd.org/cgi/man.cgi?sshd_config(5)>
