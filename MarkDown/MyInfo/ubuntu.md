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

