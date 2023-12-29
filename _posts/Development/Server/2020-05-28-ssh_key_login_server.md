---
title: SSH密钥登陆服务器
categories: [Development, Server]
tags: [SSH]
---

## 连接Linux服务器
### 步骤
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

> 若进行了以上操作仍然提示失败，则可使用命令`ssh -Tv $server_ip`进行调试。
{: .prompt-info }

> 如果是CentOS6.x的系统，还需要关闭SeLinux才能正常登录。
{: .prompt-warning }

### sshd_config配置说明

<https://www.freebsd.org/cgi/man.cgi?sshd_config(5)>

## 连接GitHub
1. 登录[GitHub](https://github.com/)。
2. 点右上角的头像，选择`Settings`。
3. 点左侧`Access`栏里的`SSH and GPG keys`。
4. 点右侧<kbd>New SSH key</kbd>。
5. Title填写该密钥的名字（通过该名字来区分密钥，因为添加后是看不到公钥内容的）。
6. Key type保持默认的`Authentication Key`就好。
7. Key填写公钥的内容，即xxx.pub里面的。
8. 最后点<kbd>Add SSH key</kbd>即可。

> 参考：<https://docs.github.com/zh/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account>

## 连接GitLab
1. 登录GitLab。
2. 点右上角的头像，选择`编辑个人资料`。
3. 点左侧`SSH密钥`。
4. 密钥填写公钥的内容，即xxx.pub里面的。
5. 标题填写该密钥的名字（通过该名字来区分密钥，因为添加后是看不到公钥内容的）。
6. 到期时间如果不选，则会一直有效。
7. 最后点<kbd>添加密钥</kbd>即可。

> 参考：<https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account>