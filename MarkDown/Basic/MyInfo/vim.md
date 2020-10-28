# Vi/Vim

## 快捷方式

---
## Table
### 配置Table（.vimrc）
在.vimrc中添加以下代码后，重启vim即可实现按TAB产生4个空格：
```bash
set ts=4  (注：ts是tabstop的缩写，设TAB宽4个空格)
set expandtab
```
### 替换Table
对于已保存的文件，可以使用下面的方法进行空格和TAB的替换：
1. TAB替换为空格：
```bash
:set ts=4
:set expandtab
:%retab!
```
2. 空格替换为TAB：
```bash
:set ts=4
:set noexpandtab
:%retab!
```

>加!是用于处理非空白字符之后的TAB，即所有的TAB，若不加!，则只处理行首的TAB。

---
## 非正常退出vi,产生swap
   * 检查swap文件
        ```
        ls -a
        ```
   * 先恢复再删除swap文件，不删除会每次打开都提示
        ```
        vi -r filename
        rm .filename.swp
        ```
   * 直接删除swap件
        ```
        rm .filename.swp
        ```

