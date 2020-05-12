# Jedis

## Introduce


## Usage
### Maven + Jedis
* [Java中使用Jedis操作Redis(Maven导入包)、创建Redis连接池](https://www.cnblogs.com/chen-lhx/p/10430666.html)

1. 配置：pom.xml 加入依赖
```xml
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>3.3.0</version>
</dependency>
```
2. Jedis Api Usage
>同下部分代码

### SpringBoot + Jedis
* [Messaging with Redis](https://spring.io/guides/gs/messaging-redis/)
* [springboot(七).springboot整合jedis实现redis缓存](https://www.cnblogs.com/GodHeng/p/9301330.html)
* [Spring Boot 2.X(六)：Spring Boot 集成 Redis](https://yq.aliyun.com/articles/723068)

1. 配置：
<!-- pom.xml引入依赖 -->
```xml
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>3.3.0</version>
</dependency>
```

2. Jedis API Usage
```java
import org.junit.Before;
import org.junit.Test;
import org.springframework.boot.test.context.SpringBootTest;
import redis.clients.jedis.Jedis;

@SpringBootTest
public class TestJedis {
    private Jedis jedis;

    @Before
    public void setJedis() {
        jedis = new Jedis("127.0.0.1", 6379);
    }

    @Test
    public void testString() {
        jedis.set("name", "nicole");
        System.out.println(jedis.get("name"));
        jedis.append("name", " Li");
        System.out.println(jedis.get("name"));

        jedis.set("age", "22");
        System.out.println(jedis.get("age"));
        //del key
        jedis.del("age");
        System.out.println(jedis.get("age"));

        //set mul key
        jedis.mset("name", "Tom", "age", "20", "email", "222222@qq.com");
        System.out.println(jedis.get("name") + " " + jedis.get("age") + " " + jedis.get("email"));
    }
}
```
