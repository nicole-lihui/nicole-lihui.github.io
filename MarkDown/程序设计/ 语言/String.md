# String

## Import
> String operations: +, +=, ==, >, <, !=
> 大部分语言，部分有`*`

##1. Binary representation
|            | 2进制 | 8进制 | 16进制 |
| ---------: | :---- | :---: | :----: |
|      C/C++ | N/A   |   0   |   0x   |
|       Java | 0b    |   0   |   0x   |
| JavaScript | 0b    |   0   |   0x   |
|      Swift | 0b    |  0o   |   0x   |
|     Kotlin | 0b    |  N/A  |   0x   |

##2. String
###2.1 String Format
1. C/C++
   ```c++
   printf("%d, %x", a, b)
   ```

2. Java[^1]
   [^1]:实际项目中很少需要用到print format，但string format则很常用
    ```java
    System.out.printf("%x, %o", a, b)
    String.format("%x, %o", a, b)
    ```
    ```java
    jshell> var s = String.format("time now is %02d:%02d", 1, 2)
    s ==> "time now is 01:02"
    ```

3. Kotlin[^2]
   [^2]:兼容上面Java的2种表示方法
   ```kotlin
    >>> "%d, %d".format(18, 1)
    res13: kotlin.String = 18, 1

    >>> var s = "time now is %02d:%02d".format(1, 2)
    >>> s
    res8: kotlin.String = time now is 01:02
   ```

4. Swift[^3]
   [^3]:Swift和之前Objective-C/C++一样，依赖一个基础库——需要import Foundation
   ```swift
     1> import Foundation
     2> var a = String(format: "%02d:%02d", 1, 2)
    a: String = "01:02"
     3> String(format:"%o, %x", 18, 15)
    $R0: String = "22, f"
   ```

5. python
   ```python
    a = 11
    b = 22
    print("{} + {} => {}".format(a, b, a + b))

    >>> '{:x}={:o}'.format(17,17)
    '11=21'

    >>> '{}={}'.format(17,17)
    '17=17'

    >>> '{:#x}={:#o}'.format(17,17)
    '0x11=0o21'
   ```

### 2.2 String Template
>var a = 3.14
1. Kotlin
   ```kotlin
    >>> var a = 3.14
    >>> var s = "PI = ${a}"
    >>> s
    PI = 3.14
   ```

2. Swift
   ```swift
     1> var a = 3.14
    a: Double = 3.1400000000000001
     2> var s = "PI = \(a)."
    s: String = "PI = 3.14."
   ```
   
3. JavaScript
   ```javascript
    > var a = 3.14
    > var s = `PI = ${a}`
    > s
    'PI = 3.14'
    > var s = `PI = ${a}159`
    > s
    'PI = 3.14159'
   ```

4. Java
   ```java
    jshell> import java.text.MessageFormat

    jshell> var a = 3.14
    a ==> 3.14

    jshell> var s = MessageFormat.format("PI = {0}159", a)
    s ==> "PI = 3.14159"
   ```

###2.3 Conversion of strings and numbers
1. python
   * 普通转换：
   ```python
    >>> a = 123
    >>> b = str(a) + '4'
    >>> b
    '1234'
   ```
   * 按进制转化为字符串
    ```python
    >>> a = 15
    >>> bin(a)
    '0b1111'
    >>> oct(a)
    '0o17'
    >>> hex(a)
    '0xf'
    ```
   * 字符转换为数字（String to number）
    ```python
    >>> a = '11'
    >>> int(a, 10)
    11
    >>> int(a, 16)
    17
    >>> int(a, 2)
    3
    ```

2. Swift
   * String to number
   ```swift
     4> var a = "11"
    a: String = "11"
     5> Int(a, radix: 10)
    $R1: Int? = 11
     6> Int(a, radix: 16)
    $R2: Int? = 17
     7> Int(a, radix: 2)
    $R3: Int? = 3
   ```
   * Numner to String
    ```swift
     8> var a = 11
    a: Int = 11
     9> String(a, radix: 10)
    $R4: String = "11"
     10> String(a, radix: 2)
    $R5: String = "1011"
     11> String(a, radix: 8)
    $R6: String = "13"
    ```

3. Kotlin
   * String to number   
   ```kotlin
    >>> var a = "11"
    >>> a.toInt(10)
    res18: kotlin.Int = 11
    >>> a.toInt(16)
    res19: kotlin.Int = 17
    >>> a.toInt(2)
    res20: kotlin.Int = 3
   ```
   * Number to string
   ```kotlin
    >>> var a = 11
    >>> a.toString()
    res44: kotlin.String = 11
    >>> a.toString(2)
    res47: kotlin.String = 1011
    >>> a.toString(16)
    res48: kotlin.String = b
   ```

4. Java
   * String to number
    ```java
    jshell> import java.lang.Integer

    jshell> var a = "11"
    a ==> "11"

    jshell> Integer.parseInt(a)
    $7 ==> 11

    jshell> Integer.parseInt(a, 2)
    $5 ==> 3

    //the second method
    jshell> Integer.parseInt(a, 16)
    $6 ==> 17

    jshell> Integer.valueOf(a)
    $8 ==> 11

    jshell> Integer.valueOf(a, 2)
    $9 ==> 3
    ```
    * Number to string
    ```java
    jshell> var a = 11
    a ==> 11

    jshell> Integer.toString(a);
    $2 ==> "11"

    jshell> Integer.toString(a, 2);
    $5 ==> "1011"

    jshell> Integer.toString(a, 16);
    $6 ==> "b"

    ```
5. JavaScript
   * String to number
   ```javascript
    > a = "11"
    '11'
    > parseInt(a)
    11
    > parseInt(a, 2)
    3
    > parseInt(a, 16)
    17
   ```
   * Number to string
   ```javascript
    > a = 11
    11
    > a.toString()
    '11'
    > a.toString(2)
    '1011'
    > a.toString(16)
    'b'
   ```

###2.. String CRUD(增查改删)
###2.. Regular Expression（正则表达式）

##3. 位运算
1. Swift
   ```swift
    (1 << 8) - 1
   ```
   *anly:*
    >00000001 << 8 - 1 = 100000000 - 1 = 11111111 = 255 
    >**a << n == a x 2的n次方** 

    >`|` 表示按位进行“或”运算
    >有1为1，全0为0


