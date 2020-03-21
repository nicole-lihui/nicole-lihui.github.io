# Cookie and Session
## 理论
1. cookie存储数据在本地，session存储在服务器
2. 两者都是存储用户相关数据，cookie存储数据量有限
3. 解决了什么问题： 解决服务器对用户的识别
（http请求是无状态的。也就是说即使第一次和服务器连接后并且登录成功后，第二次请求服务器依然不能知道当前请求是哪个用户）
## 原理
1. client发起请求
2. server响应（响应数据携带一个session_id)，client将session_id存储在cookie中
3. client再次发起请求，包含session_id
