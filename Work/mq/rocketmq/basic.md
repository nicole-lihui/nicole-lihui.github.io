# RocketMQ 基础

## 基本参数配置
* broker.config
```bash
# Broker 所属哪个集群
brokerClusterName = rocketmq-cluster

# Broker名称，默认：	本机主机名
brokerName = broker-a

# BrokerId，必须是大等于 0 的整数，0 表示Master，>0 表示 Slave，一个 Master 可以挂多个 Slave，Master 与 Slave 通过 BrokerName 来配对， 默认为0
brokerId = 0

#这个很有讲究 如果是正式环境 这里一定要填写内网地址（安全）
#如果是用于测试或者本地这里建议要填外网地址，因为你的本地代码是无法连接到阿里云内网，只能连接外网。
brokerIP1 = docker.for.mac.host.internal

# 删除文件时间点，默认凌晨 4点
deleteWhen = 04

# 文件保留时间，默认 48 小时
fileReservedTime = 48

# 内网的(阿里云有内网IP和外网IP)
# ip设置实际ip，port可自由设置，一般设置9876
namesrvAddr=rmqnamesrv:9876

#Broker 对外服务的监听端口,
# port可自由设置，一般设置10911
listenPort = 10909

#Broker角色
#- ASYNC_MASTER 异步复制Master
#- SYNC_MASTER 同步双写Master
#- SLAVE
brokerRole=ASYNC_MASTER
#刷盘方式
#- ASYNC_FLUSH 异步刷盘
#- SYNC_FLUSH 同步刷盘
flushDiskType=ASYNC_FLUSH

#在发送消息时，自动创建服务器不存在的topic，默认创建的队列数
defaultTopicQueueNums=8

# 是否允许Broker 自动创建Topic，建议线下开启，线上关闭
autoCreateTopicEnable=true
#是否允许 Broker 自动创建订阅组，建议线下开启，线上关闭
autoCreateSubscriptionGroup=true

#commitLog每个文件的大小默认1G
mapedFileSizeCommitLog=1073741824
#ConsumeQueue每个文件默认存30W条，根据业务情况调整
mapedFileSizeConsumeQueue=1000000

# 销毁MappedFile被拒绝的最大存活时间，默认120s。清除过期文件线程在初次销毁mappedfile时，如果该文件被其他线程引用，引用次数大于0.则设置MappedFile的可用状态为false，并设置第一次删除时间，下一次清理任务到达时，如果系统时间大于初次删除时间加上本参数，则将ref次数一次减1000，知道引用次数小于0，则释放物理资源
destroyMapedFileIntervalForcibly=120000
# 重试删除文件间隔，配合destorymapedfileintervalforcibly
redeleteHangedFileInterval=120000

#检测物理文件磁盘空间，commitlog目录所在分区的最大使用比例，如果commitlog目录所在的分区使用比例大于该值，则触发过期文件删除
diskMaxUsedSpaceRatio=88

#限制的消息大小 修改为16M。 默认允许的最大消息体默认4M
maxMessageSize=‭16777216‬
#发送队列等待时间。清除发送线程池任务队列的等待时间。如果系统时间减去任务放入队列中的时间小于waitTimeMillsInSendQueue，本次请求任务暂时不移除该任务
waitTimeMillsInSendQueue=3000
# putMessage锁占用超过该时间,表示 PageCache忙
osPageCacheBusyTimeOutMills=5000

flushCommitLogLeastPages=12
flushConsumeQueueLeastPages=6
flushCommitLogThoroughInterval=30000
flushConsumeQueueThoroughInterval=180000

#checkTransactionMessageEnable=false
#发消息线程池数量
sendMessageThreadPoolNums=80
#拉消息线程池数量
pullMessageThreadPoolNums=128
useReentrantLockWhenPutMessage=true
```

