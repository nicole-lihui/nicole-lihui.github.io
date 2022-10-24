# Linkerd 调研

- [Linkerd 调研](#linkerd-调研)
  - [概述](#概述)
    - [撬动的痛点](#撬动的痛点)
    - [功能](#功能)
      - [HTTP, HTTP/2, gRPC 代理与检测](#http-http2-grpc-代理与检测)
      - [超时](#超时)
      - [重试](#重试)
      - [mTLS](#mtls)
        - [功能](#功能-1)
        - [原理](#原理)
        - [拓展](#拓展)
      - [负载均衡](#负载均衡)
      - [流量拆分 [Traffic Split (canaries, blue/green deploys)]](#流量拆分-traffic-split-canaries-bluegreen-deploys)
      - [安全策略 -- 服务访问控制](#安全策略----服务访问控制)
      - [自动注入](#自动注入)
      - [CNI Plugin](#cni-plugin)
      - [分布式追踪](#分布式追踪)
      - [故障注入](#故障注入)
      - [高可用](#高可用)
      - [多集群](#多集群)
        - [特点：](#特点)
        - [通讯：](#通讯)
        - [架构](#架构)
      - [可观测性](#可观测性)
        - [per-route 指标](#per-route-指标)
      - [SMI 拓展支持](#smi-拓展支持)
    - [Linkerd 原理深入](#linkerd-原理深入)
      - [架构](#架构-1)
      - [控制面](#控制面)
      - [数据面](#数据面)
      - [安全机制](#安全机制)
      - [多集群](#多集群-1)
  - [兼容性](#兼容性)
    - [Dubbo](#dubbo)
    - [SpringCloud](#springcloud)
  - [比较](#比较)
    - [参考资料](#参考资料)
  - [Demo](#demo)
    - [初始化 kind 集群](#初始化-kind-集群)
    - [安装 linkerd](#安装-linkerd)
      - [单集群](#单集群)
      - [多集群](#多集群-2)
      - [多集群通讯](#多集群通讯)
      - [test services](#test-services)
      - [流量分流](#流量分流)
    - [集群接入 buoyant cloud](#集群接入-buoyant-cloud)
      - [多集群](#多集群-3)
      - [单集群](#单集群-1)
    - [Linkerd CRD](#linkerd-crd)
      - [Service Profile](#service-profile)
        - [介绍](#介绍)
        - [demo](#demo-1)
  - [参考](#参考)

## 概述

### 撬动的痛点

Linkerd 旨在解决我们在 Twitter，Yahoo，Google 和 Microsoft 等公司运营大型生产系统时发现的问题。根据我们的经验，最复杂，令人惊奇和紧急行为的来源通常不是服务本身，而是服务之间的通讯。Linkerd 解决了这些问题，不仅仅是控制通讯机制，而是在其上提供一个抽象层。

- 服务可观测性
  - 链路追踪
  - tcp、http 流量指标
  - pod 状态
- 服务控制
  - 超时
  - 重试
  - 故障注入
  - 流量切片（灰度发布）
  - 访问控制
    - 需要定义 linkerd 自定义资源 Server, 定义服务信息
    - 定义 ServerAuthorization 资源，配置控制配置；
      - 可配置单个或多个服务的访问控制
      - 访问控制维度：
        - unauthenticatedTLS： mtls 访问控制
        - identities：集群域名控制（可以完成命名空间、服务粒度控制）
        - serviceAccounts： 可以配置 serviceAccount
- 安全
  - mtls

### 功能

#### HTTP, HTTP/2, gRPC 代理与检测

Linkerd 能够代理所有的 TCP 连接，并且允许 HTTP, HTTP/2, gRPC 连接启用高级功能（指标、负载均衡、重试等）
Linkerd 能够代理所有的 TCP 流量，包括 TLS、WebSocket、HTTP。

#### 超时

每条 route 可以定义一条超时配置`timeout`，该配置定义了服务等待请求的最大时间，默认为 10s

```yaml
spec:
  routes:
    - condition:
        method: HEAD
        pathRegex: /authors/[^/]*\.json
      name: HEAD /authors/{id}.json
      timeout: 300ms
```

#### 重试

```yaml
# 在 service profile 中配置 retryBudget，定义该服务超时重试配置
spec:
  retryBudget:
    retryRatio: 0.2
    minRetriesPerSecond: 10
    ttl: 10s

# 在 service profile 中选择需要开启超时重试的 route，配置 isRetryable
spec:
  routes:
  - name: GET /api/annotations
    condition:
      method: GET
      pathRegex: /api/annotations
    isRetryable: true ### ADD THIS LINE ###
```

通过 `linkerd viz routes` 添加参数 `--to` 与 `-o wide` 获取详细的路由监控

#### mTLS

##### 功能

Linkerd 默认启用 [mTLS](https://buoyant.io/mtls-guide/)

Linkerd 多集群的通信与 Istio 理念一致，需要共享同一个 CA。

##### 原理

- 自动更新 ca
  - Linkerd 官方推荐使用 [Cert-manager](https://github.com/jetstack/cert-manager) 这个开源项目来支持自动轮换 TLS CA。
  - 第三方 cert 管理：linkerd 通过读 `linkerd-identity-issuer` Secret 资源，如果其类型为 `kubernetes.io/tls` 将会使用 Kubernetes 内置的 TLS 证书。这意味着可以使用其他证书管理器来重写该资源。例如：`kubectl create secret tls linkerd-identity-issuer --cert=issuer.crt --key=issuer.key --namespace=linkerd`

##### 拓展

- Cert-Manager
  - 主要解决问题：解决证书到期续签问题
  - 原理
    - cert-manager 部署到 Kubernetes 集群后，它会 watch 它所支持的 CRD 资源，我们通过创建 CRD 资源来指示 cert-manager 为我们签发证书并自动续期:
    - Issuer/ClusterIssuer: 用于指示 cert-manager 用什么方式签发证书，本文主要讲解签发免费证书的 ACME 方式。ClusterIssuer 与 Issuer 的唯一区别就是 Issuer 只能用来签发自己所在 namespace 下的证书，ClusterIssuer 可以签发任意 namespace 下的证书。
    - Certificate: 用于告诉 cert-manager 我们想要什么域名的证书以及签发证书所需要的一些配置，包括对 Issuer/ClusterIssuer 的引用。
  - 参考
    - [Istio 1.6 使用 Cert-Manager 加密 Istio 网关](https://www.jianshu.com/p/e625ea402a48)
    - [Istio/cert-manager](https://istio.io/latest/zh/docs/ops/integrations/certmanager/)
    - [手把手教你使用 cert-manager 签发免费证书](https://blog.csdn.net/yunxiao6/article/details/109307268)

#### 负载均衡

Linkerd 不需要任何配置对于 HTTP、HTTP/2、gRPC 都能实现负载均衡。

#### 流量拆分 [Traffic Split (canaries, blue/green deploys)]

#### 安全策略 -- 服务访问控制

策略类型：

- all-unauthenticated: 允许所有的入站连接（默认）
- all-authenticated：只允许来自 Mesh 的 mTLS 流量
- cluster-unauthenticated： 允许集群内的所有流量（在安装时定义集群网络 clusterNetworks）
- cluster-authenticated：允许集群内的 mTLS 流量

Server 与 ServerAuthorization CRD 实现访问控制

#### 自动注入

#### CNI Plugin

#### 分布式追踪

#### 故障注入

1. 创建故障服务

```yaml
cat <<EOF | linkerd inject - | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: error-injector
  namespace: booksapp
data:
 nginx.conf: |-
    events {}
    http {
        server {
          listen 8080;
            location / {
                return 500;
            }
        }
    }
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: error-injector
  namespace: booksapp
  labels:
    app: error-injector
spec:
  selector:
    matchLabels:
      app: error-injector
  replicas: 1
  template:
    metadata:
      labels:
        app: error-injector
    spec:
      containers:
        - name: nginx
          image: nginx:alpine
          volumeMounts:
            - name: nginx-config
              mountPath: /etc/nginx/nginx.conf
              subPath: nginx.conf
      volumes:
        - name: nginx-config
          configMap:
            name: error-injector
---
apiVersion: v1
kind: Service
metadata:
  name: error-injector
  namespace: booksapp
spec:
  ports:
  - name: service
    port: 8080
  selector:
    app: error-injector
EOF
```

2. 配置故障注入策略，通过 CRD `TrafficSplit`

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: split.smi-spec.io/v1alpha1
kind: TrafficSplit
metadata:
  name: error-split
  namespace: booksapp
spec:
  service: books
  backends:
  - service: books
    weight: 500m
  - service: error-injector
    weight: 500m
EOF
```

3. 结果分析

```bash
linkerd viz -n booksapp stat deploy
# NAME      MESHED   SUCCESS      RPS   LATENCY_P50   LATENCY_P95   LATENCY_P99   TCP_CONN
# authors      1/1   100.00%   7.1rps           4ms          26ms          33ms          6
# books        1/1   100.00%   8.6rps           6ms          73ms          95ms          6
# traffic      1/1         -        -             -             -             -          -
# webapp       3/3   100.00%   7.9rps          20ms          76ms          95ms          9

linkerd viz -n booksapp routes deploy/webapp --to service/books
# ROUTE       SERVICE   SUCCESS      RPS   LATENCY_P50   LATENCY_P95   LATENCY_P99
# [DEFAULT]     books   100.00%   8.6rps           6ms          73ms          95ms

linkerd viz -n booksapp routes deploy/webapp --to service/books
# ROUTE       SERVICE   SUCCESS      RPS   LATENCY_P50   LATENCY_P95   LATENCY_P99
# [DEFAULT]     books    90.08%   2.0rps           5ms          69ms          94ms
```

#### 高可用

高可用模式：

1. 控制面运行 3 个副本
2. 控制面配置生产级别的 CPU 与 Memory
3. 数据面配置生产级别的 CPU 与 Memory
4. 保证已编排并配置自动注入的 Pod 能正常工作
5. 确认控制面配置的 anti-affinity policies

**如何开启**

```bash
# 安装时

linkerd install --ha | kubectl apply -f -
# 或
linkerd viz install --ha | kubectl apply -f -
# 可通过参数，自定义 HA 配置， 例如 --controller-replicas=2
linkerd install --ha --controller-replicas=2 | kubectl apply -f -

# 升级
linkerd upgrade --ha | kubectl apply -f -
```

#### 多集群

##### 特点：

- 统一的域名，其核心意义在于多集群之间服务全部打通
- 容灾，其中一个集群出现故障，其他集群能够正常工作
- 支持异构网络，根据其原理可知，Linkerd 不会引入除网关连接之外的任何 L3 / L4 要求
- 集群内自治的架构，能够保证单集群独立运行

**参考：**

##### 通讯：

- 集群间流量会通过 mTLS 加密与认证

##### 架构

![multi-cluster](https://linkerd.io/images/multicluster/feature-overview.svg)
与 istio 设计有所区别，无论哪种网络架构，服务都会直接访问目标集群。目标集群的 `multi-cluster 网关`组件能够直接接收源集群的请求。其实现方案根据官方说明推荐使用 [Submariner](https://github.com/submariner-io/submariner) or [Project Calico](https://www.projectcalico.org/)等工具。

#### 可观测性

- 指标粒度：route 级别

##### [per-route 指标](https://linkerd.io/2.11/tasks/getting-per-route-metrics/#)

获取路由指标，需要定义 service profile

```yaml
apiVersion: linkerd.io/v1alpha2
kind: ServiceProfile
metadata:
  creationTimestamp: null
  name: webapp.booksapp.svc.cluster.local
  namespace: booksapp
spec:
  routes:
    - condition:
        method: GET
        pathRegex: /
      name: GET /
    - condition:
        method: POST
        pathRegex: /authors
      name: POST /authors
    - condition:
        method: GET
        pathRegex: /authors/[^/]*
      name: GET /authors/{id}
    - condition:
        method: POST
        pathRegex: /authors/[^/]*/delete
      name: POST /authors/{id}/delete
    - condition:
        method: POST
        pathRegex: /authors/[^/]*/edit
      name: POST /authors/{id}/edit
    - condition:
        method: POST
        pathRegex: /books
      name: POST /books
    - condition:
        method: GET
        pathRegex: /books/[^/]*
      name: GET /books/{id}
    - condition:
        method: POST
        pathRegex: /books/[^/]*/delete
      name: POST /books/{id}/delete
    - condition:
        method: POST
        pathRegex: /books/[^/]*/edit
      name: POST /books/{id}/edit
```

```bash
curl -sL https://run.linkerd.io/booksapp/webapp.swagger \
  | linkerd -n booksapp profile --open-api - webapp \
  | kubectl -n booksapp apply -f -

$ linkerd viz routes svc/webapp
ROUTE                       SERVICE   SUCCESS      RPS   LATENCY_P50   LATENCY_P95   LATENCY_P99
GET /                        webapp   100.00%   0.6rps          25ms          30ms          30ms
GET /authors/{id}            webapp   100.00%   0.6rps          22ms          29ms          30ms
GET /books/{id}              webapp   100.00%   1.2rps          18ms          29ms          30ms
POST /authors                webapp   100.00%   0.6rps          32ms          46ms          49ms
POST /authors/{id}/delete    webapp   100.00%   0.6rps          45ms          87ms          98ms
POST /authors/{id}/edit      webapp     0.00%   0.0rps           0ms           0ms           0ms
POST /books                  webapp    50.76%   2.2rps          26ms          38ms          40ms
POST /books/{id}/delete      webapp   100.00%   0.6rps          24ms          29ms          30ms
POST /books/{id}/edit        webapp    60.71%   0.9rps          75ms          98ms         100ms
[DEFAULT]                    webapp     0.00%   0.0rps           0ms           0ms           0ms
```

#### SMI 拓展支持

### Linkerd 原理深入

#### 架构

[linkerd-arch](https://linkerd.io/images/architecture/control-plane.png)

- CLI
  - 交互入口
- Control plane
  - 运行在 linkerd（默认） 命名空间，有如下几个组件
    - destination：

#### 控制面

- 组件作用
- 组件实现原理
- 服务治理如何实现
  - 超时
  - 重试
  - 故障注入

#### 数据面

- 数据面之间如何通讯
- 轻量级边车设计原理
- 如何进行服务发现

#### 安全机制

- 如何同步证书
- 如何校验

#### 多集群

- 多集群架构
- 多集群功能

## 兼容性

### Dubbo

### SpringCloud

## 比较

| \                         | Linkerd2                                     | Istio                                                          |
| ------------------------- | -------------------------------------------- | -------------------------------------------------------------- |
| 平台                      | Kubernetes                                   | Kubernetes                                                     |
| 支持协议                  | grpc、HTTP/2、HTTP/1.x、Websocket 、TCP      | grpc、HTTP/2、HTTP/1.x、Websocket 、TCP                        |
| 入口控制器                | Any (linerd 本身不提供入口功能)              | Envoy 与 Istio 网格本身                                        |
| 多集群                    | 支持多集群                                   | 支持多集群                                                     |
| VM                        | 不支持                                       | 支持                                                           |
| 服务网格接口（SMI）兼容性 | 通过插件 linkerd-smi 支持                    | 需要第三方支持                                                 |
| 监控功能                  | Prometheus                                   | Prometheus                                                     |
| 追踪支持                  | （插件方式）所有支持 OpenCensus 的第三方     | OpenTracing, Zipkin, Jaeger, Lightstep                         |
| 路由功能                  | EWMA 负载均衡算法，通过 SNI 的百分比流量拆分 | 各种负载均衡算法，基于百分比的流量拆分，基于标头和路径流量拆分 |
| 弹性                      | 超时重试、故障注入、流量切分                 | 熔断、故障注入、延时注入、超时重、流量切分                     |
| 安全                      | mtls(TCP) ，外部 CA                          | mtls 支持所有协议，外部 CA，授权规则                           |
| 性能                      | 设计轻巧，比 istio 快 3-5 倍                 | -                                                              |

- 服务治理角度
  - linkerd:
    - 故障注入（用法很奇怪）
    - 没有熔断
    - 负载均衡无法自定义
  - istio: 超时、重试、故障注入、流量切分、熔断
- 可观测性
  - linkerd:
    - 有统一的 UI 界面与方便的 CLI 获取指标
    - 跨集群流量与指标无法统计
  - istio:
    - 跨集群流量与指标可以统计
- 性能：
  - linkerd2 比 istio 快 3-5 倍

### 参考资料

[The Service Mesh Landscape](https://layer5.io/service-mesh-landscape)
[Service Mesh Comparison](https://servicemesh.es/)
[Service Mesh](https://kubedex.com/istio-vs-linkerd-vs-linkerd2-vs-consul/)

## Demo

### 初始化 kind 集群

```bash
cluster=cluster1
net1=32003
network=network1
((net=$net1%32000+1))
k="kubectl --context=kind-${cluster}"
CTX_CLUSTER=kind-cluster1
```


```bash
net1=32001
net2=32000

east=east
west=west

network1=network1
network2=network2

disableDefaultCNI=false
CTX_EAST=kind-${east}
CTX_WEST=kind-${west}
```

```bash
# 集群一 Cluster 1
cluster=${east}
network=${network1}
((net=$net1%32000+1))
k="kubectl --context=kind-${cluster}"
CTX_CLUSTER=${CTX_EAST}


# 集群二 Cluster2
cluster=${west}
network=${network2}
((net=$net2%32000+1))
k="kubectl --context=kind-${cluster}"
CTX_CLUSTER=${CTX_WEST}
```

```bash
# 安装 kind 集群
# This config is roughly based on: https://kind.sigs.k8s.io/docs/user/ingress/
cat <<EOF | kind create cluster --name "${cluster}" --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  serviceSubnet: "10.96.${net}.0/24"
  podSubnet: "192.168.2${net}.0/24"
  disableDefaultCNI: true
nodes:
- role: control-plane
- role: worker
EOF

# 配置集群网络

$k apply -f https://docs.projectcalico.org/manifests/calico.yaml


# cluster network metallb
${k} apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
${k} create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
${k} apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml

docker network inspect -f '{{.IPAM.Config}}' kind
if hostname -i; then
  myip=$(hostname -i)
else
  myip=$(ipconfig getifaddr en0)
fi
ipkind=$(docker inspect ${cluster}-control-plane | jq -r '.[0].NetworkSettings.Networks[].IPAddress')
networkkind=$(echo ${ipkind} | sed 's/.$//')
# Create the metallb address pool based on the cluster subnet
cat << EOF | ${k} apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - ${networkkind}2${net}0-${networkkind}2${net}9
EOF
```

### 安装 linkerd

#### 单集群

参考[官方 Demo](https://linkerd.io/2.11/getting-started/#step-5-explore-linkerd)

```bash
# Step 0: Setup
kubectl version --short
# Install the CLI
curl -fsL https://run.linkerd.io/install | sh
# Step 2: Validate your Kubernetes cluster
linkerd check --pre

# Step 3: Install the control plane onto your cluster
linkerd install | kubectl apply -f -

linkerd check

# Step 4: Install the demo app
curl -fsL https://run.linkerd.io/emojivoto.yml | kubectl apply -f -
# 端口映射到本机
kubectl -n emojivoto port-forward svc/web-svc 8080:80

# 随着 Emoji 的安装和运行，我们已经准备好网格，也就是说，添加 Linkerd 的数据平面代理到它。由于Kubernetes 的滚动部署，我们可以在不停机的情况下在实时应用程序上做到这一点。通过运行你的Emojivoto 应用
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -

# 可以在数据平面上验证一切是否按照应该的方式工作。检查您的数据平面
linkerd -n emojivoto check --proxy


# Step 5: Explore Linkerd!
# 由于 linkerd 为了保证其轻量，没有对应用做过多的干扰，需要更详细的分析，可以通过安装插件
# For this guide, we will need one of:

# 1. The viz extension, which will install an on-cluster metric stack; or
# 2. The buoyant-cloud extension, which will connect to a hosted metrics stack.
# You can install either or both extensions. To install the viz extension, run:
linkerd viz install | kubectl apply -f - # install the on-cluster metrics stack

# To install the buoyant-cloud extension, run:
curl -fsL https://buoyant.cloud/install | sh # get the installer
linkerd buoyant install | kubectl apply -f - # connect to the hosted metrics stack


# Once you’ve installed your extensions, let’s validate everything one last time:
linkerd check

linkerd viz dashboard &
linkerd buoyant dashboard &
```

#### 多集群

```bash
# ca init
step certificate create root.linkerd.cluster.local root.crt root.key \
  --profile root-ca --no-password --insecure

step certificate create identity.linkerd.cluster.local issuer.crt issuer.key \
  --profile intermediate-ca --not-after 8760h --no-password --insecure \
  --ca root.crt --ca-key root.key


# install linkerd
linkerd install \
  --identity-trust-anchors-file root.crt \
  --identity-issuer-certificate-file issuer.crt \
  --identity-issuer-key-file issuer.key \
  | tee \
    >(kubectl --context=${CTX_EAST} apply -f -) \
    >(kubectl --context=${CTX_WEST} apply -f -)

# check linkerd
for ctx in ${CTX_EAST} ${CTX_WEST}; do
  echo "Checking cluster: ${ctx} .........\n"
  linkerd --context=${ctx} check || break
  echo "-------------\n"
done

# install jeager
linkerd --context=${CTX_WEST} jaeger install | kubectl --context=${CTX_WEST} apply -f -

# install viz
for ctx in ${CTX_EAST} ${CTX_WEST}; do
  echo "Installing on cluster: ${ctx} ........."
  linkerd --context=${ctx} viz install | \
    kubectl --context=${ctx} apply -f - || break
  echo "-------------\n"
done

# install multicluster extension
for ctx in ${CTX_EAST} ${CTX_WEST}; do
  echo "Installing on cluster: ${ctx} ........."
  linkerd --context=${ctx} multicluster install | \
    kubectl --context=${ctx} apply -f - || break
  echo "-------------\n"
done

# install multicluster gateway
for ctx in ${CTX_EAST} ${CTX_WEST}; do
  echo "Checking gateway on cluster: ${ctx} ........."
  kubectl --context=${ctx} -n linkerd-multicluster \
    rollout status deploy/linkerd-gateway || break
  echo "-------------\n"
done

# Double check that the load balancer was able to allocate a public IP address by running:
for ctx in ${CTX_EAST} ${CTX_WEST}; do
  printf "Checking cluster: ${ctx} ........."
  while [ "$(kubectl --context=${ctx} -n linkerd-multicluster get service \
    -o 'custom-columns=:.status.loadBalancer.ingress[0].ip' \
    --no-headers)" = "<none>" ]; do
      printf '.'
      sleep 1
  done
  printf "\n"
done

```

#### 多集群通讯

![multi-network](https://linkerd.io/images/multicluster/link-flow.svg)
集群 west 能够查看 east 集群的所有服务，需要配置访问证书，这样对集群的安全有一定的保障。
下面将 源集群 east 暴露到目标集群 west

```bash
linkerd --context=kind-east multicluster link --cluster-name east |
  kubectl --context=kind-west apply -f -

linkerd --context=${CTX_WEST} multicluster check
linkerd --context=${CTX_WEST} multicluster gateways
```

#### test services

```bash
kubectl --context=${CTX_WEST} create ns test
kubectl --context=${CTX_WEST} apply -k "github.com/linkerd/website/multicluster/west/"
kubectl --context=${CTX_WEST} -n test rollout status deploy/podinfo || break

kubectl --context=${CTX_EAST} create ns test
kubectl --context=${CTX_EAST} apply -k "github.com/linkerd/website/multicluster/east/"
kubectl --context=${CTX_EAST} -n test rollout status deploy/podinfo || break


# 访问 service
kubectl --context=${CTX_WEST} -n test port-forward svc/frontend 8080 --address 0.0.0.0

# 暴露 services
kubectl --context=${CTX_EAST} label svc -n test podinfo mirror.linkerd.io/exported=true
kubectl --context=${CTX_EAST} label svc -n test podinfo mirror.linkerd.io/exported=false

# 检查被 morror controller 创建的 service
kubectl --context=${CTX_WEST} -n test get svc podinfo-east
# NAME           TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)             AGE
# podinfo-east   ClusterIP   10.96.1.2    <none>        9898/TCP,9999/TCP   7m40s

# linkerd 通过创建镜像 service 来实现集群发现，其底层还包括 endponit，我们可以通过如下方式来颜值
kubectl --context=${CTX_WEST} -n test get endpoints podinfo-east \
  -o 'custom-columns=ENDPOINT_IP:.subsets[*].addresses[*].ip'
# ENDPOINT_IP
# 172.18.0.220
kubectl --context=${CTX_EAST} -n linkerd-multicluster get svc linkerd-gateway \
  -o "custom-columns=GATEWAY_IP:.status.loadBalancer.ingress[*].ip"
# GATEWAY_IP
# 172.18.0.220
# west 发现 podinfo-east 服务的 [endpoint ip] = [east 网关 ip]

# 我们可以在 west 集群访问到 east 集群中的 podinfo 服务
kubectl --context=kind-west -n test exec -c nginx -it \
  $(kubectl --context=kind-west -n test get po -l app=frontend \
    --no-headers -o custom-columns=:.metadata.name) \
  -- /bin/sh -c "curl http://podinfo-east:9898"


# 分析服务状态
linkerd --context=${CTX_WEST} -n test viz stat --from deploy/frontend svc

# 查看控制面板
linkerd --context=${CTX_WEST} viz dashboard --address 0.0.0.0


kubectl --context=${CTX_WEST} -n test run -it --rm --image=alpine:3 test -- \
  /bin/sh -c "apk add curl && curl -vv http://podinfo-east:9898"
```

#### 流量分流

```bash
cat <<EOF | kubectl --context=${CTX_WEST} apply -f -
apiVersion: split.smi-spec.io/v1alpha1
kind: TrafficSplit
metadata:
  name: podinfo
  namespace: test
spec:
  service: podinfo
  backends:
  - service: podinfo
    weight: 50
  - service: podinfo-east
    weight: 50
EOF

linkerd --context=${CTX_WEST} -n test viz stat trafficsplit
linkerd --context=${CTX_EAST} -n test viz stat \
  --from deploy/linkerd-gateway \
  --from-namespace linkerd-multicluster \
  deploy/podinfo
```

### 集群接入 buoyant cloud

#### 多集群

```bash
kubectl --context=${CTX_EAST} apply -f \
https://buoyant.cloud/agent/buoyant-cloud-k8s-east-auJGYB7gmXLc2m10-3THZ0z_67elmg62wflDn0Fo3R3qX5WG1vEYZkZNsa7E=.yml

kubectl --context=${CTX_WEST} apply -f \
https://buoyant.cloud/agent/buoyant-cloud-k8s-west-32P8NqkCLF7X_cLf-qlJS7cQlpEjoTe8DYD-h57icozlLFHz60exr38WD2c0=.yml
```

#### 单集群

```bash
kubectl apply -f \
https://buoyant.cloud/agent/buoyant-cloud-k8s-nicole-local-l3Jccgk_Lr1LBzn8-OYJYpDLXckXQkozb8uvZxPHKDYqanXGl1lBOkPkbE_s\=.yml
# namespace/buoyant-cloud created
# secret/buoyant-cloud-id created
# serviceaccount/buoyant-cloud-agent created
# clusterrole.rbac.authorization.k8s.io/buoyant-cloud-agent created
# clusterrolebinding.rbac.authorization.k8s.io/buoyant-cloud-agent created
# deployment.apps/buoyant-cloud-agent created
# configmap/buoyant-cloud-metrics created
# daemonset.apps/buoyant-cloud-metrics created

# check po
kubectl get po -n buoyant-cloud
# NAME                                   READY   STATUS    RESTARTS   AGE
# buoyant-cloud-agent-77666dfb9f-j9p5f   1/1     Running   0          94s
# buoyant-cloud-metrics-k57kj            1/1     Running   0          93s

```

### Linkerd CRD

#### [Service Profile](https://linkerd.io/2.11/tasks/setting-up-service-profiles/)

##### 介绍

`Service Proiles` 定义服务如何处理请求的介绍。
Linkerd Proxy 接收到 HTTP(非 HTTPS) 请求时，识别出出 Destination Service。如果 Destination Service 存在，该 Service Profiles 将提供给 [per-route metrics](), [retries]() 与 [timeoutes]()

官方提供四种方法创建 CRD

- Swagger
- Protobuf
- Auto-Creation
- Template

##### demo

```bash
linkerd profile --open-api webapp.swagger webapp

linkerd profile --proto web.proto web-svc

linkerd viz profile -n emojivoto web-svc --tap deploy/web --tap-duration 10s
# linkerd viz profile -ntest podinfo --tap deploy/podinfo --tap-duration 30s

linkerd profile -n emojivoto web-svc --template

```

```yaml
apiVersion: linkerd.io/v1alpha2
kind: ServiceProfile
metadata:
  creationTimestamp: null
  name: podinfo.test.svc.cluster.local
  namespace: test
spec:
  routes:
    - condition:
        method: GET
        pathRegex: /api/info
      name: GET /api/info
      timeout: 300ms
      isRetryable: true
    - condition:
        method: POST
        pathRegex: /api/echo
      name: POST /api/echo
  retryBudget:
    retryRatio: 0.2
    minRetriesPerSecond: 10
    ttl: 10s
```

## 参考

- [Linkerd](https://linkerd.io/2.11/overview/)
- [Linkerd 中文文档](https://doczhcn.gitbook.io/linkerd/index/gai-kuang)
- [Service Mesh Comparison](https://servicemesh.es/)
- [Linkerd Step by Step](https://cloud.tencent.com/developer/article/1843124)
