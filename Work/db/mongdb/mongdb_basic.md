# MongDB

## Install
### Docker
```bash
# 拉取官方的最新版本的镜像：
$ docker pull mongo:latest

# 查看镜像
$ docker images

# 运行mongdb 容器
$ docker run -itd --name mongo -p 27017:27017 mongo --auth
# 参数说明：
# -p 27017:27017 ：映射容器服务的 27017 端口到宿主机的 27017 端口。外部可以直接通过 宿主机 ip:27017 访问到 mongo 的服务。
# --auth：需要密码才能访问容器服务。

$ docker exec -it mongo mongo admin
# 创建一个名为 admin，密码为 123456 的用户。
>  db.createUser({ user:'admin',pwd:'123456',roles:[ { role:'userAdminAnyDatabase', db: 'admin'}]});
# 尝试使用上面创建的用户信息进行连接。
> db.auth('admin', '123456')
```

## Command
### Demo
```bash
# 连接MongoDB
# mongo ip:port/dbname -u 用户名 -p 密码
$ mongo localhost

# 查看所有数据库
show dbs

# 查看当前所在数据库
db

# 使用数据库
use db_name

# 删除数据库
db.dropDatabase()

# 使用集合
db.collection_name.find()  # 查所有满足条件数据
db.collection_name.findOne()  # 查满足条件的一条数据
db.collection_name.count()  # 统计集合下面有多少数量的数据

# 删除集合
db.collection_name.drop()

# 查看当前数据库状态
db.stats()

# 查看当前数据库版本
db.version()


# 备份数据库
# 导出 
mongodump --host IP --port 端口 -u 用户名 -p 密码 -d 数据库 -o 文件路径
# 导入
mongorestore --host  --port  -d  文件路径

```


---
# 参考文献
[mongodb命令行操作](https://www.jianshu.com/p/4ecde929b17d)