# Json

## JackJson
> spring-boot-starter-web依赖自带的json解析：jackjson-databind

## GJson
> 使用之前需要先禁用自带的jackjson-databind

**具体配置如下：**
```
<dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <exclusions>
                <exclusion>
                    <groupId>com.fasterxml.jackson.core</groupId>
                    <artifactId>jackson-databind</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <dependency>
            <groupId>com.google.code.gson</groupId>
            <artifactId>gson</artifactId>
            <version>2.8.6</version>
        </dependency>
```

## FastJson
* 具体配置如下：
```
<dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <exclusions>
                <exclusion>
                    <groupId>com.fasterxml.jackson.core</groupId>
                    <artifactId>jackson-databind</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>fastjson</artifactId>
            <version>1.2.62</version>
        </dependency>
```

* [fastjson SerializerFeature详解](https://blog.csdn.net/u010246789/article/details/52539576)
* 自定义MyFastJsonConfig之后需要配置响应编码，在application.properties加入如下:
  ```
  spring.http.encoding.force-response=true
  ```



