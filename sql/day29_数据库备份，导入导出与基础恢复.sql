-- ==================================================
-- 第1题
-- 查询当前数据库名称，并查看当前数据库中的表列表。
-- ==================================================
SELECT DATABASE() as current_datebse;

SHOW TABLES;

-- ==================================================
-- 第2题
-- 删除表 orders_backup_day29。即使该表不存在，也不能报错。
-- 再创建 orders_backup_day29，使其拥有与 orders 表相同的表结构和索引。
-- ==================================================
DROP TABLE IF EXISTS orders_backup_day29;

CREATE TABLE orders_backup_day29 LIKE orders;

-- ==================================================
-- 第3题
-- 将 orders 表当前全部数据复制到 orders_backup_day29。
-- ==================================================

INSERT INTO orders_backup_day29
SELECT
      * 
FROM orders;

-- ==================================================
-- 第4题
-- 分别查询 orders 和 orders_backup_day29 的订单数量。
-- 显示字段：source_order_count, backup_order_count
-- ==================================================
SELECT 
      count(*) AS source_order_count
FROM orders;

SELECT 
      count(*) AS backup_order_count
FROM orders_backup_day29;
-- ==================================================
-- 第5题
-- 查看 orders 表和 orders_backup_day29 的完整建表语句。
-- ==================================================
SHOW CREATE TABLE orders;
SHOW CREATE TABLE orders_backup_day29;

-- ==================================================
-- 第6题
-- 开始事务，删除 orders 表中订单编号 O0001。
-- 查询该订单是否仍存在。
-- ==================================================
START TRANSACTION;

DELETE FROM orders
WHERE order_id = 'O0001';

SELECT 
      *
FROM orders
WHERE order_id = 'O0001';
-- 第7题
-- 在第 6 题的同一个事务中，从 orders_backup_day29 恢复订单编号 O0001 到 orders 表。
-- 查询订单编号、用户编号、订单日期和优惠金额，确认恢复结果。
-- 显示字段：order_id, user_id, order_date, discount_amount
-- ==================================================
INSERT INTO orders
SELECT 
      *
FROM orders_backup_day29
WHERE order_id = 'O0001';

SELECT 
      order_id, 
			user_id, 
			order_date, 
			discount_amount
FROM orders
WHERE order_id = 'O0001';
-- ==================================================
-- 第8题
-- 回滚第 6、7 题开启的事务。
-- 再查询订单编号 O0001，确认练习数据状态。
-- 显示字段：order_id, user_id, order_date, discount_amount
-- ==================================================
ROLLBACK;

SELECT 
      order_id, 
			user_id, 
			order_date, 
			discount_amount
FROM orders
WHERE order_id = 'O0001';

-- ==================================================
-- 第9题
-- 查询 users、orders、products 三张表的行数。
-- 显示字段：user_count, order_count, product_count
-- ==================================================
SELECT
      count(*) AS user_count
FROM users;

SELECT
      count(*) AS order_count
FROM orders;

SELECT
      count(*) AS product_count
FROM products;


SELECT
    (
        SELECT COUNT(*)
        FROM users
    ) AS user_count,
    (
        SELECT COUNT(*)
        FROM orders
    ) AS order_count,
    (
        SELECT COUNT(*)
        FROM products
    ) AS product_count;


-- ==================================================
-- 第10题
-- 使用 SQL 注释说明 ROLLBACK、复制表和完整逻辑备份分别适合解决什么问题。
-- ==================================================
-- rollback 适合解决当前连接中事务中的数据的修改，并且可以撤销修改，
-- 复制表适合进行一些小体量的 表级别的修改和联系，用creat into 来进行结构和数据复制
-- 完整的逻辑备份 适合数据库级别的数据备份和转移，数据库的结构，对象和数据进行复制和恢复

-- ==================================================
-- 第11题
-- 使用 SQL 注释列出恢复数据库前至少需要确认的三项信息。
-- ==================================================
-- 第一项 确认目标数据库的信息,合适可以进行导入
-- 第二项 确认复制的数据完整，并且可用，时间也合适
-- 第三项  首先导入测试数据集，没有问题再进行导入正式的数据库

-- ==================================================
-- 第12题
-- 删除练习备份表 orders_backup_day29。删除时即使该表不存在，也不能报错。
-- ==================================================

DROP TABLE IF EXISTS orders_backup_day29；