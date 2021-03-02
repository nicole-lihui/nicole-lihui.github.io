- [搭建 Kubernetes Cluster On CentOS 7](#搭建-kubernetes-cluster-on-centos-7)
  - [前提条件（Prerequisites）](#前提条件prerequisites)
    - [Basic](#basic)
    - [设备信息](#设备信息)
  - [搭建步骤](#搭建步骤)
    - [Installation of Kubernetes Cluster on Master-Node](#installation-of-kubernetes-cluster-on-master-node)
      - [Step 1: Prepare Hostname, Firewall and SELinux](#step-1-prepare-hostname-firewall-and-selinux)
      - [Step 2: Setup the Kubernetes Repo](#step-2-setup-the-kubernetes-repo)
      - [Step 3: Install Kubeadm and Docker](#step-3-install-kubeadm-and-docker)
      - [Step 4: Initialize Kubernetes Master and Setup Default User](#step-4-initialize-kubernetes-master-and-setup-default-user)
      - [Step 5: To use root, run:](#step-5-to-use-root-run)
      - [Step 6: Setup Your Pod Network](#step-6-setup-your-pod-network)
    - [Setting Up Worker Nodes to Join Kubernetes Cluster](#setting-up-worker-nodes-to-join-kubernetes-cluster)
      - [Step 1: Prepare Hostname, Firewall and SELinux](#step-1-prepare-hostname-firewall-and-selinux-1)
      - [Setup the Kubernetes Repo](#setup-the-kubernetes-repo)
      - [Step 3: Install Kubeadm and Docker](#step-3-install-kubeadm-and-docker-1)
      - [Step 4: Join the Worker Node to the Kubernetes Cluster](#step-4-join-the-worker-node-to-the-kubernetes-cluster)
    - [参考资料](#参考资料)

# 搭建 Kubernetes Cluster On CentOS 7

## 前提条件（Prerequisites）
### Basic
* Multiple Linux servers running CentOS 7 (1 Master Node, One Worker Node or Multiple Worker Nodes)
* A user account on every system with sudo or root privileges
* The `yum` package manager, included by default


### 设备信息
|主机名称 |系统  |内存 |CPU  |磁盘 |
|:---:|:---:|:---:|:---:|:---:|
|host 1 |CentOS 7  |16G |8 |128G |
|host 2 |CentOS 7  |16G |8 |128G |

## 搭建步骤
> 为了使用 Kubernetes，我们需要安装一个 容器化引擎。现在主流的容器就是 Docker。在 Master Node 和 Worker Node 上，我们都需要安装 Docker。

### Installation of Kubernetes Cluster on Master-Node
#### Step 1: Prepare Hostname, Firewall and SELinux
```BASH
# 修改主机名
hostnamectl set-hostname master-node

# On your master node, set the hostname and if you don’t have a DNS server, then also update your /etc/hosts file.
cat <<EOF >> /etc/hosts
10.31.203.1 master-node
10.31.203.2 node-1 worker-node-1
10.31.203.3 node-2 worker-node-2
EOF

# Next, disable SElinux and update your firewall rules.
setenforce 0

sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

reboot

# Set the following firewall rules on ports. Make sure that each firewall-cmd command, returns a success.
firewall-cmd --permanent --add-port=6443/tcp
firewall-cmd --permanent --add-port=2379-2380/tcp
firewall-cmd --permanent --add-port=10250/tcp
firewall-cmd --permanent --add-port=10251/tcp
firewall-cmd --permanent --add-port=10252/tcp
firewall-cmd --permanent --add-port=10255/tcp
firewall-cmd --reload

# modprobe
# 用于向内核中加载模块或者从内核中移除模块。
# modprobe  br_netfilter  加载模块
# modprobe  -r  br_netfilter  移除
modprobe br_netfilter

echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

```

#### Step 2: Setup the Kubernetes Repo
```BASH
# You will need to add Kubernetes repositories manually as they do not come installed by default on CentOS 7.
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# China
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
```

#### Step 3: Install Kubeadm and Docker
```BASH
# With the package repo now ready, you can go ahead and install kubeadm and docker packages.
yum install kubeadm docker -y 

# When the installation completes successfully, enable and start both services.
systemctl enable kubelet
systemctl start kubelet
systemctl enable docker
systemctl start docker

# docker replice repo
# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors":[
      "https://kfwkfulq.mirror.aliyuncs.com",
      "https://2lqq34jg.mirror.aliyuncs.com",
      "https://pee6w651.mirror.aliyuncs.com",
      "http://hub-mirror.c.163.com",
      "https://docker.mirrors.ustc.edu.cn",
      "https://registry.docker-cn.com"
  ]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
systemctl daemon-reload
systemctl restart docker
```

#### Step 4: Initialize Kubernetes Master and Setup Default User
```BASH
# Now we are ready to initialize kubernetes master, but before that you need to disable swap in order to run “kubeadm init“ command.
swapoff -a

# Initializing Kubernetes master is a fully automated process that is managed by the “kubeadm init“ command which you will run.
kubeadm init

# 如果是国内，最好指定 镜像仓库
kubeadm init --image-repository registry.aliyuncs.com/google_containers
```
> kubeadm init 结果如下：
```BASH
# etc...
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 10.31.203.1:6443 --token ni3wg5.1u8p0zbwap7pyjwp \
    --discovery-token-ca-cert-hash sha256:e4a22699640580b5a007b1b7934516351b12173c38db403af56375ba02add47b 
```

#### Step 5: To use root, run:
Having initialized Kubernetes successfully, you will need to allow your user to start using the cluster. In our case, we want to run this installation as root user, therefore we will go ahead and run these commands as root. You can change to a sudo enabled user you prefer and run the below using sudo.
```BASH
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

service kubelet restart

# Now check to see if the kubectl command is activated.
kubectl get nodes
```

#### Step 6: Setup Your Pod Network
>此时，您还将注意到主节点的状态为NotReady。这是因为我们还没有将pod网络部署到集群中。

>pod网络是集群的覆盖网络，部署在现有节点网络的顶部。它的设计目的是允许跨吊舱的连接。
```BASH
export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"

# Now if you check the status of your master-node, it should be ‘Ready’.
kubectl get nodes

```

### Setting Up Worker Nodes to Join Kubernetes Cluster
The following steps will run on the worker nodes. These steps should be run on every worker node when joining the Kubernetes cluster.

#### Step 1: Prepare Hostname, Firewall and SELinux
```BASH
# On your worker-node-1 and worker-node-2, set the hostname and in case you don’t have a DNS server, then also update your master and worker nodes on /etc/hosts file.
hostnamectl set-hostname 'node-1'

cat <<EOF >> /etc/hosts
10.31.203.1 master-node
10.31.203.2 node-1 worker-node-1
10.31.203.3 node-2 worker-node-2
EOF

# Next, disable SElinux and update your firewall rules.
setenforce 0

sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

# Set the following firewall rules on ports. Make sure that all firewall-cmd commands, return success.
firewall-cmd --permanent --add-port=6783/tcp
firewall-cmd --permanent --add-port=10250/tcp
firewall-cmd --permanent --add-port=10255/tcp
firewall-cmd --permanent --add-port=30000-32767/tcp
firewall-cmd --reload


modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
```

#### Setup the Kubernetes Repo
```BASH
# You will need to add Kubernetes repositories manually as they do not come pre-installed on CentOS 7.
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# China
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
```

#### Step 3: Install Kubeadm and Docker
```BASH
# With the package repo now ready, you can go ahead and install kubeadm and docker packages.
yum install kubeadm docker -y 

# Start and enable both the services.
systemctl enable docker
systemctl start docker
systemctl enable kubelet
systemctl start kubelet
```

#### Step 4: Join the Worker Node to the Kubernetes Cluster
```BASH
# We now require the token that kubeadm init generated, to join the cluster. You can copy and paste it to your node-1 and node-2 if you had copied it somewhere.
kubeadm join 10.31.203.1:6443 --token ni3wg5.1u8p0zbwap7pyjwp --discovery-token-ca-cert-hash sha256:e4a22699640580b5a007b1b7934516351b12173c38db403af56375ba02add47b 
```
> 在 master node 上检测 work node 是否连接
```BASH
# kubectl get nodes
NAME          STATUS   ROLES                  AGE     VERSION
master-node   Ready    control-plane,master   19m     v1.20.4
node-1        Ready    <none>                 7m53s   v1.20.4
```

### 参考资料
* [Install Kubernetes Cluster on CentOS 7 with kubeadm](https://computingforgeeks.com/install-kubernetes-cluster-on-centos-with-kubeadm/)
* [Kubernetes(K8s) 安装（使用kubeadm安装Kubernetes集群）](https://www.cnblogs.com/zhizihuakai/p/12629514.html)
* [How to Install a Kubernetes Cluster on CentOS 7](https://www.tecmint.com/install-kubernetes-cluster-on-centos-7/)
* [手把手从零搭建与运营生产级的 Kubernetes 集群与 KubeSphere](https://www.kubernetes.org.cn/7315.html)
