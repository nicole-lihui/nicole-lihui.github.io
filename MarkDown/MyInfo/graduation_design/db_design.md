# DataBase Design

1. account_tb
id int
phone char
password char
shop_id int

2. shop_tb
id int
shop_name char
address char
phone char
introduction

3. order_tb
id int
shop_id int
start_time timestamp
end_time timestamp
status char

4. good_tb
id int
shop_id int
start_time timestamp

```SQL
create database merchants_db CHARACTER SET utf8 COLLATE utf8_general_ci;
use merchants_db;

create table login(
    id integer primary key auto_increment not null,
    phone varchar(20) not null,
    password varchar(100) not null,
    register_time timestamp not null default current_timestamp
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table account(
    id integer primary key auto_increment not null,
    phone varchar(20) not null,
    shop_id integer not null,
    user_name varchar(200) not null,
    money DECIMAL(6,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table shop(
    id integer primary key auto_increment not null,
    shop_name varchar(50) not null,
    shop_logo varchar(500),
    address varchar(300) not null,
    phone varchar(20) not null,
    status integer not null,
    introduction varchar(500) not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create table shop_status(
    id integer primary key auto_increment not null,
    name varchar(20) not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table orders(
    id integer primary key auto_increment not null,
    shop_id integer not null,
    phone varchar(20) not null,
    user_name varchar(100) not null,
    payType integer not null,
    address varchar(300) not null,
    status_id integer not null,
    start_time timestamp not null default current_timestamp,
    end_time timestamp
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table order_status(
    id integer primary key auto_increment not null,
    name varchar(20) not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table goods(
    id integer primary key auto_increment not null,
    icon varchar(500),
    title varchar(300) not null,
    shop_id integer not null,
    type integer not null,
    status integer not null,
    count integer not null,
    price DECIMAL(6,2),
    start_time timestamp not null default current_timestamp
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table good_status(
    id integer primary key auto_increment not null,
    name varchar(20) not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table good_type(
    id integer primary key auto_increment not null,
    name varchar(20) not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table order_good(
    id integer primary key auto_increment not null,
    order_id integer not null,
    good_id integer not null,
    count integer not null,
    price DECIMAL(6,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table bank(
    id integer primary key auto_increment not null,
    bank_name varchar(50) not null,
    first_letter varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table account_bank(
    id integer primary key auto_increment not null,
    account_id integer not null,
    bank_id integer not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table account_running(
    id integer primary key auto_increment not null,
    account_id integer not null,
    bank_id integer not null,
    withdrawal DECIMAL(6,2) not null,
    w_time timestamp not null default current_timestamp
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create table pay_type(
    id integer primary key auto_increment not null,
    name varchar(20) not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```
