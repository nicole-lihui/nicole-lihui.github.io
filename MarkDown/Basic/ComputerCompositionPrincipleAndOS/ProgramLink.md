# 程序链接

## Basic
### 高级语言源程序 -> 可执行文件：
1. 步骤
   > * 预处理（预处理文件 .i）
   > * 编译（汇编文件 .o） 
   > * 汇编（二进制文件 可重定位目标文件 .obj）
   > * 链接（可执行目标文件 .exe）  
  
2. 可重定位目标文件、可执行目标文件
   > 1. 都是机器语言文件(不可显示的二进制目标文件)
   > 2. 前者单模块、后者多模块
   > 3. 前者代码从0开始、后者代码在操作系统的规定的虚拟地址空间产生

3. 二进制目标文件
    > 结构（信息区/节【section】组成）：
    >  1. 二进制代码区/代码节（.text）
    >  2. 只读数据区/节（.rodate）
    >  3. 已初始化数据区/已初始化全局数据节（.data）
    >  4. 未初始化数据区/未初始化全局数据节（.bss）
   
4. 静态链接器将多个`.o`文件组合成一个`.exe`文件的主要任务
   > 1. 符号解析：符号引用和符号定义建立关联（符号放在可重定位目标文件的`符号表`中）
   > 2. 重定位：重新确定代码、数据的地址并更新指令中被引用符号地址

5. 符号表——结构数组
   > 存放符号名、长度、位置信息等

6. 使用链接的优点
   1. 模块化：（一个程序可分为多个模块、可以建立公共函数库）
   2. 效率高
      1. 提高程序开发效率（可以模块化编译，修改后只需要编译修改过的模块）
      2. 空间利用率：调用公共库的函数，在可执行文件运行时内存中，只需包含被调用函数，不需要包含整个共享库

### 目标文件格式
> 目标文件唯一要素是代码和数据（复杂的会有重定位信息、调试信息等）

1. COM
   * 介绍：
     * 最简单的目标文件系统格式（DOS操作系统）
   * 结构：
     * 代码和数据

2. COFF（通用目标文件格式 Common Object File Format）
   * 介绍：
     * System V UNIX早期通用
  
3. PE（可移植可执行格式 Portale Executable）
   * 介绍：
     * PE是COFF的变种，windows在使用
  
4. ELF（可执行可链接格式 Executable and Linkable Format）
   * 介绍：
     * 现代UNIX操作系统使用


