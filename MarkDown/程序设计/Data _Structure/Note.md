# Data Structures
[Data Structures](https://docs.python.org/3/tutorial/datastructures.html)


## List
> 便于插入删除（应用频繁）


## Stack(头部出)
> 后进先出
> 应用场景：括号匹配、递归、二叉树深度

```python
>>> stack = [3, 4, 5]

# push
>>> stack.append(6)
>>> stack.append(7)
>>> stack
[3, 4, 5, 6, 7]

# pop
>>> stack.pop()
7
>>> stack
[3, 4, 5, 6]
>>> stack.pop()
6
>>> stack.pop()
5
>>> stack
[3, 4]
```


## Queue(分配在堆——常规情况，从尾部出)
> 先进先出
> 应用场景：消费消息、二叉树广度
> 尾部插入删除效率高，头部ID效率低，头部的插入删除都需要一个一个移动，内存连续
> 

```python
>>> queue = deque(["Eric", "John", "Michael"])

# enqueue()
>>> queue.append("Terry")           # Terry arrives
>>> queue.append("Graham")          # Graham arrives

# dequeue()
>>> queue.popleft()                 # The first to arrive now leaves
'Eric'
>>> queue.popleft()   
```

## Nested List Comprehensions（矩阵推导）
> task：算法构建，实现矩阵行变列，列变行
> 

## tuple/data class
> tuple 概念上保持只读（tuple 和 array 的唯一区别，不可更改）
> （list/array 工作中一般同一类型，tuple 可以不同类型）



## set
> 唯一性、无序性


## map/hash/dictionary
> 关联数组/哈希数组 = 字典

```python
>>> m = {11: 1, 22: 2}
>>> m.keys()
dict_keys([11, 22])
>>> m.values()
dict_values([1, 2])
>>> m.items()
dict_items([(11, 1), (22, 2)])
```
