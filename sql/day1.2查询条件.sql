SELECT *
FROM users
LIMIT 9
SELECT user_name ,  age
FROM users
LIMIT 10
  
SELECT *
FROM orders
limit 20

SELECT product_name,category,price
from products

查询 users 表中城市为 Shanghai 的用户。
SELECT*
FROM users
WHERE city = 'shanghai'

查询 users 表中年龄大于 30 的用户，只显示 user_id、user_name、age。
SELECT user_id,user_name,age
FROM users
WHERE  age > 30

查询 users 表中会员等级为 Gold 的用户，只显示 user_id、user_name、member_level
 SELECT user_id,user_name,member _level
 FROM users
 WHERE member_level = 'gold'
 
 
 查询 products 表中价格大于 200 的商品，只显示 product_id、product_name、price
 SELECT product_id,product_name,price
 FROM products
 WHERE price > 200
 
 查询 products 表中商品类别为 Electronics 的商品，只显示 product_id、product_name、category、price。
 SELECT product_id,product_name,category,price
 FROM products
 WHERE category = 'Electronics'
 查询 orders 表中订单状态为 Paid 的订单，只显示 order_id, user_id, order_status
 SELECT order_id, user_id, order_status
 FROM orders
 WHERE order_status = 'Paid'
 查询 orders 表中优惠金额大于 0 的订单，只显示 order_id, discount_amount，
SELECT order_id, discount_amount
FROM orders
WHERE discount_amount > 0
查询 users 表中城市为 Shanghai 或 Beijing 的用户，只显示 user_id, user_name, city，
SELECT user_id, user_name, city
FROM users
WHERE city IN ('Shanghai' , 'Beijing')
SELECT user_id, user_name, city
FROM users
WHERE city = 'Shanghai' or city = 'Beijing'
查询 products 表中价格在 100 到 300 之间的商品，只显示 product_id, product_name, price，
SELECT product_id, product_name, price
FROM products
WHERE price BETWEEN 100 AND 300
查询 orders 表中下单日期在 2026-02-01 之后或当天的订单，只显示 order_id, order_date，
SELECT order_id, order_date
FROM orders
WHERE order_date >=2026-02-01
 
 查询 users 表中年龄大于 25 且城市为 Chengdu 的用户，只显示 user_id, user_name, age, city，
SELECT user_id, user_name, age, city
FROM users
WHERE age > 25 AND city = 'chengdu'
查询 orders 表中订单状态为 Paid 且优惠金额大于 0 的订单，只显示 order_id, order_status, discount_amount，
SELECT order_id, order_status, discount_amount
FROM orders
WHERE order_status = 'Paid' and discount_amount > 0
查询 users 表中会员等级为 Gold 或 Platinum 的用户，只显示 user_id, user_name, member_level，
SELECT user_id, user_name, member_level
FROM users
WHERE member_level IN ('Gold' , 'Platinum')

查询 orders 表中订单状态不是 Paid 的订单，只显示 order_id, order_status，
SELECT order_id, order_status
FROM orders 
WHERE  order_status <> 'paid'
查询 users 表中用户名以 A 开头的用户，只显示 user_id, user_name，
SELECT user_id, user_name
FROM users
WHERE user_name LIKE 'A%'