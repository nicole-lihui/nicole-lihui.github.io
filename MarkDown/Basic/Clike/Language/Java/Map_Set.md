# Map

## java
1. definde
   ```java
    jshell> Map<String, Integer> m = new HashMap<>();
    m ==> {}

    jshell> m.put("aa", 11)
    $2 ==> null

    jshell> m
    m ==> {aa=11}

    jshell> m.put("aa", 11)
    $4 ==> 11

    jshell> m.put("aa", 22)
    $5 ==> 11

    jshell> m.put("bb", 11)
    $6 ==> null

    jshell> m
    m ==> {aa=22, bb=11}
   ```

## 集合
1. 集合：长度可变、可存多数据类型、
2. 集合的使用
   1. list 类似数组的集合 有序
   2. set 数据不同的集合 无序
   3. Map 键值对的集合 
   4. set list map 是接口，不能实例化
3. list实现类
   * ArrayList 底层数组 访问效率高 
   * LinkedList 底层链表 插入删除效率高 
   * Vector 底层数组， 线程安全（别人无权限访问）效率最低
4. set实现类
   1. HashSet 底层哈希表 无序
   2. TreeSet 底层二叉树 无序
   3. LinkedHashSet 底层双链表和哈希表构成 有序

5. map
   1. map是键值对
   2. 所有的健，抽出来就是Set（不能重复）
   3. 实现类
      1. HashMap 底层哈希表 无序
      2. TreeMap 底层二叉树 无序
      3. HashTable 线程安全（HashMap的子类）

## Note
1. hash表： 底层数组 + 链表构成 key由数组构成 value由链表构成
2. 静态代码块
   ```java
   static {
       
   }
   ```

## Basic
1. `<E>` 泛型`e`必须是Object类型
2. 基本数据类型的包装类型； int Integer char Character其他都是首字母大写




