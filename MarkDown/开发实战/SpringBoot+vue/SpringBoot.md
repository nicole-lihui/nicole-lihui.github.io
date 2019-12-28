# Spring Boot 

## basic
1. 作用
   1. 启动springmvc
   初始化springmvc（实例化controller、service...）


## Spring MVC/Spring boot
### method 1
```bash
$ sdk install springboot
$ spring init -d=web demo
# $ spring init -d=web,mybatis --package-name com.maxwit demo
$ cd demo
$ mvn spring-boot:run
```

### maven
1. pom.xml
```
  <parent>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-parent</artifactId>
      <version>2.2.0.RELEASE</version>
  </parent>
    
  <dependencies>
      <dependency>
          <groupId>org.springframework.boot</groupId>
          <artifactId>spring-boot-starter-web</artifactId>
      </dependency>
  </dependencies>
    
  <build>
      <plugins>
          <plugin>
              <groupId>org.springframework.boot</groupId>
              <artifactId>spring-boot-maven-plugin</artifactId>
          </plugin>
      </plugins>
  </build> 
```

2. testcode
```Java
package com.maxwit;


import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;

@RestController
@EnableAutoConfiguration
public class SpringBootHelloWorld {
 
    @RequestMapping("/")
    String home() {
        return "Hello World Spring Boot!";
    }
 
    public static void main(String[] args) throws Exception {
        SpringApplication.run(SpringBootHelloWorld.class, args);
    }
 
}
```
