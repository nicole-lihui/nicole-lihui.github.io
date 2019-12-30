# role

```SQL
create table user(
    id integer primary key auto_increment not null,
    username varchar(50) not null,
    password varchar(255) not null,
    enabled boolean not null,
    locked boolean not null
);

create table role(
    id integer primary key auto_increment not null,
    name varchar(50) not null,
    cname varchar(50) not null
);

create table user_role(
    id integer primary key auto_increment not null,
    uid integer not null,
    rid integer not null
);

insert into user(username, password, enabled, locked)
values
("root", "maxwit", 1, 0),
("admin", "maxwit", 1, 0),
("nicole", "maxwit", 1, 0);

insert into role(name, cname)
values
("ROLE_root", "Root"),
("ROLE_admin", "Admin"),
("ROLE_user", "User");


insert into user_role(uid, rid)
values
(1, 1),
(1, 2),
(2, 2),
(3, 3);
```
