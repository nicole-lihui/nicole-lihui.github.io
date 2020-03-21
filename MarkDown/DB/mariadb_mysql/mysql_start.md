# Start

## Install
```bash
# centos
yum install mariadb-server -y
systemctl start mariadb.service
systemctl enable mariadb.service

# ubuntu

```

## Start
```bash
mysql -uroot -p
```

```SQL
-- select user
select Host,User,Password from mysql.user;

-- create remote user
create user test identified by 'maxwit';
grant all privileges on *.* to 'test'@'%'identified by 'maxwit' with grant option;
flush privileges;


-- update password of the user
update mysql.user set password=password('新密码') where User="test" and Host="localhost";
-- delete user 
delete from user where User='test' and Host='localhost';
```

> mariadb 远程连接默认是关闭的需要额外配置
```bash
# centos 8
vi /etc/my.cnf.d/mariadb.server
# add some config
bind-address = 0.0.0.0


# ubuntu
```
