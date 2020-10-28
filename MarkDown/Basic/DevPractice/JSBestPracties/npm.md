# npm

## 入门Demo
### npm 启动服务
#### 第一阶段：
```bash
npm init -y
cnpm install --save-dev serve
echo '<h1>MaxWit</h1>' > index.html
node node_modules/_serve@11.3.2@serve/bin/serve.js
```
#### 第二阶段
> 简化 node启动命令：`node node_modules/_serve@11.3.2@serve/bin/serve.js`
```bash
$ cat package.json
{
  "name": "start-server-demo",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "serve":"serve",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "serve": "^11.3.2"
  }
}
$ npm run serve
```
**Notes**
* npm script 会自动识别node node_modules/.bin的文件，package.json文件可以省略路径
* npm install 依赖的时，会进行一系列处理，如node_modules/.bin下的文件都是软链接，链接到实际的脚本。

**参考文档**
* [npm中script脚本的使用](https://www.jianshu.com/p/628d84425e4a)
