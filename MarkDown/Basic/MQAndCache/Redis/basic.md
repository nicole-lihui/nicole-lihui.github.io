## Redis
### Install and basic test
1. CentOS8
   * [Install and Configure Redis on CentOS 7](https://www.linode.com/docs/databases/redis/install-and-configure-redis-on-centos-7/)
   * [How to Install and Configure Redis on CentOS 7](https://linuxize.com/post/how-to-install-and-configure-redis-on-centos-7/)
   * [How to Install Redis Server on CentOS 8 / RHEL 8](https://www.linuxtechi.com/install-redis-server-on-centos-8-rhel-8/)
    ```bash
    $ sudo yum -y install epel-release
    $ sudo yum update
    $ sudo yum install -y redis
    $ sudo systemctl start redis
    $ redis-cli
    ```
2. [ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04)
   1. install
   ```bash
   $ sudo apt install -y redis-server
   ```
   1. Testing
   ```bash
    $ systemctl status redis

    # connect to the server and test
    $ redis-cli
     > ping
    PONG
     > set test "Redis is working"
    OK
     > get test
    "Redis is working"
     > exit

    # Redis is able to persist data even after it’s been stopped or restarted.
    $ sudo systemctl restart redis
    $ redis-cli 
     > get test
    "Redis is working"
   ```
3. MacOS
   * [Install Redis on Windows and Mac](https://www.devglan.com/blog/install-redis-windows-and-mac)
   * [How to install Redis on macOS using Homebrew](https://www.code2bits.com/how-to-install-redis-on-macos-using-homebrew/)
   * [MacOS 安装 Redis](http://www.voidcn.com/article/p-bprtwnbq-bwt.html)
   ```bash
    # 安装包安装
    $ mkdir redis && cd redis
    $ curl -O http://download.redis.io/redis-stable.tar.gz
    $ tar xzvf redis-stable.tar.gz
    $ cd redis-stable
    $ make
    $ make test
    $ sudo make install
    $ redis-cli
    # 如果出现启动redis报错127.0.0.1:6379: Connection refused
    
    # 在解压文件中找到redis.config，将其中修改 "daemonize no" 为 "daemonize yes"
    $ vi redis.conf
    # 之后在服务器启动后，打开客户端
    $ redis-server redis.conf


    # homebrew 安装
    $ brew update             # Fetch latest version of homebrew and formula.
    $ brew search redis       # Searches for formula called redis
    $ brew info redis         # Displays information about redis
    $ brew install redis      # Install the redis formulae.
    $ brew cleanup            # Remove any older versions of any formula
   ```
### Basic usage
#### Redis常用命令
* [Redis笔记（三）：Redis常用命令](https://cloud.tencent.com/developer/article/1448260)
* [Redis 常用操作命令，非常详细！](https://zhuanlan.zhihu.com/p/47692277)
1. 基本命令
```bash
# 启动Redis, 6379是Redis默认端口号
> redis-server [--port 6379]
# 如果命令参数过多，建议通过配置文件来启动Redis
> redis-server [xx/xx/redis.conf]


# 连接Redis
> redis-cli [-h 127.0.0.1 -p 6379]


# 停止Redis, 以下两条停止Redis命令效果一样
> redis-cli shutdown
> kill redis-pid


# 发送命令 (给Redis发送命令有两种方式：)
# 1. redis-cli带参数运行
> redis-cli shutdown
# 2. redis-cli不带参数运行
> redis-cli
127.0.0.1:6379> shutdown
not connected>

# 测试连通性
127.0.0.1:6379> ping
PONG
```
2. 基本key命令
```bash
# 查询所有key对象
127.0.0.1:6379> keys *

# 查询匹配key对象
127.0.0.1:6379> keys a*
1) "a"
2) "age"

# 删除某个key
127.0.0.1:6379> del age


# 获取key总数 
127.0.0.1:6379> dbsize
(integer) 4


# 检查key是否存在
127.0.0.1:6379> exists a name
(integer) 2


# 更改key名
127.0.0.1:6379[2]> rename javastack javastack123
OK


# 查询键类型
# 语法： type key
127.0.0.1:6379> type javastack
string

# 移动键
# 语法：move key db
# 如把javastack移到2号数据库。
127.0.0.1:6379> move javastack 2
(integer) 1
127.0.0.1:6379> select 2
OK
127.0.0.1:6379[2]> keys *
1) "javastack"
```

#### Redis5种数据类型的简单使用
* [Redis支持5种数据类型](https://redis.io/topics/data-types-intro)
1. String
```bash
$ redis-cli
 > set name "Nicole"
OK
 > get name
"Nicole"
 > type name
string

 > mset a 10 b 20 c 30
OK
 > mget a b
1) "10"
2) "20"
 > mget a b c
1) "10"
2) "20"
3) "30"
```
2. List
```bash
 > lpush ulist redis
(integer) 1
 > lpush ulist nicole tom u1 u2
(integer) 5
 > lrange ulist 0 4
1) "u2"
2) "u1"
3) "tom"
4) "nicole"
5) "redis"

 > rpush ulist u3 u4
(integer) 7
 > lrange ulist 0 -1
1) "u2"
2) "u1"
3) "tom"
4) "nicole"
5) "redis"
6) "u3"
7) "u4"

 > rpop ulist
"u4"
 > lrange ulist 0 -1
1) "u2"
2) "u1"
3) "tom"
4) "nicole"
5) "redis"
6) "u3"
 > lpop ulist
"u2"
 > lrange ulist 0 -1
1) "u1"
2) "tom"
3) "nicole"
4) "redis"
5) "u3"
 > llen ulist
(integer) 5
```
3. Hashes
```bash
 > hset nicole name nicole
(integer) 1
 > hget nicole name
"nicole"

 > hmset nicole age 22 birth 9.14
OK
 > hgetall nicole
1) "name"
2) "nicole"
3) "age"
4) "22"
5) "birth"
6) "9.14"
 > hmget nicole name age birth
1) "nicole"
2) "22"
3) "9.14"
```
4. Sets
```bash
 > sadd namels nicole tom bob
(integer) 3
 > smembers namels
1) "bob"
2) "tom"
3) "nicole"
 > sismember namels nicole
(integer) 1
 > sadd namels nicole
(integer) 0
 > sismember namels nicole
(integer) 1
 > sismember namels nick
(integer) 0
 > smembers namels
1) "bob"
2) "tom"
3) "nicole"
 > spop namels
"tom"
 > smembers namels
1) "bob"
2) "nicole"
```
5. Sorted sets
```bash
 > zadd grade 99 nicole
(integer) 1
 > zrange grade 0 -1
1) "nicole"
 > zadd grade 99 tom 80 bob
(integer) 2
 > zrange grade 0 -1
1) "bob"
2) "nicole"
3) "tom"
 > zadd grade 99 nick
(integer) 1
 > zrange grade 0 -1
1) "bob"
2) "nick"
3) "nicole"
4) "tom"
 > zadd grade 99 anna
(integer) 1
 > zrange grade 0 -1
1) "bob"
2) "anna"
3) "nick"
4) "nicole"
5) "tom"
 > zadd grade 60 nini
(integer) 1
 > zrange grade 0 -1
1) "nini"
2) "bob"
3) "anna"
4) "nick"
5) "nicole"
6) "tom"
 > zrevrange grade 0 -1
1) "tom"
2) "nicole"
3) "nick"
4) "anna"
5) "bob"
6) "nini"
 > zrange grade 0 -1 withscores
 1) "nini"
 2) "60"
 3) "bob"
 4) "80"
 5) "anna"
 6) "99"
 7) "nick"
 8) "99"
 9) "nicole"
10) "99"
11) "tom"
12) "99"
```
