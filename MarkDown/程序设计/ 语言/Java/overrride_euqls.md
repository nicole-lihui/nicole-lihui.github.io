# equals

1. override equals


## override equals
```java
/**
 * TODO: 请添加描述
 *
 * @author huangjianhuan
 * @date 2019-11-17
 * @since 1.0.0
 */
public class OverrideDemo {

    private String attr;

    private int attr1;

    public String getAttr() {
        return attr;
    }

    public void setAttr(String attr) {
        this.attr = attr;
    }

    public int getAttr1() {
        return attr1;
    }

    public void setAttr1(int attr1) {
        this.attr1 = attr1;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OverrideDemo that = (OverrideDemo) o;
        return attr1 == that.attr1 &&
                Objects.equals(attr, that.attr);
    }

    @Override
    public int hashCode() {
        return Objects.hash(attr, attr1);
    }
}
```
```java
// Object equals 
public boolean equals(Object obj) {
    return (this == obj);
}
//java 中对象默认继承 Object 类，如果不重写 equals 方法，默认调用的 Object 类方法
```
> 一般来说，java 里面重写 override 需要准许这么几个原则：
> 1、自反性：对于任何非空引用x，x.equals(x)应该返回true。
> 2、对称性：对于任何引用x和y，如果x.equals(y)返回true，那么y.equals(x)也应该返回true。
> 3、传递性：对于任何引用x、y和z，如果x.equals(y)返回true，y.equals(z)返回true，那么x.equals(z)也应该返回true。
> 4、一致性：如果x和y引用的对象没有发生变化，那么反复调用x.equals(y)应该返回同样的结果。
> 5、非空性：对于任意非空引用x，x.equals(null)应该返回false。+


