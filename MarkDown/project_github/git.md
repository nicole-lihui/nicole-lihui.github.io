# Git、Gtihub、Gitee

## Git Script
### Git URL Update
```bash
for repo in *; do test -d $repo/.git || continue; cd $repo; echo $repo; git remote set-url origin git@github.com:wit-course/$repo.git; git config --list | grep origin.url; cd ..;  done
```
------

## Issue
### Issue 提交规范
1. Describe the bug（描述）
2. To Reproduce（复现步骤）
3. Expected behavior（期待结果）
4. Desktop (please complete the following information)（环境）

### Issue 类型 Label

### Issue fork
作用：有利于溯源

