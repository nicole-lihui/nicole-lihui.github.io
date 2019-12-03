# Bash

## 去重
1. 人工检查
   ```bash
   sort /tmp/a | awk '{print $1}'
   ```
2. 自动去重
   ```bash
   sort -u /tmp/a | awk '{print $1}'
   ```
3. 增加技巧
   ```bash
   sort -u /tmp/a | awk '{print $1}' | wc -l
   ```

> 具体分析
> 1. `sort`是将文本内容每一行作为一个单位，相互比较首字符，升序输出
> 2. `-u` 删除重复内容
> 3. `awk` ：不跟参数默认是以空格或者tab为分隔符,按照文本格式分为多列。(awk '{print $1}'： 没有传入分隔符参数的情况下，awk默认以空格/tab分割，将分本分为多列)
> 4. `$1`：打印第一列
> 5. `wc` ：word count， `-l` 用来统计行数

