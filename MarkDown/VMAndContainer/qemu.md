# qemu

## Install
```bash
# ubuntu
sudo apt -y install qemu-kvm qemu virt-manager virt-viewer libvirt-bin
```

## VM

### Run VM
1. 最简单的命令
```bash
qemu-system-x86_64 -m 3500 -hda CentOS8-1.qcow2

# 加速
sudo kvm qemu-system-x86_64 -m 3500 -hda CentOS8-1.qcow2
```
2. efi 启动
> uefi bios需要额外下载，[下载地址](https://retrage.github.io/edk2-nightly/)
```bash

```

#### qcow2
1. 挂载qcow2
```bash
# 把镜像导出到nbd
# max_nbd=N 指定nbd管理的分区的最大个数
sudo modprobe nbd max_part=8

# 将特定的镜像导出为块设备/dev/nbd0
sudo qemu-nbd --connect=/dev/nbd0 CentOS8-1.qcow2

# 检查nbd映射的分区列表，使用fdisk
sudo fdisk /dev/nbd0 -l

# 选定挂载点，挂载nbd（比如/dev/nbd0）
sudo mount /dev/nbd0p1 qcow2_mount_point

# 完成了操作，则可以卸载它，并断开磁盘镜像，就像下面这样
sudo umount qcow2_mount_point/
sudo qemu-nbd --disconnect /dev/nbd0 
```

2. 修改密码
1. one
```
sudo apt install libguestfs-tools 
virt-customize -a CentOS8-1.qcow2 --root-password password:maxwit
```

2. two
```bash
$ sudo apt install libguestfs-tools 
# 
$ openssl passwd -1 maxwit
$1$2qm5j0mZ$pwXZrcg9GTL2xMdc00oqU.

$ guestfish --rw -a CentOS8-1.qcow2 
# Use run or launch command to access image file system:
><fs> run
><fs> list-filesystems 
/dev/sda1: xfs
><fs> mount /dev/sda1 /
 ><fs> vi /etc/shadow
root:$1$2qm5j0mZ$pwXZrcg9GTL2xMdc00oqU.:18116:0:99999:7:::
bin:*:17834:0:99999:7:::
daemon:*:17834:0:99999:7:::
................
chrony:!!:18116::::::
><fs> sync 
><fs> quit
```

3. three
```bash
# 先将镜像挂载
$ ls qcow2_mount_point/

# 执行chroot
$ chroot qcow2_mount_point/

# 修改密码
bash-4.4# passwd 
Changing password for user root.
New password: 
Retype new password: 
passwd: all authentication tokens updated successfully.
bash-4.4# exit
exit
```

---

1. [如何使用qcow2创建虚拟机](https://www.jianshu.com/p/aa3fc4c300fe)
2. [在 Linux 上如何挂载 qcow2 磁盘镜像](https://www.jianshu.com/p/6b977c02bfb2)
3. [如何修改镜像密码](https://blog.csdn.net/jiahaojie1984/article/details/52242589)
4. [How To Customize Qcow2/Raw Linux OS disk image with virt-customize](https://computingforgeeks.com/customize-qcow2-raw-image-templates-with-virt-customize/)
5. [How to reset forgotten root password for Linux KVM qcow2 image/vm](https://www.cyberciti.biz/faq/how-to-reset-forgotten-root-password-for-linux-kvm-qcow2-image-vm/)
6. [How to Set root Password of CentOS 7 cloud image(guestfish)](https://www.linuxcnf.com/2019/11/how-to-set-root-password-of-centos-7.html)
7. [Qemu 简单使用](https://blog.csdn.net/jiangwei0512/article/details/56495296)
