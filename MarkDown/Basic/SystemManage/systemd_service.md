# systemd service

## basic
1. 首先创建user(每个进程都有个user，service需要合理的user)
   ```bash
    sudo useradd -m -d /var/lib/ooda -s /sbin/nologin ooda
    # 注意nologin
    # 可以加-r, system user
   ```
2. 初始化
   ```bash
    sudo -u ooda cp -v /tmp/course*.db /var/lib/ooda/
   ```

3. 实例练习
   [deployment-systemd-service](https://docs.spring.io/spring-boot/docs/current/reference/html/deployment.html#deployment-systemd-service)

   根据上面的步骤，创建service文件如下：
   ```xml
    [Unit]
    Description=Course
    After=syslog.target

    [Service]
    User=ooda
    ExecStart=/var/lib/ooda/course.jar
    SuccessExitStatus=143

    [Install]
    WantedBy=multi-user.target
   ```
