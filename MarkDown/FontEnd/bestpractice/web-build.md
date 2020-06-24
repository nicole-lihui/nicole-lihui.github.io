# Build project

# 前端web项目项目打包发布
> 以Vue为例，演示前端web项目项目打包发布

## Pacakge 
```bash
## pakage and scp
$ cnpm install
$ cnpm run build
$ tar cvf dist.tar dist/*
$ scp dist.tar xx@xx.xx.xx.xx:~/web
```
## Install Nginx
### CentOS
```bash
# install nginx
$ sudo yum install -y nginx
$ sudo systemctl enable --now nginx.service
$ ls /usr/share/nginx/html
$ tar xvf ~/web/dist.tar
$ sudo cp -r ~/web/dist/* /usr/share/nginx/html/
$ sudo systemctl restart nginx
```

### Ubuntu
```bash
$ sudo apt install -y nginx
$ ls /var/www/html
$ tar xvf ~/web/dist.tar
$ sudo cp -r ~/web/dist/* /var/www/html/
$ sudo systemctl restart nginx.service
```
## nginx proxy配置
>编辑 /etc/nginx/sites-available/default 加入下面配置 （ubuntu）
```
	location /api/ {
		proxy_pass http://localhost:8080/;
	}
```
