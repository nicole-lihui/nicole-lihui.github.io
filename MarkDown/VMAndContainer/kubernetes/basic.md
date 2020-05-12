# Kubernets

## Minikube
### Introduce


### Install and Usage
* [官网安装](https://kubernetes.io/docs/tasks/tools/install-minikube/)
* [官方Minikube提供了完整对国内用户支持：](https://github.com/AliyunContainerService/minikube)
* [Minikube 搭建单节点K8S环境(国内安装步骤)](https://www.jianshu.com/p/b10c0d7f7d18)
```bash

# 使用国内源启动
minikube start --vm-driver=docker --registry-mirror=https://registry.docker-cn.com --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
# or
 minikube start --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
```


## Error
```bash
# minikube start Error 
$ minikube start --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
😄  minikube v1.9.2 on Darwin 10.14.6
✨  Using the virtualbox driver based on existing profile
✅  Using image repository registry.cn-hangzhou.aliyuncs.com/google_containers
👍  Starting control plane node m01 in cluster minikube
💾  Downloading Kubernetes v1.18.0 preload ...
🏃  Updating the running virtualbox "minikube" VM ...
E0511 12:46:55.669792    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/dashboard:v2.0.0-rc6" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/dashboard_v2.0.0-rc6" failed: write: unexpected EOF
E0511 12:46:59.475713    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.4.3-0" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/etcd_3.4.3-0" failed: write: unexpected EOF
E0511 12:47:07.917912    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.18.0" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler_v1.18.0" failed: write: unexpected EOF
E0511 12:47:12.430037    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/storage-provisioner:v1.8.1" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/storage-provisioner_v1.8.1" failed: write: unexpected EOF
E0511 12:47:13.763633    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.18.0" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager_v1.18.0" failed: write: unexpected EOF
E0511 12:47:18.372512    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:1.6.7" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/coredns_1.6.7" failed: write: unexpected EOF
E0511 12:47:29.052001    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/metrics-scraper:v1.0.2" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/metrics-scraper_v1.0.2" failed: write: unexpected EOF
E0511 12:57:05.427899    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.18.0" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy_v1.18.0" failed: write: unexpected EOF
E0511 12:57:05.427941    5814 cache.go:126] Error caching images:  Caching images for kubeadm: caching images: caching image "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/dashboard_v2.0.0-rc6": write: unexpected EOF
E0511 12:58:51.734451    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.18.0" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler_v1.18.0" failed: write: unexpected EOF
E0511 12:58:54.568807    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/dashboard:v2.0.0-rc6" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/dashboard_v2.0.0-rc6" failed: write: unexpected EOF
E0511 12:58:58.871012    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/metrics-scraper:v1.0.2" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/metrics-scraper_v1.0.2" failed: write: unexpected EOF
E0511 12:59:12.928147    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.4.3-0" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/etcd_3.4.3-0" failed: write: unexpected EOF
E0511 12:59:28.547168    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.18.0" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager_v1.18.0" failed: write: unexpected EOF
E0511 13:00:07.517487    5814 cache.go:63] save image to file "registry.cn-hangzhou.aliyuncs.com/google_containers/storage-provisioner:v1.8.1" -> "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/storage-provisioner_v1.8.1" failed: write: unexpected EOF

💣  Failed to cache images: Caching images for kubeadm: caching images: caching image "/Users/nicole/.minikube/cache/images/registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler_v1.18.0": write: unexpected EOF

😿  minikube is exiting due to an error. If the above message is not useful, open an issue:
👉  https://github.com/kubernetes/minikube/issues/new/choose


$ minikube logs
==> Docker <==
-- Logs begin at Mon 2020-05-11 05:47:25 UTC, end at Mon 2020-05-11 06:06:16 UTC. --
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.836504443Z" level=info msg="loading plugin "io.containerd.snapshotter.v1.native"..." type=io.containerd.snapshotter.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.836619089Z" level=info msg="loading plugin "io.containerd.snapshotter.v1.overlayfs"..." type=io.containerd.snapshotter.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.836775622Z" level=info msg="loading plugin "io.containerd.snapshotter.v1.zfs"..." type=io.containerd.snapshotter.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.836950599Z" level=info msg="skip loading plugin "io.containerd.snapshotter.v1.zfs"..." type=io.containerd.snapshotter.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.836991592Z" level=info msg="loading plugin "io.containerd.metadata.v1.bolt"..." type=io.containerd.metadata.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.837054484Z" level=warning msg="could not use snapshotter btrfs in metadata plugin" error="path /var/lib/docker/containerd/daemon/io.containerd.snapshotter.v1.btrfs must be a btrfs filesystem to be used with the btrfs snapshotter"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.837090991Z" level=warning msg="could not use snapshotter aufs in metadata plugin" error="modprobe aufs failed: "modprobe: FATAL: Module aufs not found in directory /lib/modules/4.19.107\n": exit status 1"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.837126742Z" level=warning msg="could not use snapshotter zfs in metadata plugin" error="path /var/lib/docker/containerd/daemon/io.containerd.snapshotter.v1.zfs must be a zfs filesystem to be used with the zfs snapshotter: skip plugin"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840021660Z" level=info msg="loading plugin "io.containerd.differ.v1.walking"..." type=io.containerd.differ.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840145067Z" level=info msg="loading plugin "io.containerd.gc.v1.scheduler"..." type=io.containerd.gc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840288401Z" level=info msg="loading plugin "io.containerd.service.v1.containers-service"..." type=io.containerd.service.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840335765Z" level=info msg="loading plugin "io.containerd.service.v1.content-service"..." type=io.containerd.service.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840373000Z" level=info msg="loading plugin "io.containerd.service.v1.diff-service"..." type=io.containerd.service.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840449196Z" level=info msg="loading plugin "io.containerd.service.v1.images-service"..." type=io.containerd.service.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840491096Z" level=info msg="loading plugin "io.containerd.service.v1.leases-service"..." type=io.containerd.service.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840527198Z" level=info msg="loading plugin "io.containerd.service.v1.namespaces-service"..." type=io.containerd.service.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840562743Z" level=info msg="loading plugin "io.containerd.service.v1.snapshots-service"..." type=io.containerd.service.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840597935Z" level=info msg="loading plugin "io.containerd.runtime.v1.linux"..." type=io.containerd.runtime.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840724473Z" level=info msg="loading plugin "io.containerd.runtime.v2.task"..." type=io.containerd.runtime.v2
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.840817273Z" level=info msg="loading plugin "io.containerd.monitor.v1.cgroups"..." type=io.containerd.monitor.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841094021Z" level=info msg="loading plugin "io.containerd.service.v1.tasks-service"..." type=io.containerd.service.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841146266Z" level=info msg="loading plugin "io.containerd.internal.v1.restart"..." type=io.containerd.internal.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841207282Z" level=info msg="loading plugin "io.containerd.grpc.v1.containers"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841248303Z" level=info msg="loading plugin "io.containerd.grpc.v1.content"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841283506Z" level=info msg="loading plugin "io.containerd.grpc.v1.diff"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841317418Z" level=info msg="loading plugin "io.containerd.grpc.v1.events"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841354717Z" level=info msg="loading plugin "io.containerd.grpc.v1.healthcheck"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841441046Z" level=info msg="loading plugin "io.containerd.grpc.v1.images"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841485343Z" level=info msg="loading plugin "io.containerd.grpc.v1.leases"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841520515Z" level=info msg="loading plugin "io.containerd.grpc.v1.namespaces"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841554875Z" level=info msg="loading plugin "io.containerd.internal.v1.opt"..." type=io.containerd.internal.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841623480Z" level=info msg="loading plugin "io.containerd.grpc.v1.snapshots"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841665891Z" level=info msg="loading plugin "io.containerd.grpc.v1.tasks"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841701803Z" level=info msg="loading plugin "io.containerd.grpc.v1.version"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841736271Z" level=info msg="loading plugin "io.containerd.grpc.v1.introspection"..." type=io.containerd.grpc.v1
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841857032Z" level=info msg=serving... address="/var/run/docker/containerd/containerd-debug.sock"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.841965665Z" level=info msg=serving... address="/var/run/docker/containerd/containerd.sock"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.842003623Z" level=info msg="containerd successfully booted in 0.008281s"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.848196009Z" level=info msg="parsed scheme: \"unix\"" module=grpc
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.848225625Z" level=info msg="scheme \"unix\" not registered, fallback to default scheme" module=grpc
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.848242478Z" level=info msg="ccResolverWrapper: sending update to cc: {[{unix:///var/run/docker/containerd/containerd.sock 0  <nil>}] <nil>}" module=grpc
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.848249245Z" level=info msg="ClientConn switching balancer to \"pick_first\"" module=grpc
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.854537265Z" level=info msg="parsed scheme: \"unix\"" module=grpc
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.854565755Z" level=info msg="scheme \"unix\" not registered, fallback to default scheme" module=grpc
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.854580329Z" level=info msg="ccResolverWrapper: sending update to cc: {[{unix:///var/run/docker/containerd/containerd.sock 0  <nil>}] <nil>}" module=grpc
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.854587786Z" level=info msg="ClientConn switching balancer to \"pick_first\"" module=grpc
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.880955212Z" level=warning msg="Your kernel does not support cgroup blkio weight"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.880995112Z" level=warning msg="Your kernel does not support cgroup blkio weight_device"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.881001331Z" level=warning msg="Your kernel does not support cgroup blkio throttle.read_bps_device"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.881005597Z" level=warning msg="Your kernel does not support cgroup blkio throttle.write_bps_device"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.881009709Z" level=warning msg="Your kernel does not support cgroup blkio throttle.read_iops_device"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.881037859Z" level=warning msg="Your kernel does not support cgroup blkio throttle.write_iops_device"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.881214817Z" level=info msg="Loading containers: start."
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.952382503Z" level=info msg="Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used to set a preferred IP address"
May 11 05:47:38 minikube dockerd[2360]: time="2020-05-11T05:47:38.994618744Z" level=info msg="Loading containers: done."
May 11 05:47:39 minikube dockerd[2360]: time="2020-05-11T05:47:39.017567785Z" level=info msg="Docker daemon" commit=afacb8b7f0 graphdriver(s)=overlay2 version=19.03.8
May 11 05:47:39 minikube dockerd[2360]: time="2020-05-11T05:47:39.017725398Z" level=info msg="Daemon has completed initialization"
May 11 05:47:39 minikube dockerd[2360]: time="2020-05-11T05:47:39.033560745Z" level=info msg="API listen on /var/run/docker.sock"
May 11 05:47:39 minikube dockerd[2360]: time="2020-05-11T05:47:39.033618670Z" level=info msg="API listen on [::]:2376"
May 11 05:47:39 minikube systemd[1]: Started Docker Application Container Engine.

==> container status <==
time="2020-05-11T06:06:18Z" level=fatal msg="failed to connect: failed to connect, make sure you are running as root and the runtime has been started: context deadline exceeded"
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

==> describe nodes <==
E0511 14:06:18.844896    6989 logs.go:178] command /bin/bash -c "sudo /var/lib/minikube/binaries/v1.18.0/kubectl describe nodes --kubeconfig=/var/lib/minikube/kubeconfig" failed with error: /bin/bash -c "sudo /var/lib/minikube/binaries/v1.18.0/kubectl describe nodes --kubeconfig=/var/lib/minikube/kubeconfig": Process exited with status 1
stdout:

stderr:
sudo: /var/lib/minikube/binaries/v1.18.0/kubectl: command not found
 output: "\n** stderr ** \nsudo: /var/lib/minikube/binaries/v1.18.0/kubectl: command not found\n\n** /stderr **"

==> dmesg <==
[  +5.004376] hpet1: lost 319 rtc interrupts
[  +5.007928] hpet1: lost 319 rtc interrupts
[  +5.009707] hpet1: lost 318 rtc interrupts
[  +5.001167] hpet1: lost 318 rtc interrupts
[  +5.001189] hpet1: lost 319 rtc interrupts
[  +5.004326] hpet1: lost 320 rtc interrupts
[  +5.002014] hpet1: lost 318 rtc interrupts
[  +5.005633] hpet1: lost 318 rtc interrupts
[May11 06:02] hpet1: lost 318 rtc interrupts
[  +5.007422] hpet1: lost 319 rtc interrupts
[  +5.007320] hpet1: lost 318 rtc interrupts
[  +5.005977] hpet1: lost 319 rtc interrupts
[  +5.004134] hpet1: lost 318 rtc interrupts
[  +5.007949] hpet1: lost 318 rtc interrupts
[  +5.013057] hpet1: lost 320 rtc interrupts
[  +5.011096] hpet1: lost 320 rtc interrupts
[  +5.013227] hpet1: lost 319 rtc interrupts
[  +5.005857] hpet1: lost 319 rtc interrupts
[  +5.017293] hpet1: lost 319 rtc interrupts
[  +5.008479] hpet1: lost 319 rtc interrupts
[May11 06:03] hpet1: lost 319 rtc interrupts
[  +5.008316] hpet1: lost 320 rtc interrupts
[  +5.004037] hpet1: lost 319 rtc interrupts
[  +5.004322] hpet1: lost 319 rtc interrupts
[  +5.004455] hpet1: lost 320 rtc interrupts
[  +5.012860] hpet1: lost 319 rtc interrupts
[  +5.005286] hpet1: lost 320 rtc interrupts
[  +5.011108] hpet1: lost 318 rtc interrupts
[  +5.011537] hpet1: lost 319 rtc interrupts
[  +5.004382] hpet1: lost 318 rtc interrupts
[  +5.008315] hpet1: lost 320 rtc interrupts
[  +5.004579] hpet1: lost 318 rtc interrupts
[May11 06:04] hpet1: lost 319 rtc interrupts
[  +5.008689] hpet1: lost 318 rtc interrupts
[  +5.005784] hpet1: lost 319 rtc interrupts
[  +5.008697] hpet1: lost 318 rtc interrupts
[  +5.005382] hpet1: lost 319 rtc interrupts
[  +5.006207] hpet1: lost 319 rtc interrupts
[  +5.007282] hpet1: lost 318 rtc interrupts
[  +5.004902] hpet1: lost 320 rtc interrupts
[  +5.009624] hpet1: lost 318 rtc interrupts
[  +5.004806] hpet1: lost 319 rtc interrupts
[  +5.000947] hpet1: lost 319 rtc interrupts
[  +5.010782] hpet1: lost 318 rtc interrupts
[May11 06:05] hpet1: lost 320 rtc interrupts
[  +5.004809] hpet1: lost 318 rtc interrupts
[  +5.008739] hpet1: lost 320 rtc interrupts
[  +5.004475] hpet1: lost 318 rtc interrupts
[  +5.004949] hpet1: lost 319 rtc interrupts
[  +5.010881] hpet1: lost 319 rtc interrupts
[  +5.013780] hpet1: lost 320 rtc interrupts
[  +5.006393] hpet1: lost 319 rtc interrupts
[  +5.005188] hpet1: lost 319 rtc interrupts
[  +5.007424] hpet1: lost 318 rtc interrupts
[  +5.006303] hpet1: lost 320 rtc interrupts
[  +5.004737] hpet1: lost 318 rtc interrupts
[May11 06:06] hpet1: lost 318 rtc interrupts
[  +5.009453] hpet1: lost 319 rtc interrupts
[  +5.006510] hpet1: lost 319 rtc interrupts
[  +5.012019] hpet1: lost 320 rtc interrupts

==> kernel <==
 06:06:18 up 19 min,  0 users,  load average: 0.04, 0.05, 0.06
Linux minikube 4.19.107 #1 SMP Thu Mar 26 11:33:10 PDT 2020 x86_64 GNU/Linux
PRETTY_NAME="Buildroot 2019.02.10"

==> kubelet <==
-- Logs begin at Mon 2020-05-11 05:47:25 UTC, end at Mon 2020-05-11 06:06:18 UTC. --
-- No entries --

❗  unable to fetch logs for: describe nodes
```
