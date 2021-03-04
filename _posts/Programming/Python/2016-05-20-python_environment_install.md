---
title: Python环境安装
categories: [Programming, Python]
tags: [Python]
---

## 直接安装Python
* Ubuntu
  1. 安装python3：`sudo apt install python3`
  2. 安装pip3：`sudo apt install python3-pip`

* Linux源码安装（CentOS）
  
  由于Python3.7+要求openssl 1.0.2+，而centos 6的openssl的版本是1.0.1，因此最高能安装的Python版本为3.6，否则就只能升级openssl版本。
  1. 下载源码：<https://www.python.org/downloads/source/>
  2. 解压：`tar zxvf xxx.tgz`
  3. 编译：`make`
  4. 安装：`make install`
  
  安装完成后，python3会出现在/usr/local/bin/python3

* Windows
  1. 下载安装包：<https://www.python.org/downloads/windows/>
  2. 根据安装向导指示安装
  3. 安装pip：`python -m ensurepip`

## 在Conda中安装Python

### 安装Conda
* Linux
  1. 下载安装脚本：`wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`
  2. 执行脚本：`sh Miniconda3-latest-Linux-x86_64.sh`
  3. 当提示`Do you wish the installer to initialize Miniconda3 by running conda init?`时输入`yes`，该步会将conda初始化脚本加入到`~/.bashrc`
  4. 登陆时调用bashrc：`vi ~/.bash_profile`，在末尾加入以下内容：

```bash
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
```

* Windows
  1. 下载安装包：`https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe`
  2. 根据安装向导指示安装
  3. 将conda目录`C:\Users\%User%\miniconda3\condabin`加入到环境变量，将%User%替换为实际用户名。
  4. 如果要在powershell中使用conda，需要执行命令：`conda init powershell`

安装完成后，conda会在控制台开启时自动激活conda环境，如果想要不自动激活，可以执行命令：`conda config --set auto_activate_base false`

### 创建Python环境
语法：`conda create -n <env_name> python=<python_version>`

例：`conda create -n py382 python=3.8.2 -y`

### Conda常用命令
* 查看env列表：`conda env list`

## Pip相关命令

* 更新pip：`python -m pip install --upgrade pip`

* 安装python模块：`pip install <module_name>`

* 安装模块时指定版本：`pip install <module_name>==<version>`

* 安装模块时指定源：`pip install <module_name> -i <source_url>`

* 设置默认源：`pip config set global.index-url <source_url>`

### 常用pip源

* 阿里：`https://mirrors.aliyun.com/pypi/simple/`

* 腾讯：`https://mirrors.cloud.tencent.com/pypi/simple/`

* 清华：`https://pypi.tuna.tsinghua.edu.cn/simple`

* 中科大：`https://pypi.mirrors.ustc.edu.cn/simple/`

## Jupyter Notebook

* 启动：`jupyter notebook --ip=0.0.0.0 --port=<port> --no-browser`

* 后台运行：`nohup jupyter notebook --ip=0.0.0.0 --port=<port> --no-browser &`

* 查看：`jupyter notebook list`

* 关闭：`jupyter notebook stop`（关闭当前用户启动的notebook）

* 设置访问密码：`jupyter notebook password`

* 安装扩展
  ```
  pip install jupyter_nbextensions_configurator jupyter_contrib_nbextensions

  jupyter contrib nbextension install --user

  jupyter nbextensions_configurator enable --user
  ```

### 常用扩展
Edit-nbextensions config
* Codefolding：代码折叠
* Comment/Uncomment Hotkey：注释快捷键
* ExecuteTime: 执行时间
* Highlight selected word：已选文字高亮
* Hinterland：代码提示
* isort formatter：isort格式化imports
* Live Markdown Preview：动态Markdown预览
* Snippets Menu：代码片段菜单
* Toggle all line numbers：切换行号显示
* Variable Inspector：变量监视 （**慎用，可能会影响性能**）