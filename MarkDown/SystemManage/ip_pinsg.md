# check IP
**该脚本的三个作用：**
1. 动态检测ECS系统软硬件配置，包括OS版本、私网IP、CPU、RAM、Disk
2. 公网和私网两种网络连接方式的性能差异（benchmark）
3. 检测各ECS主机的连通性

```bash
#!/usr/bin/env bash

env=$1
hosts=host.$env
if [ ! -e $hosts ]; then
    echo "no $hosts"
    exit 1
fi

hostgroup=(`cat $hosts`)
privgroup=()

echo "Getting ECS info ..."
for ((i=0;i<${#hostgroup[@]};i++)); do
    host=${hostgroup[$i]}

    priv=`ssh root@$host ifconfig eth0 | grep -w inet | awk '{print $2}'`
    privgroup+=($priv)

    echo "[$((i+1))/${#hostgroup[@]}] $host, $priv"
    for cmd in \
        "lsb_release -d" \
        "lscpu | grep -w '^CPU(s)'" \
        "lsmem | grep 'online memory'" \
        "fdisk -l | grep -o '^Disk /dev.*GiB'"
    do
        info=`ssh root@$host "$cmd | sed 's/\s\+/ /g'"`
        echo "      $info"
    done
done
echo

echo "Benchmark ..."
host=${hostgroup[0]}
for ((i=1;i<${#hostgroup[@]};i++)); do
    echo "public:"
    ssh root@$host ping -c 3 ${hostgroup[$i]} | egrep -o 'time=[\.0-9]+'
    echo "private:"
    ssh root@$host ping -c 3 ${privgroup[$i]} | egrep -o 'time=[\.0-9]+'
done
echo

echo "Checking connectivity ..."
for ((i=0;i<${#hostgroup[@]};i++)); do
    host=${hostgroup[$i]}
    echo $host
    for ((j=0;j<${#hostgroup[@]};j++)); do
        [ $i == $j ] && continue
        target_host=${hostgroup[$j]}
        target_priv=${privgroup[$j]}
        ssh root@$host "ping -c 3 $target_priv > /dev/null"
        if [ $? == 0 ]; then
            result=OK
        else
            result=Failed
        fi
        echo "  ==> $target_host: $result"
    done
done
```
MaxWit2020

## 分析
1. host
```bash
# 传参：test
env=$1
# 检查host.test文件
hosts=host.$env
if [ ! -e $hosts ]; then
    echo "no $hosts"
    exit 1
fi
```
2. `${#hostgroup[@]}` : 数组长度
3. grep , awk

```bash
ssh root@$host ifconfig eth0 | grep -w inet | awk '{print $2}'
```
* `grep -w inet` : 获取inet 这一行
* `awk '{print $2}'` ： 获取并打印第二列

4. 查看设备信息
```bash
    for cmd in \
        "lsb_release -d" \
        "lscpu | grep -w '^CPU(s)'" \
        "lsmem | grep 'online memory'" \
        "fdisk -l | grep -o '^Disk /dev.*GiB'"
    do
        info=`ssh root@$host "$cmd | sed 's/\s\+/ /g'"`
        echo "      $info"
    done
```
* `lsb_release -d` : 系统版本
* `lscpu | grep -w '^CPU(s)'` : CPU信息
* `lsmem | grep 'online memory'` : 内存信息
* `fdisk -l | grep -o '^Disk /dev.*GiB'` : 硬盘大小

5. `ssh root@$host ping -c 3 ${hostgroup[$i]} | egrep -o 'time=[\.0-9]+'`
   * `-c 3` : ping 3 次
   * `egrep -o 'time=[\.0-9]+'` : 正则获取time
6. $?, /dev/null
```bash
ssh root@$host "ping -c 3 $target_priv > /dev/null"
        if [ $? == 0 ]; then
            result=OK
        else
            result=Failed
        fi
        echo "  ==> $target_host: $result"
```
* `ping -c 3 $target_priv > /dev/null` : ping的输出到 /dev/null中，用户可以无感知
* `[ $? == 0 ]` : $?  = 上一行的输出结果(成功为 0， 失败任意非0数字)
