# Sidecar 自动注入

- [Sidecar 自动注入](#sidecar-自动注入)
  - [技术积累](#技术积累)
    - [要点](#要点)
    - [技术拆分](#技术拆分)
    - [Kubernetes 与 Istio 资源梳理](#kubernetes-与-istio-资源梳理)
      - [Kubernetes 控制相关](#kubernetes-控制相关)
        - [Kubernetes 服务相关](#kubernetes-服务相关)
      - [Istio 相关](#istio-相关)
    - [Istio 原理分析](#istio-原理分析)
      - [Istio 自动边车注入（Istio Automatic Sidecar Injection）](#istio-自动边车注入istio-automatic-sidecar-injection)
      - [Istio 服务的健康检查](#istio-服务的健康检查)
    - [Kubernetes 自定义 Controller](#kubernetes-自定义-controller)
      - [功能组件](#功能组件)

## 技术积累

### 要点

1. 健康状态的标准？
   - Pod 实例
   - 核心 Annotation 与 Label
     - 服务治理
     - Istio 注入
     - 服务状态
2. 如何获取已授权的服务（Sidecar 注入）
3. Deployment、Gateway、Service、VirtualService、workLoad
   - Deployment
   - Gateway
   - VirtualService
   - Service
   - WorkLoad
   - ServiceEntry
   - WorkEntry
4. 利用自定义 controller 进行纠正治理
   - 纠正
   - 告警
   - 灰度发布场景
   - 分布式
5. 状态的存储
6. 如何暴露信息
7. 如何定义协议
8. 参考
   - Istio 官方 Controller

---

### 技术拆分

- Kubernetes 资源梳理
- Istio Controller 分析
- Istio 原理分析
- 自定义 Controller 前提条件
- 分布式
- 资源存储（状态、拥有资源）
- 告警
- 纠正策略
- 协议
- 暴露信息

---

### Kubernetes 与 Istio 资源梳理

#### Kubernetes 控制相关

- **集群级别的资源：** Namespace、Node、Role、ClusterRole、RoleBinding、ClusterRoleBinding
- **Workload** 类型资源：

  - **Pod：** Kubernetes 中最小的负载单元
  - **ReplicaSet：** 简称 RC，管理 Pod 的创建，通过标签控制副本数
  - **Deployment：** 控制器，通过控制 RC 去创建 Pod
  - **StatefulSet：** 主要用于有状态服务
  - **DaemonSet：** 在每个节点都运行一个 Pod 组件
  - **Job、CronJob：** 为了（批）处理、在 kubernetes v1.11 中被废弃的 ReplicationController

- **服务发现及负载均衡资源**（Service Discovery And LoadBalance）：Service、Ingress...
- **配置与存储类型**：
  - Volume（存储卷）
  - CSI（容器存储接口，可以扩展各种各样的第三方存储卷，现在市面上的大多数存储都是支持 CSI。）
- **特殊类型的存储卷**：
  - ConfigMap（当成配置中心来使用的资源类型）
  - Secret（保存敏感数据）
  - DownwardAPI（把外部环境中的信息输出给环境，比如把运行 Pod 的所在 Node 的 NodeIp 传进 Pod）

##### Kubernetes 服务相关

- **Container：** docker Container，最小运行单位
- **Pod：** 由单个或多个 Container 组成，Kubernetes 中最小的负载单元
- **Service：** 由一个 Pod 或者多个 Pod 组成，Service 是 Kubernetes 里面抽象出来的一层，它定义了由多个 Pods 组成的逻辑组（logical set），可以对组内的 Pod 做一些事情：
  - 对外暴露流量
  - 做负载均衡（load balancing）
  - 服务发现（service-discovery）

#### Istio 相关

- **Destination Rule：** 定义流量管理策略：sidecar 的负载均衡、连接池大小；负载均衡池的不健康主机的检测和驱逐。
- **Envoy Filter：** 自定义的 Envoy 配置，通过 Pilot 生效。
- Gateway：描述 Mesh 边缘的 HTTP/TCP 连接的流入流出负载均衡操作，这些规范描述了被暴露的端口、使用的协议类型、负载均衡的 SNI 配置等。
- **Virtual Service：** 定义了一组流量路由规则，当主机被寻址时，相应规则会生效。
  - Service 是以唯一的名字绑定到服务注册中心的应用行为的单位。
  - Service versions
  - Source
  - Host
  - Access model
- **ServiceEntry**
  - 在 Istio 内部服务注册中心添加额外的条目，让这些手动指定的服务能够在网格中被自动服务发现
  - 描述 Service 相关的属性（DNS name, VIPs, ports, protocols, endpoints），这些 Service 可以是网格内部或者外部的不能被服务注册中心纳管的（例如 VM Kubernetes 服务等）。
- **Sidecar**
  - 定义 Sidecar 代理配置，能够协调 Workload 实例可达的进出流量。
  - Sidecar 配置可以在同一命名空间内通过 workloadSelector 字段作用于一个或多个 Workload。
  - 注意：
    - 当一个命名空间只有一个 Sidecar 配置时，其命名空间的 Pod 没有使用 workloadSelector 字段时，默认使用这个 Sidecar 配置。
    - 在 `MeshConfig` Root 命名空间定义的 Sidecar 配置，将作用于所以没有定义 Sidecar 配置 的命名空间。
- **WorkloadGroup：**
  - 定义一组 Workload 实例。
  - 它提供了一个规范，Workload 实例可以使用该规范引导它们的代理，包括元数据和标识。
  - 它仅用于虚拟机等非 Kubernetes 的 Workload，目的是模拟 Kubernetes Workload（Sidecar 注入和 Deployment 模型）以引导 Istio 代理。
- **WorkloadEntry：**
  - 描述单个非 Kubernetes Workload 属性，如虚拟机或裸金属服务器，让它能够加入网格中
  - WorkloadEntry 必须伴随一个 ServiceEntry

**参考资料**

1. [工作负载](https://kubernetes.io/zh/docs/concepts/workloads/)
2. [Kubernetes 资源清单](https://zhuanlan.zhihu.com/p/111681807)
3. [Automatic Sidecar Injection using Kubernetes Extensible Admission Controllers](https://docs.google.com/document/d/1-5rLhv6MbB27lL8l2CWD6kR-eMa13_PPwOScVVZq8bo/edit#heading=h.qzu30eox0vm3)
4. [WorkloadEntry for Mesh Expansion](https://docs.google.com/document/d/1VDV4-prbMbzW06hslfp12sn7V6oUvnIAst6mT6FtSWc/edit#)
5. [Istio 流量管理资源](https://istio.io/latest/docs/reference/config/networking/)

---

### Istio 原理分析

#### Istio 自动边车注入（Istio Automatic Sidecar Injection）

- 通过 Kubernetes 动态准入控制器实现
- [Sidecar 自动注入](https://istio.io/latest/zh/docs/ops/configuration/mesh/injection-concepts/)
  - Sidecar 自动注入机制将 sidecar 代理添加到用户创建的 pod。
  - 它使用 `MutatingWebhook` 机制在 pod 创建的时候将 sidecar 的容器和卷添加到每个 pod 的模版里。
  - 用户可以通过 webhooks `namespaceSelector` 机制来限定需要启动自动注入的范围，也可以通过注解的方式针对每个 pod 来单独启用和禁用自动注入功能。
  - Sidecar 是否会被自动注入取决于[官方文档](https://istio.io/latest/zh/docs/ops/configuration/mesh/injection-concepts/)所说的 3 条配置和 2 条安全规则

**参考资料**

1. [Sidecar 自动注入](https://istio.io/latest/zh/docs/ops/configuration/mesh/injection-concepts/)

#### Istio 服务的健康检查

- 使用技术
  - Kubernetes 有两种健康检查机制：[Liveness 和 Readiness 探针](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/)，并且有三种方式供选择:
    - 命令方式
    - TCP 请求方式
    - HTTP 请求方式

**参考资料**

1. [Istio 服务的健康检查](https://istio.io/latest/zh/docs/ops/configuration/mesh/app-health-check/)

### Kubernetes 自定义 Controller

#### 功能组件

![c-controller-arch](./imgs/client-go-controller-interaction.jpeg)
如图所示，图中的组件分为 client-go 和 custom controller 两部分：

**client-go 部分:**

1. Reflector: 监视特定资源的 k8s api, 把新监测的对象放入 Delta Fifo 队列，完成此操作的函数是 ListAndWatch。
2. Informer: 从 Delta Fifo 队列拿出对象，完成此操作的函数是 processLoop。
3. Indexer: 提供线程级别安全来存储对象和 key。

**custom-controller 部分:**

1. Informer reference: Informer 对象引用
2. Indexer reference: Indexer 对象引用
3. Resource Event Handlers: 被 Informer 调用的回调函数，这些函数的作用通常是获取对象的 key，并把 key 放入 Workqueue，以进一步做处理。
4. Workqueue: 工作队列，用于将对象的交付与其处理分离，编写 Resource event handler functions 以提取传递的对象的 key 并将其添加到工作队列。
5. Process Item: 用于处理 Workqueue 中的对象，可以有一个或多个其他函数一起处理；这些函数通常使用 Indexer reference 或 Listing wrapper 来检索与该键对应的对象。

**参考资料**

1. [controller-client-go 介绍](https://github.com/kubernetes/kubernetes/blob/master/staging/src/k8s.io/sample-controller/docs/controller-client-go.md)
2. [sample controller demo](https://github.com/kubernetes/kubernetes/blob/master/staging/src/k8s.io/sample-controller/controller.go)

3. [Kubernetes Webhook 模式](https://kubernetes.io/zh/docs/reference/access-authn-authz/webhook/)
