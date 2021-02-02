# Plan


## 主线
* docker （container） p1
* k8s p0
* 服务网格 p0
* devops p3

## 问题
1. 学习关键点有哪些？
2. 掌握程度没有把握？
3. 实践案例如何开始？


## 目标

### k8s
* k8s背景？解决了什么问题?
* k8s架构的特点与优势？
* k8s核心组件的作用和工作原理？
* k8s的缺点和注意事项？
* k8s涉及的原理和本质?
* k8s在实际应用中，会存在什么样的问题，如何进行优化？

#### 实践问题
* k8s 集群数据一致性问题？
* k8s 网络通信如何实现具体pod互相通信？
* api server 、etcd 、node中数据一致性，后期性能影响与优化？

### 服务网格
* mesh背景？解决了什么问题？
* mesh的特点和优势？
* mesh的架构和工作原理？
* mesh的基本组件，各自原理和特点？
* mesh在实际应用中，会存在什么样的问题，如何进行优化？
* 现有的产品和优缺点？


### k8s 技术分享目标
1. 基本
   1. 架构与组件
   2. 基本概念：Pod、Service、对象（资源）
2. 网络通信
   1. pod 与 pod
      1. 虚拟隔离
      2. 物理隔离
   2. pod/service 与 service
   3. pod 与外部网络
      1. NodePort
      2. LoaderBalance
      3. Ingress
   4. 如何同步pod网络变化？ 
      * api server 、kube-proxy、etcd、netfilter


问题：
1. pod 与 pod 描述不清
   1. 网桥是什么？ eth0 是什么？如何寻找的过程
2. iptable 和 ipvs 的区别
3. netfilter 到底有什么作用？
4. pod 与外部网络 具体流程 ？实现原理？优点与缺点？