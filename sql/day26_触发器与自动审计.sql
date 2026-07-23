-- ==================================================
-- 第1题
-- 查看当前数据库中已有的触发器。
-- 观察字段：Trigger, Event, Table, Statement, Timing
-- ==================================================
SHOW TRIGGERS;

-- ==================================================
-- 第2题
-- 删除表 order_discount_audit。即使该表不存在，也不能报错。
-- 再创建该表，用于记录订单优惠金额变更。
-- 显示字段：audit_id, order_id, old_discount_amount, new_discount_amount, changed_at
-- ==================================================
DROP TABLE IF EXISTS order_discount_audit;

CREATE TABLE order_discount_audit (
    audit_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(255) NOT NULL,
    old_discount_amount DECIMAL(10, 2) NOT NULL,
    new_discount_amount DECIMAL(10, 2) NOT NULL,
    changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ==================================================
-- 第3题
-- 删除触发器 trg_orders_discount_audit。即使该触发器不存在，也不能报错。
-- ==================================================
DROP TRIGGER IF EXISTS trg_orders_discount_audit;

-- ==================================================
-- 第4题
-- 创建触发器 trg_orders_discount_audit。
-- 当 orders 表的 discount_amount 被更新且前后数值不同时，自动向 order_discount_audit 写入一条记录。
-- ==================================================
DELIMITER$$

CREATE TRIGGER trg_orders_discount_audit
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
if 
    OLD.discount_amount <> NEW.discount_amount
THEN 
    INSERT INTO order_discount_audit
		(order_id,
		old_discount_amount,
		new_discount_amount
		)
		VALUES
		(NEW.order_id,
		OLD.discount_amount,
		NEW.discount_amount
		);
		END IF;
		END$$
DELIMITER;
		
		

-- ==================================================
-- 第5题
-- 开始事务，将订单编号 O0001 的优惠金额增加 1。
-- 查询订单编号和优惠金额，再查询该订单最新的审计记录。
-- 最后回滚事务。
-- 显示字段：order_id, discount_amount
-- 审计显示字段：audit_id, order_id, old_discount_amount, new_discount_amount, changed_at
-- ==================================================
START TRANSACTION;

UPDATE  orders
SET discount_amount = discount_amount + 1
WHERE order_id = 'O0001';

SELECT 
      order_id, 
			discount_amount
FROM orders
WHERE order_id = 'O0001';

SELECT
      *
FROM order_discount_audit
WHERE order_id = 'O0001'
ORDER BY audit_id DESC
LIMIT 1;

ROLLBACK;
-- ==================================================
-- 第6题
-- 查询订单编号 O0001 的审计记录，确认第 5 题回滚后的记录状态。
-- 显示字段：audit_id, order_id, old_discount_amount, new_discount_amount, changed_at
-- ==================================================
SELECT
      *
FROM order_discount_audit
WHERE order_id = 'O0001'
ORDER BY audit_id DESC
LIMIT 1;

-- ==================================================
-- 第7题
-- 删除触发器 trg_orders_discount_nonnegative。即使该触发器不存在，也不能报错。
-- ==================================================
DROP TRIGGER  IF EXISTS  trg_orders_discount_nonnegative;

-- ==================================================
-- 第8题
-- 创建触发器 trg_orders_discount_nonnegative。
-- 在更新 orders 表前，若新的 discount_amount 小于 0，则将新值改为 0。
-- ==================================================
DELIMITER$$
CREATE TRIGGER trg_orders_discount_nonnegative
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
IF NEW.discount_amount < 0 
THEN  SET NEW.discount_amount = 0;
END IF;
END$$
DELIMITER;

-- ==================================================
-- 第9题
-- 开始事务，将订单编号 O0001 的优惠金额更新为 -5。
-- 查询订单编号和优惠金额，观察触发器处理后的结果。
-- 最后回滚事务。
-- 显示字段：order_id, discount_amount
-- ==================================================
START TRANSACTION;

UPDATE orders
SET discount_amount = -5
WHERE order_id = 'O0001';

SELECT
      order_id, 
			discount_amount
FROM orders
WHERE order_id = 'O0001';

ROLLBACK;

-- ==================================================
-- 第10题
-- 查看触发器 trg_orders_discount_audit 的完整创建语句。
-- ==================================================
SHOW CREATE TRIGGER trg_orders_discount_audit;

-- ==================================================
-- 第11题
-- 使用 SQL 注释说明为什么 orders 表的 UPDATE 触发器不应再次 UPDATE orders 表。
-- ==================================================
--在update的触发器中再进行update更新，这样会造成混乱，
-- orders 表的 UPDATE 触发器不应再次 UPDATE orders 表。
-- 因为 MySQL 不允许触发器修改触发它的同一张表，
-- 否则会造成递归或循环依赖风险，并可能直接报错。
-- 审计触发器应把记录写入独立的 order_discount_audit 表。

-- ==================================================
-- 第12题
-- 删除触发器 trg_orders_discount_audit 和 trg_orders_discount_nonnegative。
-- 删除表 order_discount_audit。
-- 删除时即使对象不存在，也不能报错。
-- ==================================================
SHOW TRIGGERS;
DROP TRIGGER IF EXISTS trg_orders_discount_audit;
DROP TRIGGER IF EXISTS trg_orders_discount_nonnegative;
DROP TABLE IF EXISTS  order_discount_audit;