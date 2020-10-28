# openwrt配置dns
```bash
# 方法一: /etc/hosts

127.0.0.1 localhost
192.168.1.126 nick.in.maxwit.com

::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

# 方法二: /path/to/addtional-hosts-file
# example: /root/cus-hosts

192.168.1.126 nick.in.maxwit.com
```
