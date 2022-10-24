# Envoy Debug

## 管理端口 15000

```yaml
  /: HTML 格式的管理链接汇总
  /certs: 列出所有已加载的TLS证书，包括文件名，序列号，主题备用名称以及符合证书原型定义的 JSON格式到期的天数。
  /clusters: 列出所有已配置的集群管理器集群。此信息包括每个群集中发现的所有上游主机以及每个主机统计信息。这对于调试服务发现问题很有用。
  /config_dump: 将当前Envoy从各种组件加载出来的的配置转储为JSON进行输出。
  /contention: 如果启用了互斥跟踪，则以 JSON格式输出当前的Envoy互斥争用统计信息（MutexStats）
  /cpuprofiler: 启用或禁用CPU Profiler。需要使用gperftools进行编译。输出文件可以由admin.profile_path配置。
  /healthcheck/fail: cause the server to fail health checks
  /healthcheck/ok: cause the server to pass health checks
  /help: print out list of admin commands
  /hot_restart_version: print the hot restart compatibility version
  /listeners: print listener addresses
  /logging: query/change logging levels
  /memory: print current allocation/heap usage
  /quitquitquit: 退出服务器
  /reset_counters: reset all counters to zero
  /runtime: print runtime values
  /runtime_modify: modify runtime values
  /server_info: print server version/status information
  /stats: print server stats
  /stats/prometheus: print server stats in prometheus format

```

```bash
# Envoy 暴露了 15000 端口作为管理接口,我们可以用它来获取统计数据。看看它都提供了哪些功能：
$ kubectl -n foo exec -it -c istio-proxy httpbin-94fdb8c79-h9zrq -- curl http://localhost:15000/help


# 开启日志
curl -XPOST http://localhost:15000/logging\?level\=trace

curl -XPOST http://localhost:15000/logging\?level\=debug

# 部分修改日志级别
curl -XPOST http://localhost:15000/logging\?filter\=debug
curl -XPOST http://localhost:15000/logging\?conn_handler\=debug
curl -XPOST http://localhost:15000/logging\?connection\=debug
curl -XPOST http://localhost:15000/logging\?router\=debug
curl -XPOST http://localhost:15000/logging\?connection\=trace
```


## config dump 分析


## 参考
[istio 数据面日志调试](https://www.servicemesher.com/blog/istio-debug-with-envoy-log/)
[](https://developer.aliyun.com/article/894258)
