# patch

## Example
> CI 无法build jdk11，打patch： 

jdk.patch
```patch
diff --git a/.github/workflows/maven.yml b/.github/workflows/maven.yml
index 9fa0bd3..622a2eb 100644
--- a/.github/workflows/maven.yml
+++ b/.github/workflows/maven.yml
@@ -9,9 +9,9 @@ jobs:

     steps:
     - uses: actions/checkout@v2
-    - name: Set up JDK 1.8
+    - name: Set up JDK 11
       uses: actions/setup-java@v1
       with:
-        java-version: 1.8
+        java-version: 11
     - name: Build with Maven
       run: mvn -B package --file pom.xml
```

> 如下命令打patch
```bash
$ patch -p1 < jdk.patch
```
