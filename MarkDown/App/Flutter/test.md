# Test

1. Android真机调试
```bash
# 搜索到Android设备后，运行程序
$ flutter run         
Launching lib/main.dart on V1813BA in debug mode...
Running Gradle task 'assembleDebug'...                                  
(This is taking an unexpectedly long time.)       ⣽^C%   
# 一直卡在上面步骤，无任何操作

$ flutter doctor -v
[!] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
    • Android SDK at /Users/nicole/Library/Android/sdk
    • Android NDK location not configured (optional; useful for native profiling support)
    • Platform android-29, build-tools 29.0.3
    • Java binary at: /Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_212-release-1586-b4-5784211)
    ✗ Android license status unknown.
      Try re-installing or updating your Android SDK Manager.
      See https://developer.android.com/studio/#downloads or visit https://flutter.dev/setup/#android-setup for
      detailed instructions.

# 为了解决 “ Android license status unknown.  ”问题，操作如下
$ flutter doctor --android-licenses
 flutter doctor --android-licenses
A newer version of the Android SDK is required. To update, run:
/Users/nicole/Library/Android/sdk/tools/bin/sdkmanager --update

$ /Users/nicole/Library/Android/sdk/tools/bin/sdkmanager --update
Exception in thread "main" java.lang.NoClassDefFoundError: javax.xml.bind.annotation.XmlSchema
        at com.android.repository.api.SchemaModule$SchemaModuleVersion.<init>(SchemaModule.java:156)
        at com.android.repository.api.SchemaModule.<init>(SchemaModule.java:75)
        at com.android.sdklib.repository.AndroidSdkHandler.<clinit>(AndroidSdkHandler.java:81)
        at com.android.sdklib.tool.sdkmanager.SdkManagerCli.main(SdkManagerCli.java:73)
        at com.android.sdklib.tool.sdkmanager.SdkManagerCli.main(SdkManagerCli.java:48)
Caused by: java.lang.ClassNotFoundException: javax.xml.bind.annotation.XmlSchema
        at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:768)
        at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:178)
        at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:1067)
        ... 5 more
```
**最后解决方法：**
* 由于Java版本为 Java 11，在Java 11版本中该问题暂时无法解决。
* 最简单的方式是，降低Java版本
* Java 8 切换后，`/Users/nicole/Library/Android/sdk/tools/bin/sdkmanager --update` 成功升级。

* 参考链接
[Flutter App stuck at “Running Gradle task 'assembleDebug'… ”](https://stackoverflow.com/questions/59516408/flutter-app-stuck-at-running-gradle-task-assembledebug)
["this is taking an unexpectedly long time" ](https://github.com/flutter/flutter/issues/27310)
[Android license status unknown.](https://github.com/flutter/flutter/issues/16025#issuecomment-468958533)
[How to solve: Android license status unknown and also Android sdkmanager tool not found?](https://stackoverflow.com/questions/60464016/how-to-solve-android-license-status-unknown-and-also-android-sdkmanager-tool-no)
[无法安装android-sdk：“ java.lang.NoClassDefFoundError：javax / xml / bind / annotation / XmlSchema”](https://stackoverflow.com/questions/46402772/failed-to-install-android-sdk-java-lang-noclassdeffounderror-javax-xml-bind-a/51644855#51644855)
