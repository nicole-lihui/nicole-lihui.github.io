# GO + GO Micro

## install go
> brew 需要换成国内的源，速度快，后期常用。

```bash
$ brew install go

# check go install info
$ brew info go

# create dir go
$ mkdir ~/go

# or .bashrc
$ cat ~/.zshrc
export GOPATH=~/go
export GO111MODULE=on
export GOBIN=$GOPATH/bin
export GOPROXY=https://goproxy.cn,direct
```

```bash
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.io,direct


go get -v -u github.com/ramya-rao-a/go-outline
go get -v -u github.com/acroca/go-symbols
go get -v -u github.com/mdempsky/gocode
go get -v -u github.com/rogpeppe/godef
go get -v -u github.com/zmb3/gogetdoc
go get -v -u github.com/fatih/gomodifytags
go get -v -u sourcegraph.com/sqs/goreturns
go get -v -u github.com/cweill/gotests/...
go get -v -u github.com/josharian/impl
go get -v -u github.com/haya14busa/goplay/cmd/goplay
go get -v -u github.com/uudashr/gopkgs/cmd/gopkgs
go get -v -u github.com/davidrjenni/reftools/cmd/fillstruct
go get -v -u github.com/alecthomas/gometalinter

```

## go mirco

### install go-mirco
```bash
$ go get -u -v google.golang.org/grpc
$ go get -u -v github.com/micro/micro
$ go get -u -v github.com/micro/protoc-gen-micro/v2
```

### install concul
```bash
$ brew install consul

# To have launchd start consul now and restart at login:
$ brew services start consul

# Or, if you don't want/need a background service you can just run:
$ consul agent -dev -bind 127.0.0.1
```

### install protobuf
```bash
$ brew install protobuf
```

## Demo

### 目录结构
```bash
$ mkdir -p $GOPATH/src/gomicro-demo/{proto,server,client}
```

### Proto
```bash
$ cd $GOPATH/src/gomicro-demo/proto
$ go mod init luckfs.com/proto

$ cat greeter.proto
syntax = "proto3";

service Greeter {
	rpc Hello(Request) returns (Response) {}
}

message Request {
	string name = 1;
}

message Response {
	string greeting = 2;
}

$ protoc --proto_path=$GOPATH/src:. --micro_out=. --go_out=. greeter.proto

# 自动引入依赖
$ go build

# 执行成功后，可通过如下指令查看Go Modules：
$ go list -m all
```

### Server
```go
$ cd $GOPATH/src/gomicro-demo/server
$ cat server/main.go
package main

import (
	"fmt"
	"context"

	micro "github.com/micro/go-micro"
	proto "luckfs.com/proto"
)

type Greeter struct{}

func (g *Greeter) Hello(ctx context.Context, req *proto.Request, rsp *proto.Response) error {
	rsp.Greeting = "Hello " + req.Name
	return nil
}

func main() {
	// Create a new service. Optionally include some options here.
	service := micro.NewService(
		micro.Name("greeter"),
		micro.Version("latest"),
		micro.Metadata(map[string]string{
			"type": "helloworld",
		}),
	)

	// Init will parse the command line flags. Any flags set will
	// override the above settings. Options defined here will
	// override anything set on the command line.
	service.Init()

	// Register handler
	proto.RegisterGreeterHandler(service.Server(), new(Greeter))

	// Run the server
	if err := service.Run(); err != nil {
		fmt.Println(err)
	}
}

```

### Client
```go
$ cat client.go
package main

import (
	"context"
	"fmt"

	"luckfs.com/proto"
	micro "github.com/micro/go-micro"
)

func main() {
	// Create a new service
	service := micro.NewService(micro.Name("greeter.client"))
	// Initialise the client and parse command line flags
	service.Init()

	greeterCli := greeter.NewGreeterService("greeter", service.Client())

	// Call the greeter
	rsp, err := greeterCli.Hello(context.TODO(), &greeter.Request{Name: "River"})
	if err != nil {
		fmt.Println(err)
	}

	// Print response
	fmt.Println(rsp.Greeting)
}
```

### Run
```
$ cd $GOPATH/src/gomicro-demo
$ go mod init luckfs.com/gomicrodemo
$ go build -o client/client.go  server/main.go
```

> 出现如下错误
```bash
server/main.go:8:2: cannot find module providing package luckfs.com/proto: unrecognized import path "luckfs.com/proto": https fetch: Get "http://www.luckfs.com/home.php": redirected from secure URL https://luckfs.com/proto?go-get=1 to insecure URL http://www.luckfs.com/home.php

```
增加如下配置：
```bash
$ cat go.mod

module luckfs.com/gomicrodemo

go 1.14

require (
	github.com/micro/go-micro v1.18.0 // indirect
	luckfs.com/proto v0.0.0-00010101000000-000000000000 // indirect
)

replace luckfs.com/proto => ./proto
replace google.golang.org/grpc => google.golang.org/grpc v1.26.0
```

```bash
$ go run server/main.go
$ go run client/client.go
```

---
* `replace google.golang.org/grpc => google.golang.org/grpc v1.26.0`
解决如下问题：
```bash
# github.com/coreos/etcd/clientv3/balancer/resolver/endpoint
../../pkg/mod/github.com/coreos/etcd@v3.3.17+incompatible/clientv3/balancer/resolver/endpoint/endpoint.go:114:78: undefined: resolver.BuildOption
../../pkg/mod/github.com/coreos/etcd@v3.3.17+incompatible/clientv3/balancer/resolver/endpoint/endpoint.go:182:31: undefined: resolver.ResolveNowOption
# github.com/coreos/etcd/clientv3/balancer/picker
../../pkg/mod/github.com/coreos/etcd@v3.3.17+incompatible/clientv3/balancer/picker/err.go:37:44: undefined: balancer.PickOptions
../../pkg/mod/github.com/coreos/etcd@v3.3.17+incompatible/clientv3/balancer/picker/roundrobin_balanced.go:55:54: undefined: balancer.PickOptions
```