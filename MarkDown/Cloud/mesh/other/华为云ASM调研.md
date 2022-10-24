# 华为云服务网格（ASM）调研

## 核心问题

- 可观测性联动
- 多集群方案
- dubbo 方案

## 架构与原理

### 基本功能

- 连接
- 安全
- 控制
  - 灰度发布：蓝绿、金丝雀
- 遥测

### 数据面与控制面

### 多集群

### 集群通讯与架构

#### 可观测性

### 多服务类型支持

2019 年 10 月： 支持 Dubbo 协议治理，支持 Dubbo、Spring Cloud 集成解决方案。 Spring Cloud 和 Dubbo 等 SDK 不需要独立的注册中心和配置中心，使用 Istio 统一的控制面做服务发现和治理规则管理

#### Dubbo

参考：[面向 Dubbo 协议的服务治理](https://support.huaweicloud.com/bestpractice-istio/istio_bestpractice_3001.html)

Dubbo 开发的 RPC 服务在业务代码不做改动的前提下，部署运行在 Kubernetes 的 Istio 集群上，使用容器化的敏捷弹性部署运维能力和强大的无侵入治理能力。

Dubbo 开发的 RPC 服务部署在 Istio 集群中，服务间 RPC 访问会被 Istio 数据面拦截，使用 Istio 的服务发现和负载均衡，并执行 Istio 上配置的治理规则，其主要原理如图
![主要原理](https://support.huaweicloud.com/bestpractice-istio/zh-cn_image_0194064467.png)

##### 服务发现模型适配
   为了使用 Kubernetes 的服务发现能力和服务治理规则，要求适配 Dubbo 的服务发现模型和 Kubernetes 一致
   ![Dubbo、Kubernetes适配规则](https://support.huaweicloud.com/bestpractice-istio/zh-cn_image_0194062716.png)

##### RPC 调用流程
   Dubbo 的 RPC 请求使用 Istio 的服务发现和负载均衡，从而使用 Istio 数据面执行服务治理。如图 2，短路 SDK 服务发现和负载均衡，使用服务名直接访问目标服务。Istio 的数据面 Envoy 拦截到流量，根据访问的服务名执行服务发现和负载均衡，并执行定义在该服务上的治理规则。
   ![Dubbo RPC请求流程](https://support.huaweicloud.com/bestpractice-istio/zh-cn_image_0194062842.png)

##### 内部外部访问
**内部访问核心配置**
```yaml
# 用于内部访问的envoyfilter需要配置spec.configPatches.match.listener.name的值，这个值由serviceIP和servicePort决定。
apiVersion: networking.istio.io/v1alpha3
kind: EnvoyFilter
metadata:
  name: dubboprovider-dubbo-app
  namespace: istio-system
spec:
  configPatches:
  - applyTo: NETWORK_FILTER
    match:
      context: SIDECAR_OUTBOUND     #用于配置dubbo协议的内部访问  
      listener:
        filter_chain:
          filter:
            name: envoy.tcp_proxy
        name: {$serviceIP}_{$servicePort}    #name的值为serviceIP_servicePort，指定作用的服务及其端口
        port_number: $servicePort     #dubboprovider的service的访问端口
    patch:
      operation: REMOVE
  - applyTo: NETWORK_FILTER
    match:
      context: SIDECAR_OUTBOUND
      listener:
        filter_chain:
          filter:
            name: mixer
        name: {$serviceIP}_{$servicePort}   
        port_number: $servicePort        
    patch:
      operation: INSERT_AFTER
      value:
        config:
          dubbo_filters:
          - name: envoy.filters.dubbo.router
          protocol_type: Dubbo
          route_config:
          - interface: .*       #使用.*代表所有接口   
            name: local_route
            routes:
            - match:
                method:
                  name:
                    regex: .*
              route:
                cluster: $cluster                   #用于指定路由的负载
          serialization_type: Hessian2
          stat_prefix: dubbo_incomming_stats
        name: envoy.filters.network.dubbo_proxy
```

**外部访问配置**
```yaml
apiVersion: networking.istio.io/v1alpha3
kind: EnvoyFilter
metadata:
  name: dubboprovider-dubbo-app-gateway
  namespace: istio-system
spec:
  configPatches:
  - applyTo: NETWORK_FILTER
    match:
      context: GATEWAY               #用于配置dubbo协议的外部访问
      listener:
        filter_chain:
          filter:
            name: envoy.tcp_proxy
        port_number: $outPort        #ingressgateway的外部访问端口
    patch:
      operation: REMOVE
  - applyTo: NETWORK_FILTER
    match:
      context: GATEWAY          #用于配置dubbo协议的外部访问
      listener:
        filter_chain:
          filter:
            name: mixer
        port_number: $outPort       
    patch:
      operation: INSERT_AFTER
      value:
        config:
          dubbo_filters:
          - name: envoy.filters.dubbo.router
          protocol_type: Dubbo
          route_config:
          - interface: .*  #使用.*表示所有接口
            name: local_route
            routes:
            - match:
                headers:                      #必填：可用headers字段更精确的指定治理的服务
                - name: k8s.namespace
                  exact_match: dubboapp
                - name: k8s.appname
                  exact_match: dubboprovider
                method:
                  name:
                    regex: .*
              route:  
                cluster: $cluster              #用于指定路由的负载
          serialization_type: Hessian2
          stat_prefix: dubbo_incomming_stats
        name: envoy.filters.network.dubbo_proxy
```

##### 灰度发布
```yaml
apiVersion: networking.istio.io/v1alpha3 
kind: DestinationRule 
metadata: 
  name: dubboprovider-destination 
  namespace: dubbo-app 
spec: 
  host: dubboprovider 
  subsets: 
  - labels: 
      version: v1 
    name: v1 
  - labels:             #添加灰度版本v2 
      version: v2 
    name: v2 
  trafficPolicy: 
    outlierDetection: 
      interval: 10m
---
# 根据不同的环境与需求修改 EnvoyFilter
# kubectl edit envoyfilter dubboprovider-dubbo-app -n istio-system
# kubectl edit envoyfilter dubboprovider-dubbo-app-gateway -n istio-system

apiVersion: networking.istio.io/v1alpha3
kind: EnvoyFilter
spec:
  configPatches:
    ...
  - applyTo: NETWORK_FILTER
    patch:
      value:
        config:
          route_config:
            interface: .*
            routes:
              route:   #修改此部分，原版本v1配置30%流量，灰度版本v2配置70%流量
                weighted_clusters:
                 clusters:
                 - name: outbound|20880|v1|dubboprovider.dubbo-app.svc.cluster.local
                   weight: 30
                 - name: outbound|20880|v2|dubboprovider.dubbo-app.svc.cluster.local
                   weight: 70
```

#### SpringCloud

参考：[华为云应用服务网格最佳实践之从 Spring Cloud 到 Istio](https://bbs.huaweicloud.com/blogs/detail/249674)

#### VM 不支持






## Demo

![添加集群](https://console.huaweicloud.com/static/istio/21.10.28/img/vpc-peer-cn.c9db277180c04e619fef71f2de906d31.png)
## 参考

[【云图说】第 87 期 华为云应用服务网格，让你的应用治理智能化、可视化](https://bbs.huaweicloud.com/blogs/106886)
