# Docker Stack & Swarm

## Demo
### swarm demo
```bash
# manager node
$ sudo docker swarm init --advertise-addr 192.168.10.182
```

```bash
# work node
$ docker swarm join --token SWMTKN-1-6a0s87031xb1fy09d311fynskuxzex5jkpg19zk6bewal7w0wm-au16ensd7i1xez7kwlvm80uq7 192.168.10.182:2377
```
```bash
# manager node
$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
pzayo91zif5zvqj7u7im0nxme     docker-desktop      Ready               Active                                  19.03.8
i3vxjgqf9rnxtfy9j4yiopw0u *   ubuntu              Ready               Active              Leader              19.03.12

$ sudo docker service create --replicas 1 --name helloworld alpine ping docker.com
wkrjmu14tpwjpjbxnm6hls8xx
overall progress: 1 out of 1 tasks 
1/1: running   [==================================================>] 
verify: Service converged 

$ sudo docker service ps helloworld
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
oh4mb0211v3f        helloworld.1        alpine:latest       ubuntu              Running             Running 30 seconds ago                       

$ sudo docker service scale helloworld=4
helloworld scaled to 4
overall progress: 4 out of 4 tasks 
1/4: running   [==================================================>] 
2/4: running   [==================================================>] 
3/4: running   [==================================================>] 
4/4: running   [==================================================>] 
verify: Service converged 

$ sudo docker service ps helloworld
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
oh4mb0211v3f        helloworld.1        alpine:latest       ubuntu              Running             Running 3 minutes ago                        
oc8j8i43kt21        helloworld.2        alpine:latest       docker-desktop      Running             Running 2 minutes ago                        
sirbc3szp0df        helloworld.3        alpine:latest       ubuntu              Running             Running 11 seconds ago                       
ma8myfxkb7xg        helloworld.4        alpine:latest       docker-desktop      Running             Running 11 seconds ago         
```

### stack ＆ swarn demo
```bash
# manager node
$ sudo docker swarm init --advertise-addr 192.168.10.182

# work node
$ docker swarm join --token SWMTKN-1-6a0s87031xb1fy09d311fynskuxzex5jkpg19zk6bewal7w0wm-au16ensd7i1xez7kwlvm80uq7 192.168.10.182:2377

# manager node
$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
pzayo91zif5zvqj7u7im0nxme     docker-desktop      Ready               Active                                  19.03.8
i3vxjgqf9rnxtfy9j4yiopw0u *   ubuntu              Ready               Active              Leader              19.03.12

$ cat docker-compose.yml 
version: "3"

volumes:
  emqx-data:
  emqx-lib:

services:
  emqx:
    image: emqx/emqx:latest
    volumes:
      - emqx-data:/opt/emqx/data
      - emqx-lib:/opt/emqx/lib
    ports:
      - 1883:1883
      - 8083:8083
      - 18083:18083
      - 8081:8081
    environment:
      - EMQX_NAME=emqx
      - EMQX_LOADED_PLUGINS=emqx_recon,emqx_retainer,emqx_management,emqx_dashboard,emqx_web_hook
      - EMQX_WEB__HOOK__API__URL=http://192.168.10.178:8080/webhook
      - 'EMQX_WEB__HOOK__RULE__CLIENT__CONNECT__1=""'
      - 'EMQX_WEB__HOOK__RULE__CLIENT__CONNACK__1=""'
      - 'EMQX_WEB__HOOK__RULE__CLIENT__SUBSCRIBE__1=""'
      - 'EMQX_WEB__HOOK__RULE__CLIENT__UNSUBSCRIBE__1=""'
      - 'EMQX_WEB__HOOK__RULE__SESSION__CREATED__1=""'
      - 'EMQX_WEB__HOOK__RULE__SESSION__TERMINATED__1=""'
      - 'EMQX_WEB__HOOK__RULE__SESSION__SUBSCRIBED__1=""'
      - 'EMQX_WEB__HOOK__RULE__SESSION__UNSUBSCRIBED__1=""'
      - 'EMQX_WEB__HOOK__RULE__MESSAGE__PUBLISH__1=""'
      - 'EMQX_WEB__HOOK__RULE__MESSAGE__DELIVERED__1=""'
      - 'EMQX_WEB__HOOK__RULE__MESSAGE__ACKED__1=""'

$ sudo docker stack deploy --compose-file docker-compose.yml emqx_stack_demo
Creating network emqx_stack_demo_default
Creating service emqx_stack_demo_emqx

$ sudo docker service ps  emqx_stack_demo_emqx
ID                  NAME                     IMAGE               NODE                DESIRED STATE       CURRENT STATE                ERROR               PORTS
nswoc6zv1kj0        emqx_stack_demo_emqx.1   emqx/emqx:latest    ubuntu              Running             Running about a minute ago          

$ sudo docker service scale emqx_stack_demo_emqx=2
emqx_stack_demo_emqx scaled to 2
overall progress: 2 out of 2 tasks 
1/2: running   [==================================================>] 
2/2: running   [==================================================>] 
verify: Service converged 

$ sudo docker service ps  emqx_stack_demo_emqx
ID                  NAME                     IMAGE               NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
nswoc6zv1kj0        emqx_stack_demo_emqx.1   emqx/emqx:latest    ubuntu              Running             Running 4 minutes ago                       
uzo181jrnvyz        emqx_stack_demo_emqx.2   emqx/emqx:latest    docker-desktop      Running             Running 9 seconds ago    

$ sudo docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                                                                             NAMES
d825b367c366        emqx/emqx:latest    "/usr/bin/docker-ent…"   11 minutes ago      Up 11 minutes       1883/tcp, 4369/tcp, 5369/tcp, 6369/tcp, 8081/tcp, 8083-8084/tcp, 8883/tcp, 11883/tcp, 18083/tcp   emqx_stack_demo_emqx.1.nswoc6zv1kj0pet3getpyppbs

# work node
$　docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS                                                                                             NAMES
00a56c0136bd        emqx/emqx:latest    "/usr/bin/docker-ent…"   5 minutes ago       Up 5 minutes               1883/tcp, 4369/tcp, 5369/tcp, 6369/tcp, 8081/tcp, 8083-8084/tcp, 8883/tcp, 11883/tcp, 18083/tcp   emqx_stack_demo_emqx.2.uzo181jrnvyzfxpmeo5kzsdhn


```
