# Ubuntu

## apt
## Install 

## Remove
```bash
# 删除软件及其配置文件
sudo apt remove <package>
# 删除没用的依赖包
sudo apt autoremove <package>
# 此时dpkg的列表中有“rc”状态的软件包，可以执行如下命令做最后清理：
dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P
```

```bash

```

## 界面切换
1. ubuntu开启字符界面：
```bash
$ sudo systemctl set-default multi-user.target
```

2. ubuntu开启图形界面：
```bash
$ sudo systemctl set-default graphical.target
```

## 去除sudo密码
```bash
echo "$USER   ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER
```

## 更改默认编辑器
```bash
echo export EDITOR=/usr/bin/vim >> ~/.bash.rc
```

## 更改HostName
```bash

```

## VNC
```
$ sudo apt install -y vinagre
```

## Install DingTalk
[Ubuntu 18.04安装钉钉](https://www.cnblogs.com/yuzhen0228/p/12016246.html)
[Ubuntu使用Wine安装钉钉、微信、QQ等Windows软件](https://blog.csdn.net/anyuliuxing/article/details/103354403)


## install java

```bash
# 重置系统后，安装java环境
$ sudo apt update
$ sudo apt install openjdk-8-jre -y
```

## 创建用户组和用户
```bash
groupadd maxwit
useradd -g maxwit -s /bin/bash -m wit
echo -e "maxwit2020\nmaxwit2020" | passwd wit
echo “%maxwit ALL=(ALL:ALL) NOPASSWD:ALL” > /etc/sudoers.d/wit
chmod 600 /etc/sudoers.d/wit
```
