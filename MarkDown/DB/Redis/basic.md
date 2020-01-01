## Redis
### Install and basic test
1. CentOS8
    ```bash
    $ sudo yum -y install epel-release
    $ sudo yum config-manager --set-enabled PowerTools
    $ sudo yum update
    $ sudo yum install -y redis
    $ sudo systemctl start redis
    $ redis-cli
    ```
2. (ubuntu)[https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04]
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
### Basic usage
> [Redis支持5种数据类型](https://redis.io/topics/data-types-intro)
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
