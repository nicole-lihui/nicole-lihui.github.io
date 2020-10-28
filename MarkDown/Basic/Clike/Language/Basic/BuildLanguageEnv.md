#语言环境搭建
- [1. C/C++](#1-cc)
- [2. Java](#2-java)
- [3. Kotlin](#3-kotlin)
- [4. JavaScript](#4-javascript)
- [TypeScript](#typescript)
  - [nvm 以及npm版本问题](#nvm-%e4%bb%a5%e5%8f%8anpm%e7%89%88%e6%9c%ac%e9%97%ae%e9%a2%98)
- [5. Swift](#5-swift)
- [6. Go](#6-go)
  - [6.1 mac](#61-mac)
- [7. Rust](#7-rust)
- [8. C](#8-c)
- [Note](#note)

## 1. C/C++ 
cling是c/c++的REPL，clang
1. MacOS
    macOS: 直接安装Xcode
    ```bash
    brew install cling
    ```
2. Ubuntu
   ```bash
    ## Cling installation:  
    curl -O https://root.cern.ch/download/cling/cling_2019-09-27_ubuntu18.tar.bz2
    tar -xjf cling_2019-09-27_ubuntu18.tar.bz2
   ```

**c++库：**
>boost:
>>1. 解压
>>2. cp -r ~/Downloads/boost_1_71_0/boost /usr/local/include


Linux: 常规安装
* Note:
  >1. c for `C`
  >2. cc/cpp/cxx for `C++`

## 2. Java
* PM：
```bash
$ brew cask install java11
```
* 利用sdk工具安装[^1]
[^1]:sdk仅适用于安装jvm系语言

```bash
$ curl -s "https://get.sdkman.io" | bash
$ sdk list java
$ sdk install java 11.0.4.j9-adpt
```

## 3. Kotlin
```bash
$ sdk install kotlin

```


## 4. JavaScript
运用[nvm](https://github.com/nvm-sh/nvm)安装JS

```bash
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
$ nvm install node
```
## TypeScript
mac
```bash
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
$ source $HOME/.nvm/nvm.sh
$ npm install -g typescript ts-node
```
### nvm 以及npm版本问题
> nvm是管理npm版本的工具
1. npm版本低，以及解决方案
   ```bash
    # 查看最新版本：找到绿色字体版本：v10.16.3   (Latest LTS: Dubnium)
    nvm ls-remote

    # 安装最新版本
    nvm install v10.16.3
   ```

## 5. Swift 
1. `macOS`上直接安装xcode
2. `ArchLinux`上自带包管理工具直接安装
3. `Ubuntu`上到苹果的swift官网下载
4. `其他Linux发行版`自行从源码编译（编译大约2小时，视机器性能而定）
5. `Windows`不支持


## 6. Go
用系统自带包管理工具直接安装，或到[官网](https://golang.org/dl/)
下载

### 6.1 mac
```bash
brew install go
```


## 7. Rust
*[Rust](https://www.rust-lang.org/learn/get-started)属于大c/c++系（妄想代替C/C++）*
```bash
$ curl https://sh.rustup.rs -sSf | sh
$ source $HOME/.cargo/env
```
REPL enviroment
```bash
while [ true ]; do cargo install irust && break; done
```

## 8. C#
1. `Windows/macOS`安装Visual Studio
```bash
brew install mono
```
2. `Linux`安装mono
```bash
sudo apt install -y mono-csharp-shell
```

## Note
1. Rust属于大c/c++系（妄想代替C/C++）
2. Go/Kotlin: 妄想代替Java