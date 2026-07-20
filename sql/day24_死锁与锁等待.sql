
-- ==================================================
-- 第1题
-- 查看当前数据库连接列表。
-- 观察字段：Id, User, Host, db, Command, Time, State, Info
-- ==================================================
SHOW PROCESSLIST;

-- ==================================================
-- 第2题
-- 查看最近的 InnoDB 状态信息。
-- 在结果中查找是否存在 LATEST DETECTED DEADLOCK 段落。
-- ==================================================
SHOW ENGINE INNODB STATUS;

-- ==================================================
-- 第3题
-- 查询当前会话的 InnoDB 锁等待超时时间。
-- 显示字段：innodb_lock_wait_timeout
-- ==================================================
SELECT @@innodb_lock_wait_timeout;

-- ==================================================
-- 第4题（窗口 A）
-- 开始事务，使用 SELECT ... FOR UPDATE 锁定读取 order_id 等于 1 的订单。
-- 不要立即结束事务。
-- 显示字段：order_id, discount_amount
-- ==================================================
START TRANSACTION;

SELECT
      order_id, 
			discount_amount
FROM orders
WHERE order_id = 'O0001'
FOR UPDATE;



-- ==================================================
-- 第5题（窗口 B）
-- 在另一个窗口开始事务，将 order_id 等于 1 的订单优惠金额增加 1。
-- 观察是否等待窗口 A 释放锁。
-- ==================================================


-- ==================================================
-- 第6题（窗口 A）
-- 回滚窗口 A 的事务，释放锁。
-- ==================================================
ROLLBACK;

-- ==================================================
-- 第7题（窗口 B）
-- 在 UPDATE 执行结束后，查询 order_id 等于 1 的订单优惠金额，再回滚窗口 B 的事务。
-- 显示字段：order_id, discount_amount
-- ==================================================


-- ==================================================
-- 第8题
-- 使用 EXPLAIN 分析按 order_id 等于 1 查询 orders 表的执行计划。
-- 观察字段：key, rows
-- ==================================================
EXPLAIN 
SELECT 
      *
FROM orders
WHERE order_id = 'O0001';

-- ==================================================
-- 第9题
-- 使用 EXPLAIN 分析按 payment_method 等于“微信支付”查询 orders 表的执行计划。
-- 观察字段：possible_keys, key, rows
-- ==================================================
EXPLAIN 
SELECT 
      *
FROM orders
WHERE payment_method = 'WeChat Pay';

-- ==================================================
-- 第10题
-- 写出一段安全事务 SQL：按 order_id 从小到大依次锁定读取 order_id 等于 1 和 2 的订单，最后回滚。
-- 显示字段：order_id, discount_amount
-- ==================================================
START TRANSACTION;

SELECT
      order_id, 
      discount_amount
FROM orders
WHERE order_id BETWEEN 'O0001' AND   'O0002'
ORDER BY order_id ASC
FOR UPDATE;

ROLLBACK;


-- ==================================================
-- 第11题
-- 写出一段安全事务 SQL：先查询 order_id 等于 1 和 2 的订单，再按 order_id 从小到大将两条订单优惠金额各增加 1，查看后回滚。
-- 显示字段：order_id, discount_amount
-- ==================================================
START TRANSACTION;

SELECT
      order_id, 
      discount_amount
FROM orders
WHERE order_id BETWEEN 'O0001' AND   'O0002';

UPDATE orders
SET discount_amount =discount_amount + 1
WHERE order_id BETWEEN 'O0001' AND   'O0002';
 
SELECT
      order_id,
      discount_amount
FROM orders
WHERE order_id BETWEEN 'O0001' AND   'O0002';

ROLLBACK;

-- ==================================================
-- 第12题
-- 说明两个事务都需要修改 order_id 等于 1 和 2 的订单时，为什么应采用相同的 order_id 升序修改顺序。
-- 将说明写成 SQL 注释。
-- ==================================================
-- 两个事务都需要修改 O0001 和 O0002 时，应统一先修改 O0001，再修改 O0002。
-- 如果事务 A 先锁定 O0001、再等待 O0002，
-- 而事务 B 先锁定 O0002、再等待 O0001，
-- 就会形成循环等待，可能发生死锁。
-- 使用相同的 O0001 -> O0002 升序修改顺序后，
-- 后来的事务会先等待同一条记录的锁，而不会形成循环等待。
