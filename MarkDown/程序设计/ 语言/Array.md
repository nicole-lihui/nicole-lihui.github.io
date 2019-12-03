# Array

## Import
### Primitive Array (C/C++/Rust/Java/Kotlin specific)
> 作用： 效率高，访问快
```
int ar[N];
int[] ar
ar[n] = 11
```

> 高级语言普通数组都是dynamic array，没有primitive array 【例如python】


## 1. Array
数组的基本内容：数组定义、长度及元素位置、增删元素
###1.1 Define Array
1. python
   ```python
   >>> a = [11, 22, 33]
   >>> a
   [11, 22, 33]

   #define a array have size
   >>> a = [0] * 6
   >>> a
   [0, 0, 0, 0, 0, 0]
   ```

2. Swift
   ```swift
     12> var a = [11, 22, 33]
    a: [Int] = 3 values {
    [0] = 11
    [1] = 22
    [2] = 33
    }

   /*define a size array*/
    1> var a = Array(repeating:0, count:6)
   a: [Int] = 6 values {
   [0] = 0
   [1] = 0
   [2] = 0
   [3] = 0
   [4] = 0
   [5] = 0
   }
   ```

3. [Kotlin](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-array/)
   ```kotlin
    >>> var a = intArrayOf(11, 22, 33)
    >>> println(a)
    [I@4cf800ec

    //define a fixed size array
    >>> var a = IntArray(6)//define array length
   ```

4. Java
   ```java
    jshell> var a = new int[]{11, 22, 33}
    a ==> int[3] { 11, 22, 33 }

    jshell> System.out.println(a)
    [I@2dbb17c1

    //define a fixed size array
    jshell> var a = new int[6];
    a ==> int[6] { 0, 0, 0, 0, 0, 0 }
   ```

5. JavaScript
   ```javascript
    > a = [11, 22, 33]
    [ 11, 22, 33 ]

    //define a size array
    > a = new Array(6)
   [ <6 empty items> ]
   ```

###1.2 Length & Element position
1. python
   ```python
    >>> a
    [11, 22, 33]
    >>> len(a)
    3
    >>> a[-1]
    33
    >>> a[1]
    22
   ```
2. Swift
   ```swift
     1> var a = [11, 22, 33]
    a: [Int] = 3 values {
    [0] = 11
    [1] = 22
    [2] = 33
    }
     2> a.count
    $R0: Int = 3
     3> a[1]
    $R3: Int = 22
   ```
3. Kotlin
   ```kotlin
    >>> var a = intArrayOf(11, 22, 33)
    >>> a.size
    res1: kotlin.Int = 3
    >>> a[1]
    res2: kotlin.Int = 22
   ```
4. Java
   ```java
    jshell> var a = new int[]{11, 22, 33}
    a ==> int[3] { 11, 22, 33 }

    jshell> a.length
    $14 ==> 3

    jshell> a[1]
    $15 ==> 22
   ```
5. JavaScript
   ```javascript
    > a
    [ 11, 22, 33 ]
    > a.length
    3
    > a[1]
    22
   ```
   
###1.3 元素的增删(头、尾、任意)
1. python
   * Insert
   ```python
    >>> a = [11, 22, 33]
    >>> a.append(44)
    >>> a.insert(0, 55)
    >>> a
    [55, 11, 22, 33, 44]
    >>> a.insert(-1, 66)
    >>> a
    [55, 11, 22, 33, 66, 44]
    >>> a.insert(len(a), 77)
    >>> a
    [55, 11, 22, 33, 66, 44, 77]
   ```
   * Delete[^1]
    [^1]:1. pop仅仅从list中移除
    「如果pop了以后“没人接手”，那pop出来后就成了野指针，python的GC也会回收对应的memory」【GC（Garbage Collection)垃圾回收】
    del移除且删除(释放内存)
   ```python
    >>> a
    [55, 11, 22, 33, 66, 44, 77]
    >>> a.pop()
    77
    >>> a
    [55, 11, 22, 33, 66, 44]
    >>> a.pop(1)
    11
    >>> a
    [55, 22, 33, 66, 44]
    >>> del a[0]
    >>> a
    [22, 33, 66, 44]
   ```

2. Swift
增：头和任意可用a.insert(obj, at;index);尾可用a.append(obj)
删：头和任意可用a.remove(at:index);尾可用a.removeLast()
   * Insert 
   ```swift
    10> print(a)
    [11, 22, 33]
    11> a.append(44)
    12> print(a)
    [11, 22, 33, 44]
    13> a += [55]
    14> print(a)
    [11, 22, 33, 44, 55]
    14> print(a)
    [11, 22, 33, 44, 55]
    15> a.insert(66, at:0)
    16> print(a)
    [66, 11, 22, 33, 44, 55]
   ```
   * Delete
   ```swift
    16> print(a)
    [66, 11, 22, 33, 44, 55]
    17> a.remove(at:0)
    $R4: Int = 66
    18> print(a)
    [11, 22, 33, 44, 55]
    19> a.removeLast()
    $R5: Int = 55
    20> print(a)
    [11, 22, 33, 44]
   ```
3. Kotlin
   ```kotlin
   //一般数组无法直接添加数组，因为数组初始化时固定长度，可以使用arraylist的add增加
   ```
4. Java
   ```java
   //一般数组无法直接添加数组，因为数组初始化时固定长度
   ```
5. JavaScript
   * Insert
   ```javascript
    > a
    [ 11, 22, 33 ]
    > a.push(44)
    4
    > a
    [ 11, 22, 33, 44 ]
    > a.unshift(55)
    5
    > a
    [ 55, 11, 22, 33, 44 ]
    > a.splice(2, 0, 66)
    []
    > a
    [ 55, 11, 66, 22, 33, 44 ]
   ```
   * Delete
   ```javascript
    > a
    [ 55, 11, 22, 33, 44 ]
    > a.shift()
    55
    > a
    [ 11, 22, 33, 44 ]
    > a.pop()
    44
    > a
    [ 11, 22, 33 ]
    > a = [11, 22, 33, 44]
    [ 11, 22, 33, 44 ]
    > a.splice(2, 1)//第一个参数表示位置，第二个表示删除的元素个数
    [ 33 ]
    > a
    [ 11, 22, 44 ]
   ```
   * 增删同时进行
    ```swift
    > a
    [ 55, 11, 66, 22, 33, 44 ]
    > a.splice(1, 2, 11, 66, 77)//第“1”个元素后面删除“2”个元素，同时增加“77, 22, 33, 44”
    [ 11, 66 ]
    > a
    [
      55, 11, 66, 77,
      22, 33, 44
    ]
    ```
