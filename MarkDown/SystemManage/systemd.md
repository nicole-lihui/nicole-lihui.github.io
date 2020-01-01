# Systemd

## build my Service
* [编写systemd下服务脚本](https://blog.csdn.net/fu_wayne/article/details/38018825)
* [Linux Centos 7 systemctl（systemd）新增加service服务，并且开机启动](https://blog.csdn.net/qq_25821067/article/details/79120222)

```bash
# mydemo.service
$ cat /usr/lib/systemd/system/mydemo.service
[Unit]
Description=Mydemo Service

[Service]
ExecStart=/bin/bash /home/vagrant/test.sh

[Install]
WantedBy=multi-user.target

# test.sh
$ cat test.sh
#!/bin/bash

date >> /tmp/date

# start service
$ sudo systemctl enable mydemo.service
Created symlink from /etc/systemd/system/multi-user.target.wants/mydemo.service to /usr/lib/systemd/system/mydemo.service.

$ sudo systemctl start mydemo.service
```
