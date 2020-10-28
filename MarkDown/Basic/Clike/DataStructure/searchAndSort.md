# Search and Sort

## Search
1. 顺序查找 sequenced search 【适用于无序的顺序表和链表】  O(N)
2. 二分查找（折半查找）【不适合链表， 元素是随机查找的】O(logN)

## Sort
1. 选择排序（Simple Selection Sort）
   * O(N^2) 
   * 不稳定
2. 插入排序 Simple Insertion Sort
   * O(N^2) 
   * 稳定
3. 冒泡排序 Bubble Sort
   * O(N^2) 
   * 稳定
4. 希尔排序 Shell Sort（变步长的插入排序）
   * O(N^K) [1 < k < 2] [效率与步chang有关] 
   * 不稳定 
5. 堆排序
   * O(NlogN) 
   * 不稳定
6. 归并排序 Merge Sort [分治法]
   * O(NlogN) 
   * 稳定
7. 快速排序 Quick Sort
   * pivot选得不好 O(N^2)
   * 每次pivot比较均匀 O(NlogN)
   * 不稳定
 
1. 桶排序 Bucket Sort
   * O(N) 线性时间 （N 与 M【桶个数】差不多）
2. 基数排序 Radix Sort 【个位， 十位， 百位...】
   * O(k(M + N))
3.  外部排序 （多采用归并排序）


