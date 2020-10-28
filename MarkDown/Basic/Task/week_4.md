#Week4


##Directory
1. [07-29](#1)
2. [07-30](#2)
3. [07-31](#3)
4. [08-01](#4)

###ApacheDS

###OpenLDAP
#### 1. 安装 OpenLDAP (Ubuntu 基本命令)
* 命令安装 sladp ldap-utils
    ```shell
    apt install slapd ldap-utils
    ```
* Test:
    ```
    ldapsearch -D cn=admin,dc=nodomain -b dc=nodomain -W
    ```
    `nodomain`是默认的dn
    `-D` 是Bind_DN
    `-b` 是搜索的top

* [参考：（不要修改/etc/ldap/ldap.conf文件）](https://www.howtoforge.com/how-to-install-openldap-server-on-debian-and-ubuntu)
  

#### 2. 安装 OpenLDAP (CenterOS 基本命令)

###Kerberos
1. SSSD
   * 一个守护进程，该进程可以用来访问多种验证服务器，如LDAP，Kerberos等，并提供授权。SSSD是 介于本地用户和数据存储之间的进程，本地客户端首先连接SSSD，再由SSSD联系外部资源提供者(一台远程服务器)
   * 
2. SSO

