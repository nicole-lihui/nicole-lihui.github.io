# exmple

1. 创建5个表的参考字段

## 5个表的参考字段
1. user: git_id, ding_id, register_date
2. course: name, org_id, chat_id
3. user_course: user_id, course_id, begin, end
4. buddy:  buddy_id, disciple_id, course, start, end, chat_id
5. login_history: user_id, time

```sql
create database ooda_db;
use ooda_db;

-- * User
create table user(
    id integer primary key auto_increment not null,
    name varchar(200) not null,
    git_id varchar(200) unique not null,
    ding_id varchar(200) unique not null,
    register_date timestamp not null default current_timestamp
);

-- * Course
create table course(
    id integer primary key auto_increment not null,
    name varchar(200) not null,
    org_id varchar(200) unique,
    chat_id varchar(200) unique
);

--* User_Course
create table user_course(
    id integer primary key auto_increment not null,
    user_id integer not null,
    course_id integer not null,
    start timestamp not null default current_timestamp,
    end timestamp,
    foreign key (user_id) references user(id),
    foreign key (course_id) references course(id)
);

-- * Buddy
create table buddy(
    id integer primary key auto_increment not null,
    buddy_id integer not null,
    disciple_id integer not null,
    course_id integer not null,
    chat_id varchar(200),
    start timestamp not null default current_timestamp,
    end timestamp,
    foreign key (buddy_id) references user(id),
    foreign key (disciple_id) references user(id),
    foreign key (course_id) references course(id)
);

-- * Login_History
create table login_history(
    id integer primary key auto_increment not null,
    user_id integer unique not null,
    start timestamp not null default current_timestamp,
    foreign key (user_id) references user(id)
);

-- login_History trigger
delimiter //
create trigger user_after_insert
after insert
    on user for each row
begin
    insert into login_history(user_id)
    values
    (new.id);
end; //

-- insert User
insert into user(name, git_id, ding_id)
values
("Nicole", "git1", "ding1"),
("Tom", "git2", "ding2"),
("Jom", "git3", "ding3");

-- insert course
insert into course(name, org_id, chat_id)
values
("Java", "org1", "chat1"),
("CC", "org2", "chat2");

-- insert User_Course
insert into user_course(user_id, course_id)
values
(1, 1),
(2, 1),
(3, 2);

-- insert Buddy
insert into buddy(buddy_id, disciple_id, course_id, chat_id)
values
(1, 2, 1, "chat1");

```
