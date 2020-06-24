# 1. RabiitMQ

## 1.1. Introduce
* [RabbitMQ for beginners -- What is RabbitMQ](https://www.cloudamqp.com/blog/2015-05-18-part1-rabbitmq-for-beginners-what-is-rabbitmq.html)


## 1.2. Install
```bash
#!/bin/sh

## If sudo is not available on the system,
## uncomment the line below to install it
＄ sudo apt-get update -y

## Install prerequisites
$ sudo apt-get install curl gnupg -y

## Install RabbitMQ signing key
$ curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add -

## Install apt HTTPS transport
$ sudo apt-get install apt-transport-https

## Add Bintray repositories that provision latest RabbitMQ and Erlang 21.x releases
$ sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list <<EOF
## Installs the latest Erlang 22.x release.
## Change component to "erlang-21.x" to install the latest 21.x version.
## "bionic" as distribution name should work for any later Ubuntu or Debian release.
## See the release to distribution mapping table in RabbitMQ doc guides to learn more.
deb https://dl.bintray.com/rabbitmq-erlang/debian bionic erlang
deb https://dl.bintray.com/rabbitmq/debian bionic main
EOF

## Update package indices
$ sudo apt-get update -y

## Install rabbitmq-server and its dependencies
$ sudo apt-get install rabbitmq-server -y --fix-missing
```

## 1.3. Command LineUsage
* 基本命令
```bash
# 启动 RabbitMQ
$ sudo rabbitmq-server start

# 关闭 RabbitMQ
$ sudo rabbitmq-server stop

# 重启 RabbitMQ
$ sudo rabbitmq-server restart

# 查看 RabbitMQ 状态
$ sudo rabbitmqctl status

# 查看 RabbitMQ 进程
$ ps -ef | grep rabbitmq

# 查看已经安装的插
$ rabbitmq-plugins list
```

* `rabbitmqctl` Usage
```bash
# VHost
$ sudo rabbitmqctl add_vhost my_host
$ sudo rabbitmqctl list_vhosts
$ sudo rabbitmqctl delete_vhost my_host


# User
## add user
$ sudo rabbitmqctl add_user username password
## list user
$ sudo rabbitmqctl list_users
## change password
$ sudo rabbitmqctl change_password username newpassword
## authenticate user
$ sudo rabbitmqctl authenticate_user username newpassword
## set user tags, tags:
## management ：访问 management plugin；
## policymaker ：访问 management plugin 和管理自己 vhosts 的策略和参数；
## monitoring ：访问 management plugin 和查看所有配置和通道以及节点信息；
## administrator ：一切权限；
## None ：无配置
$ sudo rabbitmqctl set_user_tags username management
## delete user
$ sudo rabbitmqctl delete_user username

# Permission
## Set user permissions, ` rabbitmqctl set_permissions [-p <vhost>] <user> <conf> <write> <read> `
## customize vhost:my_host and user:username
$ sudo rabbitmqctl set_permissions -p my_host username ".*" ".*" ".*"
##　clear permissions,     customize vhost:my_host and user:username
$ sudo rabbitmqctl clear_permissions -p my_host username
##　list user permissions
$ sudo rabbitmqctl list_user_permissions guest
## list_permissions [-p vhost]
$ sudo rabbitmqctl list_permissions
# list topic permissions
$ sudo rabbitmqctl list_topic_permissions
```

* `rabbitmqadmin` Usage
```bash
# rabbitmqadmin [-V vhost] list exchanges, -v [vhost]
$ rabbitmqadmin list exchanges
$ rabbitmqadmin list queues
# Get a list of queues, with some columns specified
$ rabbitmqadmin list queues vhost name node messages message_stats.publish_details.rate

# Connect to another host as another user
$ rabbitmqadmin -H localhost -u guest -p guest list vhosts

# declare
$ rabbitmqadmin declare exchange name=my-exchange type=fanout
$ rabbitmqadmin declare queue name=my-queue durable=false

# publish message
$ rabbitmqadmin publish exchange=amq.default routing_key=my-queue payload="hello, world"
# And get it back
$ rabbitmqadmin get queue=my-queue ackmode=ack_requeue_false

# Close all connections
$ rabbitmqadmin -f tsv -q list connections name | while read conn ; do rabbitmqadmin -q close connection name="${conn}" ; done

```


* 打开Web UI管理界面
```bash
# 开启网页版控制台
$ rabbitmq-plugins enable rabbitmq_management

# 输入网页访问地址：http://localhost:15672/ 使用默认账号：guest/guest登录
```

* 安装CLI管理插件
```bash
# 下载安装rabbitmqadmin
$ wget http://localhost:15672/cli/rabbitmqadmin
$ mv rabbitmqadmin /usr/local/bin
$ sudo chmod 777 /usr/local/bin/rabbitmqadmin

# 查看 rabbitmqadmin 命令
$ rabbitmqadmin -help
```

## RabbitMQ Client Tools
```bash
# Install on Ubuntu
sudo apt install -y amqp-tools

# publish message
amqp-publish -u "amqp://guest:guest@localhost" -e amq.topic -b "Hello RabbitMQ"
```

**参考文档**
* [RabbitMQ Tutorials](https://www.rabbitmq.com/getstarted.html)
* [Installing on Debian and Ubuntu](https://www.rabbitmq.com/install-debian.html#running-debian)
* [RabbitMQ CLI 管理工具 rabbitmqadmin（管理和监控）](https://www.cnblogs.com/xishuai/p/rabbitmq-cli-rabbitmqadmin.html)
