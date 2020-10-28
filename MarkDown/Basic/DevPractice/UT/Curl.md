# Usage Curl To Test
```bash
# get
curl 'http://localhost:8080/user?name=Nicole'

# post
curl 'http://localhost:8080/user' \
    -H 'Content-Type: application/json' \
    -d '{
        "id": "1",
        "name": "Nicole"
        }'
```
