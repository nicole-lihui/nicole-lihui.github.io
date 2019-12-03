- [1. User and Group](#1-user-and-group)
  - [1.1. change group](#11-change-group)
  - [1.2. Default shell (login shell)](#12-default-shell-login-shell)
  - [1.3. CLI: Linux vs BSD](#13-cli-linux-vs-bsd)
- [2. Block device and file system](#2-block-device-and-file-system)
  - [2.1. block device info](#21-block-device-info)
    - [2.1.1. mount](#211-mount)
- [3. Test](#3-test)


# 1. User and Group

## 1.1. change group

FreeBSD

```bash
pw group mod group_name -m user_name
```

## 1.2. Default shell (login shell)

- Unix-like通用方式

```bash
chsh -s /usr/bin/zsh $USER
```
- Linux特有方式

```bash
usermod -s /usr/bin/zsh $USER
```
- macOS/FreeBSD特有方式

```bash
chpass -s /usr/bin/zsh $USER
```

## 1.3. CLI: Linux vs BSD

No.|Function|Linux|BSD|Comments
---|--------|-----|-------|--------
1|add/del user(s)|useradd<br/>userdel|adduser<br/>(?)|what about macOS?
1|change user info|usermod|chpass|
1|ls with color|ls --color|export CLICOLOR=1|


# 2. Block device and file system

## 2.1. block device info

_Windows_

_Linux_
```
fdisk
blkid
```

_macOS_
```
diskutil
```

_FreeBSD_

### 2.1.1. mount

_Windows_



_Linux_

_macOS_
```bash
diskutil
```
# 3. Test
