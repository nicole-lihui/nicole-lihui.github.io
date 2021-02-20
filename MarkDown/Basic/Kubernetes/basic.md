# Kubernetes

## 基本概念与历史
### 历史
* 由gogle开发，参考gogle内部borg系统，使用go语言开发的

### 作用



## 核心组件
* api server： 所以服务的访问统一入口
* controller mannger（replication controller）： 维持node副本
* schedule：负责调度任务，选择合适节点分配任务
* etcd：键值对数据，存储k8s所需要的重要信息（持久化）
* kubelet：直接跟容器引擎交互，实现容器的生命周期
* kube proxy：负责写入规则，IPTABLES、IPVS，实现服务映射

* CoreDNS：为集群中的svc创建一个域名IP对应关系解析
* DashBoard：为k8s提供一个B/S结构访问体系
* Ingress Controller：官方实现四层代理，Ingress实现7层代理
* Federation：提供跨集群中心，多k8s统一管理中心
* Prometheus：提供k8s集群监控能力
* ELK：集群日志统一分析介入平台


## Pod
### 基本概念
* 自主式Pod
* 控制式Pod
