# python String

## Some operations

### Use
```python
>>> s = "Hello, MaxWiters!"
>>> s.
s.capitalize(    s.isalpha(       s.ljust(         s.split(
s.casefold(      s.isascii(       s.lower(         s.splitlines(
s.center(        s.isdecimal(     s.lstrip(        s.startswith(
s.count(         s.isdigit(       s.maketrans(     s.strip(
s.encode(        s.isidentifier(  s.partition(     s.swapcase(
s.endswith(      s.islower(       s.replace(       s.title(
s.expandtabs(    s.isnumeric(     s.rfind(         s.translate(
s.find(          s.isprintable(   s.rindex(        s.upper(
s.format(        s.isspace(       s.rjust(         s.zfill(
s.format_map(    s.istitle(       s.rpartition(
s.index(         s.isupper(       s.rsplit(
s.isalnum(       s.join(          s.rstrip(
```
1. split
   ```python
    >>> s = "Hello, MaxWiters!"
    >>> s.split(',')
    ['Hello', ' MaxWiters!']
   ```
2. join
   用字符串s分隔join内的数组
   ```python
    >>> s.join(["11", "22", "33"])
    '11Hello, MaxWiters!22Hello, MaxWiters!33'
    >>> s.join(["11", "22", "33","44"])
    '11Hello, MaxWiters!22Hello, MaxWiters!33Hello, MaxWiters!44'
    >>>
   ```
3. find
   ```python
    >>> s
    'Hello, MaxWiters!'
    >>> s.find('Max')
    7
   ```
4. replace
   ```python
    >>> s = 'Hello, MaxWiters!'
    >>> s.replace("MaxWiters", "Conke")
    'Hello, Conke!'
   ```
5. strip
   去除首尾空格
   ```python
    >>> s = 'Hello, MaxWiters!'
    >>> s
    'Hello, MaxWiters!'
    >>> s.strip()
    'Hello, MaxWiters!'
   ```
6. lstrip/rstrip
   ```python
    >>> s = ' Hello, Max  Witers!  '
    >>> s.lstrip()
    'Hello, Max  Witers!  '
    >>> s
    ' Hello, Max  Witers!  '
    >>> s.rstrip()
    ' Hello, Max  Witers!'
   ```
7. capitalize
   首字母大写
   ```python
    >>> s = 'hello, max, nicole!'
    >>> s.capitalize()
    'Hello, max, nicole!'
   ```
8. title
   所有单词首字母大写
   ```python
    >>> s
    'hello, max, nicole!'
    >>> s.title()
    'Hello, Max, Nicole!'
   ```
## Regular expression
>imort re （正则表达式的库）
```
+ : 匹配多个
. : 匹配任意
* : 匹配多个，需要和'.'一起搭配使用
\d : 数字
\w : 单词+数字+'_' 
{2} : 固定匹配个数
$ : 以...结尾
^ : 以...开头
```
1. search
   任意位置匹配
    ```python
    >>> import re
    >>> s = '11aa22bb33cc44dd'
    >>> re.search('[a-z]+',s)
    <re.Match object; span=(2, 4), match='aa'>
    >>> re.search('[a-z].*',s)
    <re.Match object; span=(2, 16), match='aa22bb33cc44dd'>
    >>> re.search('[a-z].*[0-9]',s)
    <re.Match object; span=(2, 14), match='aa22bb33cc44'>
    >>> re.search('[a-z].*?[0-9]',s)
    <re.Match object; span=(2, 5), match='aa2'>
    ```
2. findall
    ```python
    re.findall('[a-z]+', s)
    ['aa', 'bb', 'cc', 'dd']
    ```
3. match
   从头部位置匹配
   ```python
    >>> s = '11aa22bb33cc'
    >>> re.match('[a-z]+', s)
    >>> re.match('\d+', s)
    <re.Match object; span=(0, 2), match='11'>

    >>> s = '11aa22bb33cc'
    >>> re.match(r'\d{2}[a-z]{2}\d{2}[a-z]{2}\d{2}', s)
    <re.Match object; span=(0, 10), match='11aa22bb33'>

    # 完全匹配，从头到尾
    >>> re.match(r'\d{2}[a-z]{2}\d{2}[a-z]{2}\d{2}[a-z]{2}$', s)
    <re.Match object; span=(0, 12), match='11aa22bb33cc'>
   ```
4. sub
   替换
   ^ : 非，除了的意思
   '[^|]', '-', header : 除了符号`|`，其他都替换称`-`
   
   ```python
    >>> header = 'No. | Output | Format | Result'
    >>> header += '\n' + re.sub('[^|]', '-', header)
    >>> header
    'No. | Output | Format | Result\n----|--------|--------|-------'
    >>> print(header)
    No. | Output | Format | Result
    ----|--------|--------|-------
   ```
### Pattern Group
> group我们还在vim里见识过：形如`\( \)`， 用`\1`取值

> `r.group(1)` `r.group(1)` 类似vim替换的`\1` `\2`
```python
>>> r = re.match(r"([a-z]+)-(\d+)", "aaa-111-ccc")
>>> r.group()
'aaa-111'
>>> r.group(1)
'aaa'
>>> r.group(2)
'111'
```

