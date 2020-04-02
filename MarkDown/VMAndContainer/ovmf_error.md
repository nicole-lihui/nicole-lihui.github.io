# UEFI 启动 VM

## Question
1. efi 启动 uefi bios需要额外下载，[下载地址](https://retrage.github.io/edk2-nightly/)
> 下载平台的各种版本，我对这些的概念有些模糊。
我尝试了
RELEASEX64_OVMF.fd
RELEASEX64_OVMF_CODE.fd
RELEASEAARCH64_QEMU_EFI.fd
都有不同的错误。
（该镜像不用UEFI启动已经成功）

```bash
# 能够启动的命令
$ sudo kvm -m 2048 -hda CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2 

# RELEASEX64_OVMF.fd
$ sudo kvm -m 2048 -bios RELEASEX64_OVMF.fd -hda CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2 -nographic
# ERROE：
BdsDxe: failed to load Boot0001 "UEFI QEMU DVD-ROM QM00003 " from PciRoot(0x0)/Pci(0x1,0x1)/Ata(Secondary,Master,0x0): Not Found
BdsDxe: failed to load Boot0002 "UEFI QEMU HARDDISK QM00001 " from PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0): Not Found

>>Start PXE over IPv4.


# RELEASEX64_OVMF_CODE.fd
$ sudo kvm -m 2048 -bios RELEASEX64_OVMF_CODE.fd -hda CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2 -nographic
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.80000001H:ECX.svm [bit 2]
qemu: could not load PC BIOS 'RELEASEX64_OVMF_CODE.fd' 
'

# RELEASEAARCH64_QEMU_EFI.fd
$ sudo kvm -m 2048 -bios RELEASEAARCH64_QEMU_EFI.fd -hda CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2 
# ERROR: 一直加载不出来

```