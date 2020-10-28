## shell脚本
> 代码需要拆分源文件，在贴代码的时候多文件复制黏贴以及调整格式会比较麻烦，所以可以用一个shell脚本帮我们去做
### macOS (Java为例)
```bash
for f in *.java; do echo "// $f"; cat $f; echo; done | pbcopy
```
```bash
for f in *.js tsconfig.json; do echo "// $f"; cat $f; echo; done | pbcopy
```

### macOS (Java为例)
```bash
for f in *.java; do echo "// $f"; cat $f; echo; done | clip
```

### Linux （C/C++为例）
```bash
for f in *.h *.cc; do echo "// $f"; cat $f; echo; done | xclip -sel clip
```
```bash
for f in *.ts tsconfig.json; do echo "// $f"; cat $f; echo; done | xclip -sel clip
```
