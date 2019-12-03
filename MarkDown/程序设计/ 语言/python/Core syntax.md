# Core Syntax

___
## Array/Vector/List

```python
# List

# 1. Define list
list1 = [11, 22, 33, 44]
print("list1 : {}".format(list1))

list2 = [11] * 6
print("list2 : {}".format(list2))


# 2. Length & Element position
list_len = len(list1)
print("List length : {}".format(list_len))

print("list1[0] : {}".format(list1[0]))
print("list1[-1] : {}".format(list1[-1]))
print("list1[1:] : {}".format(list1[1:]))
print("list1[1 : 3] : {}".format(list1[1 : 3]))


# 3. Add/Delete
# Add and Insert
list1.append(55)
print("list1 : {}".format(list1))

list1.insert(0, 661)
print("list1 : {}".format(list1))
list1.insert(-1, 662)
print("list1 : {}".format(list1))
list1.insert(len(list1), 663)
print("list1 : {}".format(list1))

# Delete
# pop仅仅从list中移除
    # 如果pop了以后“没人接手”，那pop出来后就成了野指针，python的GC也会回收对应的memory  
        # GC（Garbage Collection)垃圾回收
    # del移除且删除(释放内存)
list1.pop()
print("list1 : {}".format(list1))
list1.pop(0)
print("list1 : {}".format(list1))

del list1[4]
print("list1 : {}".format(list1))

# 4. Basic List Operations
list3 = list1 + list2
print("list3 = list1 + list2 : {}".format(list3))

is22 = 22 in list1
print("22 in list1 : {}".format(is22))

for i in list1:
    print(i)

```
## Del and Remove
> del 根据下标删除
> remove根据value值而不是下标进行删除
```python
>>> a = [11, 22, 33, 22, 55]
>>> a.remove(a[3])
>>> a
[11, 33, 22, 55]

>>> a = [11, 22, 33, 22, 55]
>>> del a[3]
>>> a
[11, 22, 33, 55]
```
___

