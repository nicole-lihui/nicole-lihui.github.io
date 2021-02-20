# 基本概念
> 参考官方文档

# 深入理解istio

## istio demo 入门
> 参考官方 bookinfo 的案例

## Sidecar自动注入如何实现的
### Sidecar 是什么？
> 在 Sidercar 部署方式中会为每一个应用的 容器 部署一个 伴生容器。在 istio 中，Sidecar 会接管进出 应用程序 的所有网络 流量。

* 使用 Sidecar 模式时， 不需要在 节点 上运行 代理， 但是在 集群 中会运行多个 Sidecar 副本。
* 在 k8s 的 pod 中，在原有的 应用容器 旁运行一个 Sidecar 容器，可以理解为两个容器共享存储、网络等资源，可以广义的将这个注入了 Sidecar 容器的 Pod 理解为一台主机， 两个容器共享主机资源。


### Sidecar 注入
> 注入 Sidecar的时候会在生成pod的时候附加上两个容器：istio-init、istio-proxy。

* istio-init：顾名思义，是k8s中的Init Containers。 它主要用于 设置 iptables 规则、让出入流量都转由 Sidecar 进行处理。
* istio-proxy：是基于 Envoy 实现的网络代理容器，是真正的 Sidecar 容器，应用的流量会被重定向进入或者流出Sidecar。
* istio-injection=enabled： 在使用 Sidecar 自动注入的时候，只需要给对应的应用部署的 命名空间 配置 istio-injection=enabled 标签，这个 命名空间 中新建的任何 Pod 都会被 Istio 注入 Sidecar。


### Sidecar 注入原理
> Sidecar 是通过 k8s 的 准入控制器（ Admission Controller ）来实现的

* Admission Controller 会拦截 k8s api server 收到的请求，拦截发生在认证和鉴权完成之后，对象进行持久化之前。
* 可以定义两种类型的 Admission webhook：Validating 和 Mutating
  * Validating：可以根据自定义 准入策略 决定 是否拒绝请求
  * Mutating：可以根据自定义 配置 来 对请求进行编辑

* Sidecar注入步骤：
1. 解析Webhook REST请求，将AdmissionReview原始数据反序列化；
2. 解析pod，将AdmissionReview中的AdmissionRequest反序列化；
3. 利用Pod及网格配置渲染Sidecar配置模板；
4. 利用Pod及渲染后的模板创建Json Patch；
5. 构造AdmissionResponse；
6. 构造AdmissionReview，将其发给apiserver；

**参考资料**
* [深入Istio：Sidecar自动注入如何实现的？](https://www.luozhiyun.com/archives/397)



## 理解Pilot
### Service Mesh 实现 k8s 高并发场景下的高级服务特性：熔断、限流、降级
> 以Istio为例讲述Service Mesh中的技术关键点
* Service Mesh 分为数据面板和控制面板
  * 数据面板： 转发
  * 控制面板： 控制总体策略，下发命令

* Pilot 核心架构
  * **Platform Adapter**：pilot 调用 k8s，获取服务之间关系（服务发现，pilot 只使用 k8s 的服务发现功能，不使用转发功能）
  * **Rules API**：是提供给管理员的接口，管理员通过这个接口设定一些规则，这些规则往往是应用于Routes, Clusters, Endpoints。
  * **Envoy API**：是提供Discovery Service的API，这个API的规则由envoy定，是Envoy去主动调用Pilot的这个API。

#### Envoy
> Envoy 是 C++ 实现的高性能 proxy。它通过制定一系列规则，然后根据这些规则进行转发。

* 配置的四要素：
  * LDS（Listener Discovery Service）：实现转发的监听一个端口，接入请求，该监听端口称为listener。
  * RDS（Routes）：有时候多个cluster具有类似的功能，但是是不同的版本号，可以通过route规则，选择将请求路由到某一个版本号，也即某一个cluster.
  * CDS（Cluster）：一个cluster是具有完全相同行为的多个endpoint，也即如果有三个容器在运行，就会有三个IP和端口，但是部署的是完全相同的三个服务，他们组成一个Cluster，从cluster到endpoint的过程称为负载均衡，可以轮询等。
  * EDS（Endpoint）：是目标的ip地址和端口，这个是proxy最终将请求转发到的地方。
