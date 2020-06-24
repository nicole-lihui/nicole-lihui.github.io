# Basic

## Install
* Install JDK
  > jdk版本须在1.8以上，（下载地址）自行选择相应的版本。

* Install Maven
  > 为了下载速度更快，建议换源

* 安装RocketMQ
  > 下载地址，建议寻找国内源  

```bash
$ wget https://mirrors.tuna.tsinghua.edu.cn/apache/rocketmq/4.7.0/rocketmq-all-4.7.0-source-release.zip
$ unzip rocketmq-all-4.7.0-source-release.zip
$ cd rocketmq-all-4.7.0/
$ mvn -Prelease-all -DskipTests clean install -U
$ cd distribution/target/rocketmq-4.7.0/rocketmq-4.7.0
```

### Start Name Server
```bash
$ nohup bash bin/mqnamesrv &
```
### Start Broker
```bash
$ nohup bash bin/mqbroker -n localhost:9876 &
```

## Admin GUI/CLI
### GUI
```bash
# clone rocketmq-externals.git
git clone https://github.com/apache/rocketmq-externals.git
cd rocketmq-externals/rocketmq-console

mvn clean package -Dmaven.test.skip=true
java -jar target/rocketmq-console-ng-1.0.1.jar --rocketmq.config.namesrvAddr=localhost:9876

```
### CLI
```
$ bash bin/mqadmin
$ bash bin/mqadmin topicList -n localhost:9876

$ bash bin/mqadmin updateTopic -c DefaultCluster -n localhost:9876 -t topic-test
```

**参考文献**
* [Apache RocketMQ ——— Quick Start](http://rocketmq.apache.org/docs/quick-start/)
* [RocketMQ学习（3）——群集部署及web管理页面](https://lvjianzhao.gitee.io/lvjianzhao/2020/04/11/RocketMQ%E7%BE%A4%E9%9B%86%E9%83%A8%E7%BD%B2%E5%8F%8Aweb%E7%AE%A1%E7%90%86%E9%A1%B5%E9%9D%A2/)


