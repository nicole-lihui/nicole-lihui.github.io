#OpenLDAP + OpenSSH


# Allow su account:
1. 验证并修改/etc/ldap/ldap.conf:
```
BASE    dc=maxwit,dc=com
URI     ldap://172.18.1.175 ldap://ldap-master.maxwit.com:666
```

2. 使系统能够查看和使用LDAP帐户，我们需要安装 libnss-ldap：
如果已经安装过可以卸载并删除配置文件：
卸载：
```bash
sudo apt purge -y libnss-ldap
```
安装：
安装过程中选项LDAP server URI: ldap://172.18.1.175 (Note the "ldap://", not "ldapi://")与第一步配置保持一致
```bash
sudo apt install -y libnss-ldap
```

3. 验证并修改/etc/nsswitch.conf，两种选择：
第一种
```bash
passwd:         files ldap
group:          files ldap
```
第二种：
```bash
passwd:         compat ldap
group:          compat ldap
```

测试之前确保用户已经有密码:
没加密码：
```bash
ldappasswd -x -D cn=admin,dc=example,dc=com -W -S uid=jirky,ou=people,dc=example,dc=com
```
Test:
```bash
id root
id john
su john
```
 




## ALL
install
```bash
sudo apt install -y slapd ldap-utils
sudo dpkg-reconfigure slapd
```

Test:
```bash
ls -al /etc/ldap/slapd.d/cn=config/cn=schema/
```
replace the default "olcLogLevel: none" with "olcLogLevel: 256":

loglevel.ldif
```bash
dn: cn=config
changetype: modify
replace: olcLogLevel
olcLogLevel: 256
```

```bash
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f loglevel.ldif
```

uid_eq.ldif
```bash
dn: olcDatabase={1}mdb,cn=config
changetype: modify
add: olcDbIndex
olcDbIndex: uid eq
```
```bash
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f uid_eq.ldif

```


（很重要）验证并修改/etc/ldap/ldap.conf:
```bash
BASE    dc=maxwit,dc=com
URI     ldap://172.18.1.175 ldap://ldap-master.maxwit.com:666

```

Test:
```bash
ldapsearch -x
```
```bash
sudo slapcat
```
Create tree:
ou.ldif
```bash
dn: ou=People,dc=maxwit,dc=com
objectClass: organizationalUnit
ou: People

dn: ou=Groups,dc=maxwit,dc=com
objectClass: organizationalUnit
ou: Groups
```

```bash
sudo invoke-rc.d slapd stop
sudo slapadd -c -v -l ou.ldif
sudo invoke-rc.d slapd start
```
test
```bash
ldapsearch -x ou=people
```

Create account:
user1.ldif
```bash
dn: cn=miners,ou=Groups,dc=maxwit,dc=com
objectClass: posixGroup
cn: miners
gidNumber: 5000

dn: uid=john,ou=People,dc=maxwit,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: john
sn: Doe
givenName: John
cn: John Doe
displayName: John Doe
uidNumber: 10000
gidNumber: 5000
userPassword: johnldap
gecos: John Doe
loginShell: /bin/bash
homeDirectory: /home/john
```
```bash
ldapadd -c -x -D cn=admin,dc=maxwit,dc=com -W -f user1.ldif
```

Dinfine password:
```bash
ldappasswd -x -D cn=admin,dc=maxwit,dc=com -W -S uid=john,ou=people,dc=maxwit,dc=com
```
Test NSS:
```bash
id root
>>uid=0(root) gid=0(root) groups=0(root)
id john
>>id: ‘john’: no such user
```
使系统能够查看和使用LDAP帐户，我们需要安装 libnss-ldap，libpam-ldap和 nscd

```bash
sudo apt install -y libnss-ldap libpam-ldap nscd
```

验证并修改/etc/nsswitch.conf：注意可能是compat system需要改成 compat ldap
```bash
passwd:         compat ldap
group:          compat ldap
```
Nscd（名称服务缓存守护程序）用于在本地缓存元数据，而不是每次都查询LDAP服务器。从长远来看，它是一种非常高效的服务，但在测试期间，我们暂时停止它，以便始终直接从LDAP服务器检索数据
```bash
sudo invoke-rc.d nscd stop
```
test:
```bash
id jirky

uid = 20000（jirky）gid = 20000（jirky）groups = 20000（jirky）
```

PAM配置
(将LDAP集成到系统身份验证过程中,默认的PAM配置将要求用户存在 要么在本地密码文件 或 LDAP中，并知道正确的密码，对于认证过程继续):

将需要启动在上一步骤中停止的nscd：
```bash
sudo invoke-rc.d nscd start
```


















