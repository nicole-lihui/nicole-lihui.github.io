# Build Ipk/apk

## apk打包
* 在Android中某些用户权限需要在AndroidManifest.xml进行配置：
> 默认情况下应用程序是不能发送网络请求的，如果之后App中有用到网络请求，那么需要在`android/app/src/main/AndroidManifest.xml`中进行如下配置（默认debug模式下有配置网络请求）
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="com.example.catefavor">
    <uses-permission android:name="android.permission.INTERNET"/>
</manifest>
```
* flutter 打包
```
$ flutter build apk
```

**参考文献**
* [Flutter - 打包发布](https://www.jianshu.com/p/ca3f558ec067)
* [flutter 打包apk之后，安装在手机上无法访问网络](https://segmentfault.com/q/1010000018586277)
