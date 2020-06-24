# Webpack

## Getting Start
### Install and Create Project
```bash
$ mkdir webpack-demo & cd webpack-demo
$ npm init -y
$ npm install webpack webpack-cli --save-dev
```
**Project**
```bash
  webpack-demo
  |- package.json
  |- webpack.config.js
  |- /dist
    |- index.html
  |- /src
    |- index.js
```
**index.html**
```html
  <!doctype html>
  <html>
   <head>
     <title>Getting Started</title>
   </head>
   <body>
     <script src="main.js"></script>
   </body>
  </html>
```
**index.js**
```js
function component() {
  const element = document.createElement('div');
  element.innerHTML ="Hello webpack";

  return element;
}

document.body.appendChild(component());
```

**package.json**
```json
{
    "name": "webpack-demo",
    "version": "1.0.0",
    "description": "",
+   "private": true,
-   "main": "index.js",
    "scripts": {
      "test": "echo \"Error: no test specified\" && exit 1"
    },
    "keywords": [],
    "author": "",
    "license": "ISC",
    "devDependencies": {
      "webpack": "^4.20.2",
      "webpack-cli": "^3.1.2"
    },
    "dependencies": {}
  }
```
* `+   "private": true`
    `-   "main": "index.js"`

确保我们将包标记为**私有**，并删除`main` 入口, 这是为了**防止意外发布**您的代码。

**webpack.config.js**
```js
const path = require('path');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist'),
  },
};
```
### Pack
```bash
$ npx webpack
```
### Run
```bash
# install 
$ npm i webpack-dev-server --save-dev

# run
$ npx webpack-dev-server --open
```
### 参考文档
* [webpack官网](https://webpack.js.org/guides/getting-started/)
* [basic教程](https://www.valentinog.com/blog/webpack/)

## Proxy
### Demo
```bash
# install 
$ npm i webpack-dev-server --save-dev

# webpack.config.js
$ cat webpack.config.js
const path = require('path');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist'),
  },
  devServer: {
    proxy: {
      "/api": {
        target: "http://localhost:8080",
        pathRewrite: {"^/api" : ""}
      }
    }
  }
};

# index.js
$ cat index.js
import axios from 'axios'

function component() {
    const element = document.createElement('div');

    axios.get('/api/user').then(function (response) {
        console.log(response.data);
    }).catch(function (error) {
        console.log(error);
    });

    element.innerHTML ="Hello Webpack";
    return element;
}
document.body.appendChild(component());

# run
$ npx webpack-dev-server --open
```
### 参考文档
* [Webpack DevServer -- Proxy](https://webpack.js.org/configuration/dev-server/#devserverproxy)
* [Axios](http://axios-js.com/docs/)
