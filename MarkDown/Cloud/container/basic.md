- [Docker](#docker)
  - [容器化发展历程](#容器化发展历程)
  - [Docker基础](#docker基础)
    - [Docker 概念](#docker-概念)
    - [Docker Install](#docker-install)
      - [Desktop installs](#desktop-installs)
      - [Server installs](#server-installs)
      - [Upgrading the Docker Engine](#upgrading-the-docker-engine)
      - [Storage driver](#storage-driver)
        - [基础](#基础)
        - [Devicemapper （磁盘映射）](#devicemapper-磁盘映射)
  - [Docker架构深入理解](#docker架构深入理解)
  - [Docker最佳实践](#docker最佳实践)

# Docker

## 容器化发展历程
* **远古**：
  * 单一应用独占一个服务器，服务器资源浪费
  * 资本和运营支出的成本高
* **vm**：
  * 多个应用可以共享同一个服务器
  * 允许同一台计算机上同时存在多个操作系统（OS）环境
  * 使用户能够超越硬件限制来实现最终目标
  * vm的OS其消耗的系统资源（cpu、ram、storage）很大，其消耗可以运行多个应用；
  * vm启动慢，迁移难度高并且工作量大
  * [Why use Virtualization](https://docs.oracle.com/cd/E50245_01/E50249/html/vmcon-intro-virt-reasons.html)
  * [Virtual Machine and its Benefits](https://www.parallels.com/blogs/ras/virtual-machine/#:~:text=Benefits%20of%20using%20a%20virtual,to%20achieve%20their%20end%20goals.)
* **container**：
  * 同一个主机上的多个container共享单一的os，并且其os是轻量级的
  * 节省了资本和运营支出的成本
  * 可以快速启动、便于迁移
  * 类容器虚拟技术：System/360、BSD Jails 、Solaris Zones（Unix-type container technologies）
* **Docker**（Linux）：
  * 让容器变得更加简单
* **Windows containers**（Docker）
  * 实现windows OS服务器上docker容器化
* **Mac containers** （Docker for mac）
  * 实现macos 运行container， 多用于开发人员测试和开发
* **Kubernetes**
  * Kubernetes is an important piece of software that helps us deploy our containerizedapps and keep them running.


---
参考资料：
* Book: Docker Deep Dive (version 5 -- 2018)
* [Why use Virtualization](https://docs.oracle.com/cd/E50245_01/E50249/html/vmcon-intro-virt-reasons.html)
* [Virtual Machine and its Benefits](https://www.parallels.com/blogs/ras/virtual-machine/#:~:text=Benefits%20of%20using%20a%20virtual,to%20achieve%20their%20end%20goals.)

## Docker基础
### Docker 概念
* **Docker runtime and orchestration engine**
> Docker Engin：第三方产品插入**Docker Engine**并围绕它进行建造。下图以Docker Engine为中心。图中的其他产品都建立在引擎的基础上，并利用其核心功能。
    ![docker-engin](./img/docker-engin.png)

* **Docker,Inc** Docker科技公司
* **Moby** Docker开源项目

### Docker Install
#### Desktop installs
* Docker for Windows
* Docker for Mac
#### Server installs
  * Linux
  * Windows Server
#### Upgrading the Docker Engine

#### Storage driver
> 每个Docker容器都有自己的本地存储区域，在该区域中会堆叠图像层并安装容器文件系统。 默认情况下，这是发生所有容器读/写操作的地方，这使其成为每个容器的性能和稳定性不可或缺的一部分。

##### 基础
* Linux上可用于Docker的Storage driver程序
  * aufs ( 原始的和最古老的 )
  * overlay2 ( 也许是未来最好的选择 )
  * devicemapper
  * btrfs
  * zfs

* 选择合适的Storage driver
  * Red Hat Enterprise Linux with a 4.x kernel or higher + Docker 17.06 and higher:  **overlay2**
  * Red Hat Enterprise Linux with an older kernel and older versions of Docker: **devicemapper**
  * Ubuntu Linux with a 4.x kernel or higher: **overlay2**
  * Ubuntu Linux with an earlier kernel: **aufs**
  * SUSE Linux Enterprise Server: **btrfs**

##### Devicemapper （磁盘映射）
> 大多数Linux存储驱动程序只需要很少或不需要配置。但是，devicemapper需要进行配置才能表现良好


## Docker架构深入理解

## Docker最佳实践