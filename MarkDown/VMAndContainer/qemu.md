# qemu

## Install
```bash
# ubuntu
sudo apt -y install qemu-kvm qemu virt-manager virt-viewer libvirt-bin
```

## Create VM

### Run VM
```bash
sudo qemu-system-x86_64 -m 3500 -hda CentOS8-1.qcow2 --enable-kvm
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
```
sudo apt install libguestfs-tools 
virt-customize -a CentOS8-1.qcow2 --root-password password:maxwit
```

> 似乎是无效的方法
```bash
ls qcow2_mount_point/
# 执行chroot
chroot qcow2_mount_point/

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