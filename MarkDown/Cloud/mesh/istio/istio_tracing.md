# 主题： 深入浅出 Istio 可观测性
Istio 的可观测性是网格很大的一个优势能力，但是在实际使用过程中，大家都很遇到各种问题，例如：如何快速启用 Istio 观测能力？如何灵活配置相关观测配置？当配置不生效时如何进行排查？等等。让我们从其实现原理出发，帮助大家理解 Isito 的观测性的原理出发，让大家了解其本质，从源头解决大家的问题。


## per step
```bash
# install cluster by kind
# create cluster1
cat <<EOF >  cluster1.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
networking:
  podSubnet: "10.0.0.0/16" 
EOF
kind create cluster --config cluster1.yaml --name cluster1

# install istio
curl -L https://istio.io/downloadIstio | sh -
istioctl install --set profile=demo -y
```
**Demo**
```bash
# enable istio-injection
kubectl label namespace default istio-injection=enabled

# deploy bookinfo
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

# config gateway of bookinfo
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
# get ip and port
kubectl get svc istio-ingressgateway -n istio-system
# 80 nodePort
kubectl get nodes  -owide
# node IP
# 172.20.0.3:30034/productpage
# http://localhost:8080/productpage

# enable istio-injection
kubectl create ns sample
kubectl label namespace sample istio-injection=enabled
# deploy sleep
kubectl apply -f samples/sleep/sleep.yaml -n sample

# deploy httpbin
kubectl apply -f samples/httpbin/httpbin.yaml -n sample


##  data
export sleeppod=$(kubectl get pod -l app=sleep -o jsonpath={.items..metadata.name} -n sample)
kubectl exec "$sleeppod" -c sleep -n sample -- curl -sS -v httpbin:8000/status/418

kubectl exec "$sleeppod" -c sleep -n sample -- curl -sS -v helloworld:5000/hello


```

## Metric
```bash
# install prometheus
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.14/samples/addons/prometheus.yaml
istioctl dashboard prometheus

istio_requests_total{app="details", connection_security_policy="mutual_tls", destination_app="details", destination_canonical_revision="v1", destination_canonical_service="details", destination_cluster="Kubernetes", destination_principal="spiffe://cluster.local/ns/default/sa/bookinfo-details", destination_service="details.default.svc.cluster.local", destination_service_name="details", destination_service_namespace="default", destination_version="v1", destination_workload="details-v1", destination_workload_namespace="default", instance="10.0.1.15:15020", job="kubernetes-pods", namespace="default", pod="details-v1-5498c86cf5-b9hk6", pod_template_hash="5498c86cf5", reporter="destination", request_protocol="http", response_code="200", response_flags="-", security_istio_io_tlsMode="istio", service_istio_io_canonical_name="details", service_istio_io_canonical_revision="v1", source_app="productpage", source_canonical_revision="v1", source_canonical_service="productpage", source_cluster="Kubernetes", source_principal="spiffe://cluster.local/ns/default/sa/bookinfo-productpage", source_version="v1", source_workload="productpage-v1", source_workload_namespace="default", version="v1"}

```
### 参考
[istio的策略和遥测 与适配器](https://blog.csdn.net/h2604396739/article/details/116274060)


## Tracing
```bash
# install jeager
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.14/samples/addons/jaeger.yaml
istioctl dashboard jaeger
```


```bash
cat << EOF | kubectl apply -f -
apiVersion: telemetry.istio.io/v1alpha1
kind: Telemetry
metadata:
  name: demo-tracing
  namespace: demo
spec:
  selector:
    matchLabels:
      app: sleep
  tracing:
  - randomSamplingPercentage: 55.00
EOF

cat << EOF | kubectl apply -f -
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  name: tracing-config
  namespace: istio-system
spec:
  meshConfig:
    enableTracing: true
    defaultConfig:
      tracing:
        sampling: 58
EOF
```



### 参考
[一文详解｜Go 分布式链路追踪实现原理](https://blog.csdn.net/m0_59358648/article/details/125447634)
[kubernetes上实现 istio 分布式追踪](https://help.aliyun.com/document_detail/65437.html)
[b3-propagation 中文解释](https://juejin.cn/post/6865630766857584648)
[b3-propagation](https://github.com/openzipkin/b3-propagation)
[Zipkin B3 链路传播规范源码分析](https://juejin.cn/post/7059756331451809822)
[微服务全链路跟踪：jaeger集成istio，并兼容uber-trace-id与b3](https://cloud.tencent.com/developer/article/1622931)

## logs
```bash
istioctl dashboard envoy


kubectl logs -l app=sleep -c istio-proxy -n demo --tail 2
[2022-06-26T17:18:16.530Z] "GET /status/418 HTTP/1.1" 418 - via_upstream - "-" 0 135 2 2 "-" "curl/7.83.1-DEV" 
"f6cc77c7-9374-9d38-b169-3cdd506165f1" "httpbin:8000" "10.0.1.20:80" 
outbound|8000||httpbin.demo.svc.cluster.local 
10.0.1.19:36470 10.96.137.90:8000 10.0.1.19:53092 - default


kubectl logs -l app=httpbin -c istio-proxy -n demo --tail 2
[2022-06-26T17:18:16.531Z] "GET /status/418 HTTP/1.1" 418 - via_upstream - "-" 0 135 1 1 "-" "curl/7.83.1-DEV" 
"f6cc77c7-9374-9d38-b169-3cdd506165f1" "httpbin:8000" "10.0.1.20:80" 
inbound|80|| 127.0.0.6:49677 10.0.1.20:80 10.0.1.19:36470 
outbound_.8000_._.httpbin.demo.svc.cluster.local default
```

## Visualizing Your Mesh
```
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.14/samples/addons/kiali.yaml
istioctl dashboard kiali
```


## 参考
[可观测性应用istio](http://blog.mykernel.cn/2021/09/20/%E5%8F%AF%E8%A7%82%E6%B5%8B%E6%80%A7%E5%BA%94%E7%94%A8istio/)
