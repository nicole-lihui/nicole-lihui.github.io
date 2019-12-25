# Lambda

## Java
```java
//Lambda
interface Myl{
    boolean fun(int y);
}

Myl ly = (y) -> y % 400 == 0 || y % 100 != 0 && y % 4 == 0;

void isLy(Myl ly, int y) {
    ly.fun(int y);
}
```
Result
```java
jshell> interface Myl{
   ...>     boolean ly(int y);
   ...> }
|  created interface Myl

jshell>

jshell> Myl ly = (y) -> y % 400 == 0 || y % 100 != 0 && y % 4 == 0;
ly ==> $Lambda$16/0000000054211BE0@83a8d200

jshell> ly
ly ==> $Lambda$16/0000000054211BE0@83a8d200
```