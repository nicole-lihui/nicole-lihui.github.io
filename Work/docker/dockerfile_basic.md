# DockerFile

## RUN，CMD，ENTRYPOINT命令区别
* RUN命令执行命令并创建新的`镜像层`，通常用于`安装软件包`
* CMD命令设置容器`启动后默认执行的命令及其参数`，`但CMD设置的命令能够被docker run命令后面的命令行参数替换`
* ENTRYPOINT配置容器`启动`时的执行命令`（不会被忽略，一定会被执行，即使运行 docker run时指定了其他命令）`

