# EMQX

## Docker
```bash
docker run -d --name emqx -p 8883:8883 -p 8081:8081 -p 8084:8084 -p 18083:18083 -p 1883:1883 -p 8083:8083 \
    -e EMQX_LISTENER__TCP__EXTERNAL=1883 \
    -e EMQX_LOADED_PLUGINS="emqx_recon,emqx_retainer,emqx_management,emqx_dashboard,emqx_web_hook" \
    -e EMQX_WEB__HOOK__API__URL="http://172.31.173.67:8080/webhook" \
    -e EMQX_WEB__HOOK__RULE__CLIENT__CONNECT__1= \
    -e EMQX_WEB__HOOK__RULE__CLIENT__CONNACK__1= \
    -e EMQX_WEB__HOOK__RULE__CLIENT__SUBSCRIBE__1= \
    -e EMQX_WEB__HOOK__RULE__CLIENT__UNSUBSCRIBE__1= \
    -e EMQX_WEB__HOOK__RULE__SESSION__CREATED__1= \
    -e EMQX_WEB__HOOK__RULE__SESSION__TERMINATED__1= \
    -e EMQX_WEB__HOOK__RULE__SESSION__SUBSCRIBED__1= \
    -e EMQX_WEB__HOOK__RULE__SESSION__UNSUBSCRIBED__1= \
    -e EMQX_WEB__HOOK__RULE__MESSAGE__PUBLISH__1= \
    -e EMQX_WEB__HOOK__RULE__MESSAGE__DELIVERED__1= \
    -e EMQX_WEB__HOOK__RULE__MESSAGE__ACKED__1= \
    emqx/emqx:latest
```

