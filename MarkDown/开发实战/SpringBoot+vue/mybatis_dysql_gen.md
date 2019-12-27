# Spring + Mybatis + Mybatis Dyd

## attention
* spring 配置文件
![配置文件1](http://nicole-lihui.github.io/MarkDown/开发实战/SpringBoot+vue/properties1.png)
![配置文件2](http://nicole-lihui.github.io/MarkDown/开发实战/SpringBoot+vue/properties2.png)

> $ mvn -Ptest test
> -Ptest (环境) test（单元测试）

## Demo
1. build
```bash
$ spring init -d=web,mybatis --package-name com.maxwit mybatisDsqlGenDemo
```
2. config
* generatorConfig.xml
```xml
<!DOCTYPE generatorConfiguration PUBLIC
        "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
<generatorConfiguration>
    <context id="DB2Tables" targetRuntime="MyBatis3DynamicSql">
        <jdbcConnection driverClass="org.mariadb.jdbc.Driver"
                        connectionURL="jdbc:mariadb://localhost/ooda_db"
                        userId="test"
                        password="maxwit">
        </jdbcConnection>

        <javaModelGenerator targetPackage="com.maxwit.model" targetProject="src/main/java"/>

        <javaClientGenerator targetPackage="com.maxwit.mapper" targetProject="src/main/java"/>

        <table tableName="user" />
    </context>
</generatorConfiguration>
```

* pom.xml
```xml
	<dependencies>
        <!-- ... -->

		<dependency>
			<groupId>org.mariadb.jdbc</groupId>
			<artifactId>mariadb-java-client</artifactId>
			<version>2.5.2</version>
		</dependency>

		<dependency>
			<groupId>org.mybatis.generator</groupId>
			<artifactId>mybatis-generator-maven-plugin</artifactId>
			<version>1.4.0</version>
		</dependency>

        <dependency>
			<groupId>org.mybatis.dynamic-sql</groupId>
			<artifactId>mybatis-dynamic-sql</artifactId>
			<version>1.1.4</version>
		</dependency>

	</dependencies>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>

			<plugin>
				<groupId>org.mybatis.generator</groupId>
				<artifactId>mybatis-generator-maven-plugin</artifactId>
				<version>1.4.0</version>
				<configuration>
					<overwrite>true</overwrite>
				</configuration>

				<dependencies>
					<dependency>
						<groupId>org.mariadb.jdbc</groupId>
						<artifactId>mariadb-java-client</artifactId>
						<version>2.5.2</version>
					</dependency>
				</dependencies>
			</plugin>
		</plugins>
	</build>
```

* application.properties
```
spring.datasource.url=jdbc:mariadb://localhost/ooda_db
spring.datasource.driver-class-name=org.mariadb.jdbc.Driver
spring.datasource.username=test
spring.datasource.password=maxwit
```

3. run
```bash
mvn mybatis-generator:generate
```

