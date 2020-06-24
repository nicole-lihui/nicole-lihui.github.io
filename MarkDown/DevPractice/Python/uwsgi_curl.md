# P1

## curl
### install

1. 发送request 传递参数
```bash
curl -d '11&22' -G http://localhost:8080
```

### Testing


## uwsgi
### install
[uwsgi](https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html)
```bash
# On a Debian-based distro an
$ sudo apt -y install build-essential python-dev

$ pip install uwsgi
```
### Testing
1. 运行自定义文件，开启服务
```bash
uwsgi --http :8080 --wsgi-file p_e.py 

# URL: http://localhost:8080/?11&22 
```
## cgi 
### parse_qs
```python
def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])

    fn = env['PATH_INFO']
    if  fn == '/':
        a = 0
        b = 0
    elif fn == '/add':
        if env['REQUEST_METHOD'] == 'GET':
            data = env['QUERY_STRING']
        else: # if POST
            data = env['wsgi.input'].read(1024).decode()
    
        args = parse_qs(data)
        a = int(args['a'][0])
        b = int(args['b'][0])
```
```python
from cgi import parse_qs

def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])

    fn = env['PATH_INFO']
    if  fn == '/':
        a = 0
        b = 0
    elif fn == '/add':
        if env['REQUEST_METHOD'] == 'GET':
            data = env['QUERY_STRING']
        else: # if POST
            data = env['wsgi.input'].read(int(env['CONTENT_LENGTH'])).decode()
    
        args = parse_qs(data)
        a = int(args['a'][0])
        b = int(args['b'][0])

    return [str(a + b).encode()]
```

```python
from cgi import parse_qs

index_page = """
<form action="add" method="get">
  <input type="text" name="a" value="0"> + <input type="text" name="b" value="0"> =
  <input type="text" name="s" value="">
  <input type="submit" value="Add">
</form>
"""

def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])

    fn = env['PATH_INFO']
    if  fn == '/':
        a = 0
        b = 0
    elif fn == '/add':
        if env['REQUEST_METHOD'] == 'GET':
            data = env['QUERY_STRING']
        else: # if POST
            data = env['wsgi.input'].read(int(env['CONTENT_LENGTH'])).decode()
    
        args = parse_qs(data)
        a = int(args['a'][0])
        b = int(args['b'][0])

    return [index_page.encode()]

```
```python
from cgi import parse_qs

index_page = """
<form action="add" method="get">
  <input type="text" name="a" value="{}"> + <input type="text" name="b" value="{}"> =
  <input type="text" name="s" value="{}">
  <input type="submit" value="Add">
</form>
"""

def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])

    fn = env['PATH_INFO']
    if  fn == '/':
        a = 0
        b = 0
    elif fn == '/add':
        if env['REQUEST_METHOD'] == 'GET':
            data = env['QUERY_STRING']
        else: # if POST
            data = env['wsgi.input'].read(int(env['CONTENT_LENGTH'])).decode()
    
        args = parse_qs(data)
        a = int(args['a'][0])
        b = int(args['b'][0])

    page = index_page.format(a, b, a + b)
    return [page.encode()]
```
