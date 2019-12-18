# PM + Build
1. 编译/解析: 单文件 & 多文件
2. project build
3. 包管理

# PM

## npm
**1. nvm是管理npm的工具**
**2. cnpm是阿里开发的镜像，速度快**
1. ubuntu & macos
    ```bash
    npm install -g cnpm --registry=https://registry.npm.taobao.org
    ```


## Pip
**python**
1. pip换源
* 1. mkdir .pip
* 2. touch pip.conf
      ```bash
      [global]
      index-url = http://mirrors.aliyun.com/pypi/simple/
      [install]
      trusted-host=mirrors.aliyun.com
      ```

# compile 编译/解析: 单文件 & 多文件

## Babel
### Install
1. Ubuntu
   ```bash
   # 1
   npm install -g babel-cli
   # 2 阿里镜像
   cnpm install -g babel-cli
   ```

## maven
[官网](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)
1. **Install**
    ```bash
    sdk install maven
    ```
**maven 换源**

```bash
tee $HOME/.m2/settings.xml <<-'EOF'
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <mirrors>
    <mirror>
    <id>aliyunmaven</id>
    <mirrorOf>central</mirrorOf>
    <name>aliyun maven</name>
    <url>https://maven.aliyun.com/repository/public </url>
    </mirror>
  </mirrors>
</settings>
EOF
```

2. Testing
   1. 创建Project，执行下面命令
   ```bash
   $ mvn archetype:generate -DgroupId=com.maxwit -DartifactId=demo -DarchetypeArtifactId=maven-archetype-quickstart
   ```
    1. mvn archetype:generate这个大致理解为一个生成命令，通过后面指定的参数，创建一个项目并且初始化一些东西（有初始化配置、初始代码模版等
    2. groupId这个参数是用来指定package name
    3. artifactId用来指定project name
    4. archetypeArtifactId这个参数是指定项目类型：
    5.  maven-archetype-quickstart（普通Java Application)
  
   2. 配置文件pom.xml
```xml
  <properties>
    <maven.compiler.release>11</maven.compiler.release>
  </properties>

  <build>
    <pluginManagement>
      <plugins>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.8.1</version>
        </plugin>
      </plugins>
    </pluginManagement>
  </build>
```
   7. 编译：
    ```bash
    $ mvn compile
    ```
   8. 运行：
   ```bash
    $ mvn exec:java -Dexec.mainClass=com.maxwit.App
   ```
**初始化**
```bash
$ mvn clean
```

3. 编译/解析: 单文件 + 模块化

## gradle
1. **Gradle与Groovy之间的关系：**
    > Gradle是构建工具，是采用Groovy语言写的脚本。
2. **Groovy与Java的关系**
    > 跟kotlin与Java的关系类似
3. **补充**
    1. **Kotlin** 主用 **gradle**
    2. **Android** 之前在Java时代就主用 **gradle**
    3. **JavaEE** 最重量级框架spring全家桶也首推 gradle

### 1. Install
```bash
sdk install gradle
```
### 2. Testing
#### i. basic
1. 自己新建一个project: demo
   ```bash
    $ mkdir demo
    $ cd demo
    $ gradle init
   ```
2. 编译：
   ```bash
    $ ./gradlew build
   ```
3. 运行：
   ```bash
    $ ./gradlew run
   ```

## gulp
[gulp官网教程](https://gulpjs.com/docs/en/getting-started/quick-start)
[gulp教程](https://css-tricks.com/gulp-for-beginners/)
### Install
  ```shell
  $ npm install gulp -g
  # 国内镜像，速度快
  $ cnpm install gulp -g
  ```
### Testing1
1. build project
   ```bash
    $ mkdir XX
    $ cd XX
    $ npm init -y
   ```
2. install gulp
   ```bash
   $ npm install gulp --save-dev
   ```
3. 编辑gulpfile.js
   ```javascript
    var gulp = require('gulp');

    gulp.task('default', function(cd) {
      console.log("Hello World!");
      cd()
    });
   ```
4. 运行：
   ```bash
   $ gulp hello
   ```
### Testing2
[github-gulp-babel](https://github.com/babel/gulp-babel#babeloptions)
1. build project
2. install dependencies

```bash
$ cnpm install --save-dev gulp-babel @babel/core @babel/preset-env gulp@4.0.0
```

3. edit gulpfile.js
```js
var gulp = require('gulp');
var babel = require('gulp-babel');

gulp.task('default', () =>
  gulp.src('src/app.js')
    .pipe(babel({
      presets: ['@babel/preset-env']
    }))
    .pipe(gulp.dest('dist'))
);
```
2. edit src/app.js
```js
var a = "Maxwit"

console.log(a)
```
3. run
```bash
$ gulp
$ node dist/app.js
```

## webpack
[webpack官网](https://webpack.js.org/guides/getting-started/)
[basic教程](https://www.valentinog.com/blog/webpack/)
### Install 
  ```bash
  $ npm install webpack webpack-cli --save-dev
  ```

### Testing
1. build project
2. install webpack
   ```bash
    $ npm install webpack webpack-cli --save-dev
   ```
3. 在项目下
4. 配置package.json
```json
{
  "name": "demo1",
  "version": "1.0.0",
  "description": "",
  "main": "aa.js",
  "scripts": {
    "build": "webpack"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "webpack": "^4.41.2",
    "webpack-cli": "^3.3.9"
  }
}
```
  src/index.js


