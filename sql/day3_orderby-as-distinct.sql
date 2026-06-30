查询 products 表中的 product_id, product_name, price，并按 price 从低到高排序，
SELECT  product_id, product_name, price
FROM products
ORDER BY price ASC
ALTER TABLE products
MODIFY price DECIMAL(10,2);

查询 products 表中的 product_id, product_name, price，并按 price 从高到低排序，
SELECT product_id, product_name, price
FROM products
ORDER BY price DESC

查询 orders 表中的 order_id, user_id, order_date，并按 order_date 从新到旧排序，
SELECT order_id, user_id, order_date
FROM orders 
ORDER BY order_date DESC


查询 users 表中的 user_id, user_name, signup_date，并按 signup_date 从早到晚排序，
SELECT user_id, user_name, signup_date
FROM users
ORDER BY  signup_date ASC
查询 users 表中不重复的 city，
SELECT DISTINCT city
FROM users


查询 products 表中不重复的 category，
SELECT DISTINCT category
FROM products

查询 orders 表中不重复的 payment_method，
SELECT DISTINCT payment_method
FROM  orders

查询 users 表中的 user_id, user_name, city, age，先按 city 从 A 到 Z 排序，再按 age 从大到小排序，
SELECT user_id, user_name, city, age
FROM users
ORDER BY city ASC , age  DESC
 

查询 products 表中的 product_name，并给字段起别名 product；查询 price，并给字段起别名 product_price，
SELECT product_name AS product,price as product_price 
FROM products
查询 orders 表中的 order_id, quantity, unit_price，并计算 quantity * unit_price，别名为 gross_amount，
SELECT order_id,quantity,unit_price,quantity * unit_price AS gross_amount
FROM orders

查询 orders 表中的 order_id, quantity, unit_price, discount_amount，并计算 quantity * unit_price - discount_amount，别名为 actual_amount，
SELECT  order_id, quantity, unit_price, 
discount_amount,quantity * unit_price - discount_amount AS actual_amount
FROM orders

查询 orders 表中的 order_id, user_id, quantity, unit_price, discount_amount，计算 actual_amount，并按 actual_amount 从高到低排序，只显示前 10 条，
SELECT order_id, user_id, quantity, unit_price, discount_amount,
discount_amount,quantity * unit_price - discount_amount AS actual_amount
FROM orders
ORDER BY actual_amount DESC
LIMIT 10;

查询 products 表中价格大于 100 的商品，只显示 product_id, product_name, price，并按 price 从高到低排序，

SELECT product_id, product_name, price
FROM products
WHERE  price > 100
ORDER BY price DESC
查询 orders 表中订单状态为 Paid 的订单，只显示 order_id, order_status, order_date，并按 order_date 从新到旧排序，
SELECT  order_id, order_status, order_date 
FROM orders
WHERE order_status = 'paid'
ORDER BY order_date DESC
查询 users 表中会员等级为 Gold 或 Platinum 的用户，只显示 user_id, user_name, member_level, signup_date，并按 signup_date 从早到晚排序，
SELECT user_id, user_name, member_level, signup_date
FROM users
WHERE member_level IN ('gold' , 'platinum')
ORDER BY signup_date ASC

前三天的复盘练习
查询 users 表中的全部字段，只显示前 10 条记录，
SELECT *
FROM users
LIMIT 10
查询 products 表中的 product_id, product_name, category, price 字段，只显示前 10 条记录，
SELECT product_id, product_name, category, price
FROM products
LIMIT 10
查询 users 表中城市为 Shanghai 的用户，只显示 user_id, user_name, city，
SELECT user_id, user_name, city 
FROM users
WHERE  city  = 'shanghai'
查询 products 表中价格大于 200 的商品，只显示 product_id, product_name, price，
SELECT product_id, product_name, price
FROM products
where price > 200
查询 orders 表中订单状态为 Paid 且优惠金额大于 0 的订单，只显示 order_id, order_status, discount_amount，
SELECT  order_id, order_status, discount_amount 
FROM orders
WHERE order_status = 'paid' and discount_amount > 0
查询 users 表中城市为 Shanghai 或 Beijing 的用户，只显示 user_id, user_name, city，
SELECT user_id, user_name, city
from users
where city in ('shanghai' , 'beijing')
查询 products 表中价格在 100 到 300 之间的商品，只显示 product_id, product_name, price，
SELECT product_id, product_name, price
FROM products
WHERE price BETWEEN 100 and 300
查询 products 表中的 product_id, product_name, price，并按 price 从高到低排序，
SELECT product_id, product_name, price 
FROM products 
ORDER BY  price DESC
查询 users 表中不重复的 city，
SELECT DISTINCT city
FROM users
查询 orders 表中的 order_id, quantity, unit_price, discount_amount，并计算 quantity * unit_price - discount_amount，别名为 actual_amount，按 actual_amount 从高到低排序，只显示前 10 条，
SELECT order_id, quantity, unit_price, discount_amount,
quantity * unit_price - discount_amount as actual_amount
FROM orders
ORDER BY  actual_amount DESC