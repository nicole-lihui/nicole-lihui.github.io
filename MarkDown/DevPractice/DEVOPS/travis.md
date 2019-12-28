# Travis

### 教程
[从GitHub到Travis](https://www.jianshu.com/p/c80b37f775a0)
[Building a Java project](https://docs.travis-ci.com/user/languages/java/)
[使用Travis进行持续集成](https://www.liaoxuefeng.com/article/1083103562955136)

### .travis.yml
```yml
language:
  java

jdk:
  - openjdk11

install:
  mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V
  
script:
  mvn test -B
```

