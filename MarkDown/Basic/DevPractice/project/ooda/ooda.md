# OODA

## 需求与实现
1. Applay course
   * 用户申请课程，ooda系统分配课程并且在响应的组织创建repo
   * 实现：
    1. 用户发起申请课程的请求
    2. ooda系统调用相应模块（github的创建repo的api）创建repo，并且将repo信息、课程信息和用户信息的相应关系存入数据库，
    3. 课程数据返回给用户
2. 

## 项目经验
### 1. Applay course
1. Unit Test
   1. 要支持kotlin（Kotlin）
      * Kotlin语言本身设计比java好， 但是业务逻辑和核心代码还是使用java（java语言比较成熟）
2. 异常处理
   1. 非代码级别异常，传统意义上的异常（比如说网络）
      * retry
        * network busy (slow) （可以不停重发）【网络异常等待时间用处不大，请求次数可能更加重要（时间和次数都有度）】
        * service busy  （不停重发，只会增加服务异常【负载均衡】，可以制定超时限制，在时间范围内去重试【服务级别：秒、系统级别：毫秒】）
   2. 

3. Sercurity（验证方式）
   * cookie + session (login)
   * API => Authorization (Token)
     * Authorization 相当于Token，API访问在头部加上Authorization实现身份验证



## emq
1. start webhook
2. config webhook

## rabbitmq
1. add user
```bash
$ rabbitmqctl add_user wit maxwit
$ rabbitmqctl set_user_tags wit administrator
$ rabbitmqctl set_permissions -p "/" wit ".*" ".*" ".*"
```
2. 开启admin GUI界面
```bash
# enable web console
$ rabbitmq-plugins enable rabbitmq_management
```
3. add exchange : amq-xlab
4. add queue : xlab-queue


## redis 
1. 开启远程登录
```bash
# 修改Redis配置文件/etc/redis/redis.conf，找到bind那行配置：
$ vim /etc/redis/redis.conf
# 注释掉 bind 127.0.0.1
# 修改 protected-mode no

# 在redis3.2之后，redis增加了protected-mode，默认开启，需要关闭
```
