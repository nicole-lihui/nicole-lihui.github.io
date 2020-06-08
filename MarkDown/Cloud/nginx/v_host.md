# Virtual Host

## Config

```
server {
        <!-- 监听80端口 -->
        listen 80;
        <!-- IPV6 -->
        listen [::]:80;

        <!-- 虚拟主机域名 -->
        server_name nas.in.maxwit.com;

        <!-- 根目录路径 -->
        root /opt/nas;
        index index.html;

        <!-- 允许下载文件 -->
        location / {
                autoindex on;
        }
}
```
