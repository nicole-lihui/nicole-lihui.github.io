# Interface + function

## interface + lambda
1. case 1

```Java
package com.maxwit;

public class App {
    interface IA {
        int foo(int x, int y);
    }

    public static void main(String[] args) {
        //  把lambda函数赋给接口
        IA ia = (int a, int b) -> a + b;
        System.out.println(ia.foo(11, 22));
    }
}
```

**Question: what if there're more than 1 functions in IA?**
1. case 2

```Java
package com.maxwit;

public class App {
    interface IA {
        int foo(int x, int y);
    }

    static int fa(IA ia) {
        return ia.foo(11, 12);
    }

    public static void main(String[] args) {
        int x = fa((int a, int b) -> a + b);
        System.out.println(x);
    }
}

```

1. case 3


```Java
jshell> list
list ==> [11, 33, 22]

jshell> list.sort((Integer x, Integer y) -> x - y)
jshell> list
list ==> [11, 22, 33]

jshell> list.sort((Integer x, Integer y) -> y - x)
jshell> list
list ==> [33, 22, 11]
```
