# Patch

## bashic
1. generate patch
   ```bash
   patch -p<N> < xx.patch # N = 0, 1, ...
   ```
2. apply patch
   ```bash
   diff -up a/pom.xml b/pom.xml > ab.patch
   cd a
   patch -p1 < ../ab.patch
   ```

3. 
