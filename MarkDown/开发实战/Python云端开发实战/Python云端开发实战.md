# Python云端开发实战

### Issue:
1. 获取user agent（所在host）的IP地址
   
### 搭建开发环境：
#### dnsmasq
1. ubuntu start dnsmasq faild：port be used
   1. [ubuntu查看端口占用](https://blog.csdn.net/cnmilan/article/details/78890575)
   ```bash
   # check port
   $ sudo lsof -i tcp:53
   $ sudo lsof -i :53
   ```
   1. 解决禁用systemd-resovle:域名解析相关 出现无法域名解析
  **Ubuntu uses systemd-resolved by default to manage DNS servers and DNS caching. Before you install dnsmasq, you must stop and disable systemd-resolved services. Otherwise, you won’t be able to run dnsmasq at all.**
   ```bash
    $ sudo systemctl disable --now  systemd-resolved
    $ sudo rm -v /etc/resolv.conf # 删除符号链接 
    $ echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf 
   ```
   1. dnsmasq配置
   ```conf
    domain-needed
    bogus-priv

    expand-hosts
    domain=nicole.dhcp.com
    dhcp-range=192.168.0.50,192.168.0.150,12h
    dhcp-option=3,192.168.0.1
   ```
##### 安装（ubuntu）
```bash
$ sudo systemctl stop systemd-resolved
$ sudo rm -v /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf 

$ sudo apt -y install dnsmasq
```

### 配置文件

#### DNS
1. edit /etc/dnsmasq.conf
```bash
# 不建议指定/etc/hosts文件，因为该文件有一些localhost的配置等，dnsmasq不需要这些配置
addn-hosts=/etc/expand-hosts
```
2. edit /etc/expand-hosts
3. Test-client
   * 

### 命令行
#### DNS
```bash
$ sudo dnsmasq -d --addn-hosts=/etc/expand-hosts
```

#### 关闭VMWare 的dhcp
```bash
$ sudo vim /Library/Preferences/VMware\ Fusion/networking
```
```
answer VNET_1_DHCP no
answer VNET_8_DHCP no
```
#### DHCP
1. Server
```bash
$ sudo ip addr add 10.2.2.1/24 dev ens33
$ sudo dnsmasq --interface=ens33 --except-interface=lo --bind-interface --dhcp-range=10.2.2.2,10.2.2.100
```
2. Client


#### TFTP
```bash
# enable TFTP service:
$ sudo dnsmasq --enable-tftp --tftp-root=/tmp/aa -d
```
