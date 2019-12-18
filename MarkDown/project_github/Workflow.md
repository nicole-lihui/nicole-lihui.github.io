我们情况比较复杂，下面的workflow是基于[Github Workflow](https://guides.github.com/introduction/flow/)的改进。本文操作示例基于C-like repo。有任何疑问欢迎跟帖！

### Pick an issue

- 找到自己的Kanban，选择To Do列表中的最高优先级的任务（与Buddy沟通相关细节）。
- 打开对应的issue页面，了解该issue的详细描述（与QA沟通相关细节）。

若对issue本身有疑问，可以在issue页面讨论沟通（可以@）。

### Create a branch
首先，clone相关repo（若已经clone请略过），比如：
```
$ git clone git@github.com:maxwit-course/c-like.git
```

然后，基于master创建一个名为"N-github-account"的local branch（其中“N”为issue number，"github-account"为你的github账户名），

**新的 issue branch的命名规则：**
> "#-<issue-short-desc>"，比如"1-cunit-demo"，而不是"1-conke"。悉知


比如：
```bash
$ git checkout master # when current branch is NOT master
$ git checkout -b 1-junit-demo
```

### First commit
新建一个文件或打开一个已存在的文件（视情况而定），加入一行注释，然后直接commit（后续操作可以squash掉本次commit）：
```bash
$ git status
$ ...
$ git commit -as
```

输入正确的commit message，保存退出。message参考示例：
```
1 JUnit demo
2
3 Resolve #1
```


注意格式和规范：第1行参考issue title做简要描述，写完空一行，然后写“Closes #N”(N为issue number)。
:sassy_woman: “Resolve”一行要求非常严格，不能错一个字符，否则系统无法识别

### Open a draft PR
首先，创建远程分支（注意输出信息）：
```bash
$ git push -u origin 1-junit-demo  # tips: tab completion
```
然后，点击输出信息中的URL，打开github PR页面。下面是PR页面操作要点：
1. 选择[draft PR](https://github.blog/2019-02-14-introducing-draft-pull-requests/)。系统默认是普通PR，而不是draft PR，请注意不要选错。
1. 选择所属的Project。
1. 选择2名同学设置为Reviewers，其中一人为buddy，另一人任选（Bonnie/Conke同学除外）。
1. Assignees暂时不用设置

:sassy_woman:  此时Kanban上PR的状态被自动设置为"In progress"

### Discuss and add more commits

创建完draft PR以后任何人可以轻松几乎所有问题了——如果你对任何一步有问题，都可以在PR页面提问，往往会有人给你答案！

讨论期间，可能需要多次commit & push，一般情况下，从第二次commit开始，每次commit之前需要reset上一次commit甚至前几次commit，然后再把多次改动一起commit和push (即所谓的squash)，具体做法如下：

首先，reset上一次的commit：
```bash
$ git reset HEAD^ 
$ git status
```
然后，上一次的改动将和本次改动一起commit：
```
$ git commit -as
$ git push -f
```
注意：每次执行 reset HEAD^ 以后本地仓库的commit记录比远程少一次，所以需要强制push，覆盖远程的commit记录。

### Review
点击"Ready for review"即可。

### Merge
2个review都approve后，在PR页面上设置Assignees，目前为Bonnie或Conke同学。

### Finish
如果一切顺利的话，Kanban上当前PR的状态会依次变为：Review in progress > Review approved > Done。当PR为Done时，相关issue的状态也会自动变为Done(Closed)。

最后别忘了删除本地对应的issue branch：
```
$ git checkout master
$ git branch -d 11-conke
```
