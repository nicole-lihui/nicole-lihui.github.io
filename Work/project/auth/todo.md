1. user/user_pool 去除 tenantId 
2. user_pool 增加 userId，标识用户持所属的账号
3. 创建 xauthing 用户池，作为账户系统使用（生成secret/jwtSecret）
```sql
insert into user_pools(id, secret, jwt_secret, name) values('7f74f487bc121542ad0c7e3d', 'cb6254521050caf857855214bc9dba98', 'cb6254521050caf857855214bc9dba98', 'xauthing');
```

4. xauthing.gateway 配置 sdk，使用 xauthing 用户池


5. 通过 xauthing.gateway 的 loginByPhoneCode 接口创建用户，用户落入 xauthing 用户池；后续通过 loginByPhoneCode 登录，返回用户并生成 token
> 从请求头header中获取userPoolId
* token 返回给谁？ header？

6. 调用 xauthing.gateway 的 /api/currentAccount，触发 xauth middleware 执行，调用 sdk 的 checkLoginStatus ，验证登录状态

7. toDto


8. create user
```json
{
    "query": "\n    mutation createUser($userInfo: CreateUserInput!, $keepPassword: Boolean) {\n  createUser(userInfo: $userInfo, keepPassword: $keepPassword) {\n    id\n    arn\n    userPoolId\n    username\n    email\n    emailVerified\n    phone\n    phoneVerified\n    unionid\n    openid\n    nickname\n    registerSource\n    photo\n    password\n    oauth\n    token\n    tokenExpiredAt\n    loginsCount\n    lastLogin\n    lastIP\n    signedUp\n    blocked\n    isDeleted\n    device\n    browser\n    company\n    name\n    givenName\n    familyName\n    middleName\n    profile\n    preferredUsername\n    website\n    gender\n    birthdate\n    zoneinfo\n    locale\n    address\n    formatted\n    streetAddress\n    locality\n    region\n    postalCode\n    city\n    province\n    country\n    createdAt\n    updatedAt\n  }\n}\n    ",
    "variables": {
        "userInfo": {
            "username": "17674616603",
            "email": "nicolelihui@qq.com",
            "password": "d78+Q2zgF7bhsNjdPw9qm23xoRPBl54s+PQhchkTP2ebSbzi8QJtavFOKBYBBjPL1AUysDq4dJq+/Hzoxi1xMbOjDuo/iRSTGrETrkTiEADtVirwiC9MS2vfe/4lz+kIp9SEO10IvCuu+sRcNOzlFcJHJ5ikVmaPgt5xkWLDOW4="
        }
    }
}
```
9.  update user
```json
{
    "query": "\n    mutation updateUser($id: String, $input: UpdateUserInput!) {\n  updateUser(id: $id, input: $input) {\n    id\n    arn\n    userPoolId\n    username\n    email\n    emailVerified\n    phone\n    phoneVerified\n    unionid\n    openid\n    nickname\n    registerSource\n    photo\n    password\n    oauth\n    token\n    tokenExpiredAt\n    loginsCount\n    lastLogin\n    lastIP\n    signedUp\n    blocked\n    isDeleted\n    device\n    browser\n    company\n    name\n    givenName\n    familyName\n    middleName\n    profile\n    preferredUsername\n    website\n    gender\n    birthdate\n    zoneinfo\n    locale\n    address\n    formatted\n    streetAddress\n    locality\n    region\n    postalCode\n    city\n    province\n    country\n    createdAt\n    updatedAt\n  }\n}\n    ",
    "variables": {
        "id": "5f924606a4bc332211876ffd",
        "input": {
            "name": "名字",
            "givenName": "名",
            "familyName": "姓",
            "middleName": "中间名",
            "nickname": "昵称",
            "phone": "15111111111",
            "email": "邮箱@qq.com",
            "preferredUsername": "首选用户名",
            "gender": "F",
            "profile": "个人信息页",
            "website": "个人博客",
            "zoneinfo": "时区信息",
            "locale": "Locale",
            "region": "Region",
            "country": "国家代码",
            "address": "邮寄地址",
            "locality": " Locality",
            "province": "省/区",
            "city": "城市",
            "streetAddress": "街道地址",
            "postalCode": "邮政编码",
            "formatted": "完整的邮寄地址"
        }
    }
}
```