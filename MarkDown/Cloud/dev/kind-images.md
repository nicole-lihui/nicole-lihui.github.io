```bash
docker pull gcr.io/istio-testing/app:latest
docker pull  gcr.io/istio-testing/app_sidecar_ubuntu_jammy:latest
docker pull  gcr.io/istio-testing/proxyv2:latest
docker pull docker.io/prom/prometheus:v2.34.0


# kind 共享镜像
# kind load 本地镜像

kind load docker-image gcr.io/istio-testing/app:latest --name cluster-1
kind load docker-image gcr.io/istio-testing/app_sidecar_ubuntu_jammy:latest --name cluster-1
kind load docker-image gcr.io/istio-testing/proxyv2:latest --name cluster-1


kind load docker-image docker.io/prom/prometheus:v2.34.0 --name cluster-1

```


```bash
docker pull quay.io/metallb/speaker:v0.12.1
docker pull quay.io/metallb/controller:v0.12.1


kind load docker-image quay.io/metallb/speaker:v0.12.1 --name cluster-1
kind load docker-image  quay.io/metallb/controller:v0.12.1 --name cluster-1

```
