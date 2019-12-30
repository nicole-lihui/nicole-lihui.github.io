# P1
1. http协议（第一轮）
2. app容器
3. http与app server
4. 数据格式
5. http最佳实践

---
# http

## Method（GET/POST）
### 共同点
> `GET`:
> 1. URL（地址栏）传送数据，显示参数
> 2. 有长度限制，最大限制中最小2k，（实际中有限制，理论无限制）


> `POST`： 
> 1. body传送数据， URL不显示参数
> 2. 无长度限制，无明确规定（基本无限制，相对get，理论上没有限制，服务端可配置为不限制，即使限制也足够大）


> GET、POST都是采用明文传输

### 应用场景：
>  `GET`:
> 简单的数据，数据长度不长

>`POST` : 
> 复杂数据，数据长度较长

## Content Body type

### 1. jason（key value形式）
1. jason for request & response

### 2. form data
2. form data: for request

### 3. html
> html: for response

## Respons
### Respons Header
1. status code ： 2xx， 4xx， 5xx
    [status code](https://www.runoob.com/http/http-status-codes.html)
2. Content-type

## Request

---
## 数据结构与数据格式
### 数据结构：
>  2种相似的数据结构：
>       `map & tree`


### 数据格式：
> 3中相似的数据格式：
> `json, yaml, xml`

### 关系：（实际应用/项目中）
> 1. `map <==> json/yaml`
> 2. `tree <==> xml`

## 数据解析
**1. json（post） json.load()**
   ```python
  data = env['wsgi.input'].read(int(env['CONTENT_LENGTH'])).decode()
      
  args = json.loads(data)  
   ```
**json（get） json.loads()**
  ```python
  args = json.load(env['wsgi.input'])
  ```

  ```python
  if type == form data:
  cgi.FieldStorage()
  elif type == json:
  if method == get
      json.loads()
  else # post
      json.load()
  ```

  具体实现：
  ```python
  import json

  def application(env, start_response):
      start_response('200 OK', [('Content-Type', 'application/json')])

      args = json.load(env['wsgi.input'])
      a = args['a']
      b = args['b']

      s = {'sum': a + b}

      return [json.dumps(s).encode()]
  ```

**2. form-date (post,get) cgi.FieldStorage()**
  ```python
  form = cgi.FieldStorage()
  if "name" not in form or "addr" not in form:
      print("<H1>Error</H1>")
      print("Please fill in the name and addr fields.")
      return
  print("<p>name:", form["name"].value)
  print("<p>addr:", form["addr"].value)
  ```


---
## App Server == 容器
1. 常用的容器（Web）
   * `uwsgi`
   * `tomcat`、`WebLogic`, `WebSphere`, `Jetty`（Java EE容器）
   * `Unicorn`： Ruby容器
     * 为Ruby语言搭建的web服务器服务
     * 用ruby语言实现
     * 被GitLab采用
   * 
   
2. 

### uwsgi 
#### 1. 概念
#### 2. 使用
1. CLI简易模式
2. 配置文件、systemd service、整合http server(nginx)、集群(高可用）


### 三种传递参数方式
*  form data
*  path variable
> /user/{id}/info
* json (in body)


## Note
1. 实现form cgi.FieldStorage()解析


