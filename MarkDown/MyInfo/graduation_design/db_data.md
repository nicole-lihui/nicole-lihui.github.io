# DB Data

```sql
-- login
insert into login (phone, password) values 
("15116660781", "maxwit"),
("15116660780", "maxwit"),
("15116660782", "maxwit")
;

-- account
insert into account (phone, shop_id, user_name, money) values
("15116660781", 1, "Nicole", 100);

-- goods
insert into goods (icon, title, shop_id, type, status, count, price) values
("https://tse1-mm.cn.bing.net/th/id/OIP.bZwz5ZhrQFy9EYpvT3KCdQHaE-?w=300&h=201&c=7&o=5&dpr=1.25&pid=1.7", "合家团圆月饼", 1, 1, 1, 20, 100),
("https://tse2-mm.cn.bing.net/th/id/OIP.b9rAcB8wEdVkb3g2HsxnggHaHa?w=182&h=182&c=7&o=5&dpr=1.25&pid=1.7", "传统五仁月饼", 1, 1, 1, 30, 66),
("https://tse4-mm.cn.bing.net/th/id/OIP.XPRtFJmZULM8kvMf4fvZxwHaFj?w=244&h=180&c=7&o=5&dpr=1.25&pid=1.7", "miao蛋糕", 1, 1, 1, 10, 220),
("https://tse3-mm.cn.bing.net/th/id/OIP.ON7FtfTUSTK8FvO1XoMpNAHaE8?w=194&h=189&c=7&o=5&dpr=1.25&pid=1.7", "广式月饼", 1, 1, 2, 30, 22),
("https://tse3-mm.cn.bing.net/th/id/OIP.t1vEJtfVEZfCspXxb3cenwHaHZ?w=168&h=167&c=7&o=5&dpr=1.25&pid=1.7", "五彩月饼", 1, 1, 2, 30, 45),
("https://tse2-mm.cn.bing.net/th/id/OIP.Zv-womp2lHJKoeQT5ceRkwHaEp?w=289&h=181&c=7&o=5&dpr=1.25&pid=1.7", "苏式月饼", 1, 1, 3, 30, 45);

-- good_status
insert into good_status (name) values
("在售"),
("待售"),
("下架");

-- shop
insert into shop (shop_name, shop_logo, address, phone, status, introduction) values
("官方直营店", "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2441563887,1184810091&fm=26&gp=0.jpg", "永州市零陵 湖南科技学院南门", "15116660781", 1, "团圆牌官方旗舰，为团圆服务");

-- order_status
insert into order_status (name) values
("新订单"),
("待配送"),
("待完成"),
("已完成"),
("已取消");

-- orders
insert into orders (shop_id, phone, user_name, payType, address, status_id) values
(1, "1519990009", "nicole", 1, "湖南长沙开福区 秀秀街201号", 1),
(1, "1519990009", "nicole", 1, "永州市零陵 湖南科技学院桃园", 1),
(1, "1510000000", "王者", 1, "西安市雁塔区 鱼化寨街道唐兴路唐兴数码3楼318", 2),
(1, "15100000202", "李老头", 1, "西安市雁塔区 大雁小学附近205号", 3),
(1, "15100000502", "吴小姐", 1, "北京市朝阳区 天天开心小区2栋888号", 4),
(1, "15100000202", "李老头", 1, "永州市冷水滩 火车站205号", 5);

-- order_good
insert into order_good (order_id, good_id, count, price) values
(1, 1, 2, 200),
(1, 2, 1, 66),
(2, 1, 2, 200),
(2, 2, 1, 66),
(3, 1, 2, 200),
(3, 2, 1, 66),
(4, 1, 2, 200),
(4, 2, 1, 66),
(5, 1, 2, 200),
(5, 2, 1, 66),
(6, 1, 2, 200),
(6, 2, 1, 66);

-- pay_type
insert into pay_type (name) values
("货到付款"),
("微信支付"),
("支付宝支付"),
("信用卡支付");
```
