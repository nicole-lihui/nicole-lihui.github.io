# Class And Object


## Abstract
### 1. 抽象类（虚基类）
   ```java
    abstract class A {
        public void f1() {
            System.out.println("A.f1()");
        }

        public void f2() {
            System.out.println("A.f2()");
        }
    }

    public class Demo {
        public static void main(String[] args) {
            //不能直接 A a = new A(),正确用法如下
            A a = new A(){};
            a.f1();
        }
    }
   ```
### 2. 内部类：
1. A内部实例化B
   ```java
    class A {
        class B {
            public void foo() {
                System.out.println("B.foo()");
            }
        }

        public void foo() {
            B b = new B();
            b.foo();
            System.out.println("A.foo()");
        }
    }

    public class Demo {
        public static void main(String[] args) {
            A a = new A();
            a.foo();
        }
    }
    ```

2. 在A类外实例化B `A.B ab = a.new B()`
   ```java
    class A {
        class B {
            public void foo() {
                System.out.println("B.foo()");
            }
        }

        public void foo() {
            B b = new B();
            b.foo();
            System.out.println("A.foo()");
        }
    }

    public class Demo {
        public static void main(String[] args) {
            A a = new A();
            // a.foo();
            A.B ab = a.new B();
            ab.foo();
        }
    }
   ```
3. 内部类的类属性区别
   ```java
    class A {
        int x = 11;

        class B {
            int x = 22; // 这行加与不加分别分别会是什么情况？

            public void foo() {
                System.out.println("B.foo(): " + x);
            }
        }

        public void foo() {
            B b = new B();
            b.foo();
            System.out.println("A.foo(): " + x);
        }
    }

    public class Demo {
        public static void main(String[] args) {
            A a = new A();
            a.foo();
            A.B ab = a.new B();
            ab.foo();
        }
    }
   ```
4. 匿名内部类
   1. case 1
   ```java
    class A {
        int x = 11;

        public void foo() {
            System.out.println("A.foo(): " + x);
        }
    }

    public class Demo {
        class B extends A {
            @Override
            public void foo() {
                System.out.println("B.foo(): " + x);
            }
        }

        void foo() {
            A a = new B();
            a.foo();
        }
    }
   ```
    > B是Demo的内部类

    2. case 2
    上面代码可以等价下面代码
   ```java
    class A {
        int x = 11;

        public void foo() {
            System.out.println("A.foo(): " + x);
        }
    }

    public class Demo {
        void foo() {
            A a = new A(){
                @Override
                public void foo() {
                    System.out.println("B.foo(): " + x);
                }
            };

            a.foo();
        }
    }
   ```
    3. case3: 两者综合代码
    ```java
    class A {
        int x = 11;

        public void foo() {
            System.out.println("A.foo(): " + x);
        }
    }

    public class Demo {
        int y = 22;

        void foo() {
            class B extends A {
                @Override
                public void foo() {
                    System.out.println("B.foo(): " + x + y);
                }
            }
            A a1 = new B();
            a1.foo();

            A a2 = new A(){
                @Override
                public void foo() {
                    System.out.println("B.foo(): " + x + y);
                }
            };
            a2.foo();
        }
    }
    ```
### 3. 


