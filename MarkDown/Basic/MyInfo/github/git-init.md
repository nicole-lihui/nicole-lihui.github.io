# git init

```bash
echo "# Psychological-counseling" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/Orchid-phy/Psychological-counseling.git
git push -u origin master
```               

* echo "# Psychological-counseling" >> README.md
> 新建README.mq 文件，将`# Psychological-counseling`写入

* git init
> 初始化git项目

* git add README.md
> git 加入 README.md 文件（这一步也不是很清晰，大概是这个意思）

* git commit -m "first commit"
> 提交的log信息

* git remote add origin https://github.com/Orchid-phy/Psychological-counseling.git
> git项目中配置远程项目的地址，后面推送的地址就是这个

* git push -u origin master
> 新建master远程分支，推送项目
> （只有第一次需要这么推送）第二次以后直接 ` git push`
