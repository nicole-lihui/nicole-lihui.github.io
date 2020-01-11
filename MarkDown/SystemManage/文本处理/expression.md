# Expression

## demo
```bash
./configure --help | egrep -o '(x86|i386|arm|aarch64|mips|risc)\w*-(linux-user|softmmu)' | xargs echo | sed 's/\s/,/g'
```
