#Week2 

##Directory
1. [07-21](#1)
2. [07-24](#2)
3. [07-25](#3)
4. [07-27](#4)

----------------------

###07-21<span id ="1"></span>
####1. MarkDown 
####2. Git
   [教程1](https://www.liaoxuefeng.com/wiki/896043488029600/900785521032192)
   [教程2](https://www.yiibai.com/git/git_basic_concepts.html)
####3. Linux系统架构和rootf目录图
   **系统架构图**
   ![Linux_Architecture1](https://user-images.githubusercontent.com/44200120/62094247-04bc9700-b2af-11e9-84aa-557a0b08969b.jpg)
   ![Linux_Architecture2](https://user-images.githubusercontent.com/44200120/62094251-09814b00-b2af-11e9-90ab-89463c9ed236.jpg)

   **rootfs目录树：**
   ![rootfs](https://user-images.githubusercontent.com/44200120/61969859-16cbda80-b00e-11e9-99a7-1407c40764a5.png)
####4. 虚拟地址的四个作用
####5. Understand SCM
[百度百科（软件配置管理）](https://baike.baidu.com/item/scm/2039966)

####1. Understand the differences between DB and DBMS

--------------------------

###07-24<span id="2"></span>
#### 1.SSH
* 制作钥匙
  >ssh-keygen
  >ssh-copy-id username@IP
* 远程连接
  >ssh username@IP

####2. nfs(nfs-server  mount umount)流程
流程
1. 构建nfs_service

名字不同时运用管道搜索,安装nfs服务
   >sudo apt install nfs-kernel-server

将共享目录配置
   >sudo vi /etc/exports

配置完成，重载reload
   >sudo exportfs -a

测试
   >sudo mount localhost:/opt/share /mnt
   >ls /mnt

2. 挂载，使用nfs_client
>sudo mount IP:/opt/share /mnt
------如果报错type,not know等，尝试安装nfs-common可以识别nfs系统文件类型

解决端口不同等其他问题：
   >sudo vi /etc/exports    
   >>/opt/share  *(ro,sync,no_subtree_check,insecure)

mac的mount命令：
   >>sudo mount -o resvport IP:/opt/share /mnt

--------------------------

###07-25<span id="3"></span>
####1. LDAP（轻量级目录访问协议）
[百度百科](https://baike.baidu.com/item/LDAP)

####2. TCP/IP
   [链接](https://www.lifewire.com/transmission-control-protocol-and-internet-protocol-816255)
#### 3. Mysql + shell（脚本） ==> adduser
* mysql 创建表
  [菜鸟教程](https://www.runoob.com/mysql/mysql-create-tables.html)
  [创建表](http://c.biancheng.net/cpp/html/1449.html)
* shell脚本增加用户测试
```
    for fn in `mysql -uroot -pmaxwit user_table -e 'select username from user_table' | sed '/-/d' | sed '/username/d'`
    do
        user=`echo $fn | tr 'A-Z' 'a-z'`
        echo useradd -m -c $fn -g maxwit $user
    done
```

--------------------------

###07-26<span id="4"></span>
####1. 面对对象：类、对象
####2. Bind9
   **参考资料**
   * [1](https://www.jianshu.com/p/21e71945e261)
   * [2](https://www.cnblogs.com/godjesse/p/3433265.html)
   * [3](https://www.jb51.net/article/33941.htm)
   * [*4](https://www.linuxtechi.com/install-configure-bind-9-dns-server-ubuntu-debian/)
   * [*5](https://linuxhint.com/install_bind9_ubuntu/)
   * [6](https://blog.csdn.net/colourzjs/article/details/44491479)
   * [/etc/resolv.conf](https://www.cnblogs.com/losbyday/p/5860666.html)
   * [wiki:bind9](https://wiki.debian.org/Bind9)
####3. Ceph
####4. Gitlab
   **参考资料**
   * [安装教程](https://blog.csdn.net/duyusean/article/details/80011540)
   * [镜像](https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/gitlab-ce-12.1.1-ce.0.el7.x86_64.rpm)
   * 安装中遇到错误及解决方案：
      **a. 增加vagrant虚拟机内存**
      ```
       config.vm.provider "virtualbox" do |vb|
         vb.memory = "4096"
       end

      ```

      **b. 编码错误**

      解决方案：
      >LC_ALL="en_US.UTF-8"
      >LC_CTYPE="en_US.UTF-8"

      错误信息：
      ```
      There was an error running gitlab-ctl reconfigure:

      execute[/opt/gitlab/embedded/bin/initdb -D /var/opt/gitlab/postgresql/data -E UTF8] (postgresql::enable line 80) had an error: Mixlib::ShellOut::ShellCommandFailed: Expected process to exit with [0], but received '1'
      ---- Begin output of /opt/gitlab/embedded/bin/initdb -D /var/opt/gitlab/postgresql/data -E UTF8 ----
      STDOUT: The files belonging to this database system will be owned by user "gitlab-psql".
      This user must also own the server process.
      STDERR: initdb: invalid locale settings; check LANG and LC_* environment variables
      ---- End output of /opt/gitlab/embedded/bin/initdb -D /var/opt/gitlab/postgresql/data -E UTF8 ----
      Ran /opt/gitlab/embedded/bin/initdb -D /var/opt/gitlab/postgresql/data -E UTF8 returned 1
      ```



####5. ApacheDS
