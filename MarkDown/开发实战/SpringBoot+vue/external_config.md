# Extranal Config

## config
1. spring 配置文件
![配置文件1](http://nicole-lihui.github.io/MarkDown/开发实战/SpringBoot+vue/properties1.png)
![配置文件2](http://nicole-lihui.github.io/MarkDown/开发实战/SpringBoot+vue/properties2.png)

> $ mvn -Ptest test
> -Ptest (环境) test（单元测试）

2. 外部配置文件
[参考文档](https://docs.spring.io/autorepo/docs/spring-boot/1.2.0.M2/reference/html/boot-features-external-config.html)

* application.properties
> add value

* CLI
```
$ spring init demo
$ mkdir -p ~/env
$ mv src/main/resources/application.properties ~/env
$ mvn test # fail
$ mvn -Dspring.config.location=$HOME/env test # OK
```

* System.getProperties()
```Java
public class App {
    public static void main(String[] args) {
        System.out.println(System.getProperties().getProperty("foo"));
    }
}
```

> foo是个Java环境变量（不是OS环境变量）
通过命令行-Dfoo=xxx传入

```bash
$ javac App.java
$ java -Dfoo="123" App
```

```bash
# 1. CLI
java app.jar --spring.config.location=/path/to/env/

# 2 java虚拟机环境变量
java -Dspring.config.location=/path/to/env/ app.jar

# 3 系统环境变量
export SPRING_CONFIG_LOCATION=/path/to/env
java -jar app.jar
```
![tupian](http://nicole-lihui.github.io/MarkDown/开发实战/SpringBoot+vue/external_config.png)
