# resource
## 状态管理
1. [Flutter状态管理provider用法](https://www.jianshu.com/p/f1b42707f887)
2. [Flutter | 状态管理拓展篇——RxDart(四)](https://www.jianshu.com/p/e0b0169a742e)

## 组件
1. [7.1 导航返回拦截（WillPopScope）](https://book.flutterchina.club/chapter7/willpopscope.html)

## 布局
1. [主轴和交叉轴布局](https://blog.csdn.net/yuzhiqiang_1993/article/details/86496145)
2. [使用顶部切换导航TabBar](https://www.jianshu.com/p/fbd1d0e22f9c)

## Basic
1. [Flutter实战系列](https://juejin.im/collection/5db25bcff265da06a19a304e)


```dart
Future _onRefresh() async {
await Future.delayed(Duration(seconds: 2), () {
    setState(() async {
    _page = 1;
    await presenter.search(Constant.shopId, Constant.orderStatus, true, true);
    });
});
}
Future search(String text, String status, bool isShowDialog, bool isList) async{
Map<String, String> params = Map();
params['shopId'] = text;
params['status'] = status;
await requestNetwork<OrderItemEntity>(Method.get,
    url: HttpApi.orders,
    queryParameters: params,
    isShow: isShowDialog,
    isList: isList,
    onSuccessList: (data) {
    if (data != null) {
        view.orderslist = data;
    } else {
        print("Loading Fial");
    }
    },
    onError: (_, __) {
    /// 加载失败
    print(_);
    }
);
}

//Flutter内部网络控制的数据处理逻辑
Future requestNetwork<T>(Method method, {@required String url, bool isShow : true, bool isClose: true, Function(T t) onSuccess,
Function(List<T> list) onSuccessList, Function(int code, String msg) onError, dynamic params, 
Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList : false}) async {
if (isShow) view.showProgress();
await DioUtils.instance.requestNetwork<T>(method, url,
    params: params,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken?? _cancelToken,
    isList: isList,
    onSuccess: (data) {
        if (isClose) view.closeProgress();
        if (onSuccess != null) {
        onSuccess(data);
        }
    },
    onSuccessList: (data) {
        if (isClose) view.closeProgress();
        if (onSuccessList != null) {
        onSuccessList(data);
        }
    },
    onError: (code, msg) {
        _onError(code, msg, onError);
    }
);
```

```java
//Controller 接收来自orders页面的请求，获取参数shopID，status
    @RequestMapping("orders")
    public List<OrderDO> getOrders(Integer shopId, Integer status) {
        List<OrderDO> ol = null;
        ol = ordersService.selectMany(shopId, status); //根据状态和店铺id，发送数据到OrdersService
        return  ol;
    }
//省略部分代码
//Service根据条件进行业务处理
    public List<OrderDO> selectMany(Integer oshopId, Integer ostatus) {
        SelectStatementProvider selectStatement = select(orderDO.allColumns())//使用Mybaits Dynamic Sql查询订单列表
                .from(orderDO)
                .where(shopId, isEqualTo(oshopId))
                .and(status, isEqualTo(ostatus))
                .build()
                .render(RenderingStrategies.MYBATIS3);

        return orderMapper.selectMany(selectStatement); // 返回查询结果
    }   

```
