

## 概念
Istio 多集群，能够打通集群之间的网络，能够实现对集群的流量管控和服务治理

## 部署模式
* 单一或多个集群
* 单一或多个网络
* 单一或多控制面板

上面的维度，可以根据需求自由组合。
需要部署 Istio 多集群，核心问题就是集群之间的通讯。

## 分析架构
### 架构介绍
无论集群是相同网络还是不同网络，多集群支持的核心是围绕 Istio 控制面板与 API Server 展开的。
* 主从 架构，决定这其集群之间的流量管控由`单 Istio 控制面板`管理，Istio 控制面板会同时监听多集群的`多 API Server`
![pr-re](https://istio.io/latest/zh/docs/setup/install/multicluster/primary-remote/arch.svg)


* 多主 架构，决定集群之间的流量管控通过多` Istio 控制面板`通过同时监听`多集群 API Server`
![multi-pr](https://istio.io/latest/zh/docs/setup/install/multicluster/multi-primary/arch.svg)

### 实现区别
#### 主从架构
主从架构，Istio 控制面板所在的集群作为**主集群**，而 其他集群作为**从集群**，其中最主要的是从集群如何与主集群建立联系，其关键点如下：
* 主集群需要开放 Istio 控制面板，让从集群能够共享`主 Istio 控制面板`
* 主集群添加从集群的 API Server 相互访问权限
* 从集群的 Istio 会共享主集群 Pilot
  * 从集群安装 Istio 配置，需要特别追加 `remotePilotAddress: ${DISCOVERY_ADDRESS}`，其中 `${DISCOVERY_ADDRESS}` 的地址是主集群暴露的东西网关地址。
  * 根据 Istio 源码分析，通过从集群会共享`主集群的 Istiod`， 从集群上部署 EndPoint: `istiod-remote`, [核心配置](https://github.com/istio/istio/blob/master/manifests/charts/base/templates/endpoints.yaml)如下：
```yaml
{{- if .Values.global.remotePilotAddress }}
  {{- if .Values.pilot.enabled }}
apiVersion: v1
kind: Endpoints
metadata:
  name: istiod-remote
  namespace: {{ .Release.Namespace }}
subsets:
- addresses:
  - ip: {{ .Values.global.remotePilotAddress }}
  ports:
  - port: 15012
    name: tcp-istiod
    protocol: TCP
  {{- else if regexMatch "^([0-9]*\\.){3}[0-9]*$" .Values.global.remotePilotAddress }}
apiVersion: v1
kind: Endpoints
metadata:
  name: istiod
  namespace: {{ .Release.Namespace }}
subsets:
- addresses:
  - ip: {{ .Values.global.remotePilotAddress }}
  ports:
  - port: 15012
    name: tcp-istiod
    protocol: TCP
  {{- end }}
---
{{- end }}
```

#### 多主架构
多主架构实现通过在每个集群中安装 Istio 控制面板，与单集群安装差异不大，其安装关键在于下面两点：
* 打通多集群之间的网络
  * 相同网络不需要任何操作
  * 不同网络需要通过配置`专有的东西网关`
* 多集群配置 API Server 相互访问权限
* 集群之间的信任关系
  * 可以根据需求配置 CA 证书
  * 生产环境可能更为复杂，需要考虑不同的用户，不同的共享隔离


## 网络
上面网络通讯的架构，都是基于网络互通的前提，这里生产环境的网络不同集群一般是网络不通的，如何实现打通网络是关键问题。

* Istio 官方给出的解决方案是通过配置东西网关
  * 跨集群边界的服务负载，通过专用的东西向网关，以间接的方式通讯。 每个集群中的网关必须可以从其他集群访问。
  * 默认情况下，此网关将被公开到互联网上。 生产系统可能需要添加额外的访问限制（即：通过防火墙规则）来防止外部攻击。
  * 因为集群位于不同的网络中，所以我们需要在两个集群东西向网关上开放所有服务（*.local）。 虽然此网关在互联网上是公开的，但它背后的服务只能被拥有可信 mTLS 证书、工作负载 ID 的服务访问， 就像它们处于同一网络一样。
![multi-primary_multi-network](https://istio.io/latest/zh/docs/setup/install/multicluster/multi-primary_multi-network/arch.svg)
![primary-remote_multi-network](https://istio.io/latest/zh/docs/setup/install/multicluster/primary-remote_multi-network/arch.svg)


## 环境要求与分析
* Kubernetes 版本：至少具备两个 Kubernetes 集群，且版本需为： 1.17, 1.18, 1.19, 1.20。
* Istio 版本：> V1.8
* API Server 访问权限：每个集群中的 API Server 必须能被网格中其他集群访问。
  * 可以通过**网络负载均衡器**开放公网 API Server访问
  * API Server 不能被直接访问，可以通过多网络 Primary-Remote (主从)架构配置的 **东西向网关** 可以用来开启 API Server 的访问
* 多集群信任：多集群服务网格部署要求你在网格中的所有集群之间建立信任关系

