USE shabu3peenong;

CREATE OR REPLACE VIEW home_daily AS
SELECT 
CAST(receipt_date as date) AS `วันที่`,
SUM(receipt_total) AS `รายได้สุทธิรวม` 
FROM receipt 
GROUP BY CAST(receipt_date as date)
ORDER BY CAST(receipt_date as date);


DELIMITER //
CREATE PROCEDURE InsertProduct
(IN SKU INT, IN sales_id INT, IN sales VARCHAR(50), IN product_name VARCHAR(50), IN product_price FLOAT, 
IN product_cost FLOAT, IN product_description VARCHAR(255))
BEGIN
    DECLARE sales_name_id INT;

    IF product_description = '' OR product_description = ' ' THEN
        SET product_description = NULL;
    END IF;

    IF sales IS NOT NULL THEN
        SELECT sales_id INTO sales_name_id FROM sales_type WHERE sales_name = sales;
    END IF;

    INSERT INTO product_list (SKU, sales_id, product_name, product_price, product_cost, product_description) 
    VALUES (SKU, COALESCE(sales_name_id, sales_id), product_name, product_price, product_cost, product_description);
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER before_insert_product_list
BEFORE INSERT ON product_list
FOR EACH ROW
BEGIN
    DECLARE exists_SKU INT;

    SELECT COUNT(SKU) INTO exists_SKU
    FROM product_list
    WHERE SKU = NEW.SKU;

    IF exists_SKU > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'รหัส SKU หรือสินค้ามีอยู่ในระบบแล้ว';
    ELSE
        IF NEW.SKU < 0 OR NEW.product_price < 0 OR NEW.product_cost < 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'รหัส SKU ราคาสินค้า และต้นทุนสินค้าต้องมีค่ามากกว่าหรือเท่ากับ 0';
        END IF;
    END IF;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE InsertExpense
(IN expense_id INT, IN branch_id INT, IN daily_expense_date DATETIME, IN daily_expense_price FLOAT, IN daily_expense_description VARCHAR(255))
BEGIN
    IF daily_expense_description = '' OR daily_expense_description = ' ' THEN
        SET daily_expense_description = NULL;
    END IF;

    INSERT INTO daily_expense (expense_id, branch_id, daily_expense_date, daily_expense_price, daily_expense_description) 
    VALUES (expense_id, branch_id, daily_expense_date, daily_expense_price, daily_expense_description);
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER before_insert_daily_expense
BEFORE INSERT ON daily_expense
FOR EACH ROW
BEGIN
    IF NEW.daily_expense_price <= 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ค่าใช้จ่ายต้องมีค่ามากกว่า 0';
    END IF;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE InsertActivity
(IN is_superuser BOOLEAN, IN branch INT, IN employee INT, IN activity_date DATETIME, IN activity_absent TINYINT(1), IN activity_late TINYINT(1))
BEGIN
    DECLARE employee_branch_id INT;
    
    IF is_superuser = TRUE THEN
        SELECT branch_id INTO employee_branch_id FROM employee WHERE employee_id = employee;
        SET branch = NULL;
    END IF;

    INSERT INTO activity (branch_id, employee_id, activity_date, activity_absent, activity_late)
    VALUES (COALESCE(employee_branch_id, branch), employee, activity_date, activity_absent, activity_late);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateAdvancedPay (IN employee INT, IN pay_date DATETIME, IN amount FLOAT)
BEGIN
    IF amount > 0 THEN
		UPDATE activity
		SET advanced_pay = advanced_pay + amount
		WHERE activity.employee_id = employee AND DATE_FORMAT(activity_date, '%Y-%m-%d') = DATE_FORMAT(pay_date, '%Y-%m-%d');
    ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'จำนวนเงินเบิกล่วงหน้าต้องมีค่ามากกว่า 0';
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE InsertReceipt
(IN receipt_id VARCHAR(10), IN branch VARCHAR(50), IN receipt_date DATETIME, IN receipt_type VARCHAR(20), IN receipt_order VARCHAR(20),
 IN receipt_system VARCHAR(50), IN receipt_cashier VARCHAR(50), IN receipt_total FLOAT, IN receipt_discount FLOAT, IN receipt_net FLOAT,
 IN receipt_customer_name VARCHAR(50), IN receipt_customer_contact VARCHAR(50), IN receipt_comment VARCHAR(255), IN receipt_status VARCHAR(20))
BEGIN
    DECLARE d_branch_id INT;

    SET d_branch_id = CASE
        WHEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(branch, '|', -1), '|', 1)) = 'สาขาพหลโยธิน 52' THEN 1
        WHEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(branch, '|', -1), '|', 1)) = 'สาขาม.รังสิต' THEN 2
        WHEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(branch, '|', -1), '|', 1)) = 'สาขารังสิต 200 ปี' THEN 3
        ELSE NULL
    END;
    
    INSERT INTO receipt (receipt_id, branch_id, receipt_date, receipt_type, receipt_order, 
    receipt_system, receipt_cashier, receipt_total, receipt_discount, receipt_net, 
    receipt_customer_name, receipt_customer_contact, receipt_comment, receipt_status)
    VALUE (receipt_id, d_branch_id, receipt_date, receipt_type, receipt_order, receipt_system, receipt_cashier,
            receipt_total, receipt_discount, receipt_net, receipt_customer_name, receipt_customer_contact,
            receipt_comment, receipt_status);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE InsertReceiptByProduct (IN SKU INT, IN receipt_id VARCHAR(10), IN rbp_quantity INT, IN rbp_discount_by_item FLOAT)
BEGIN
	INSERT INTO receipt_by_product (SKU, receipt_id, rbp_quantity, rbp_discount_by_item)
    VALUE (SKU, receipt_id, rbp_quantity, rbp_discount_by_item);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE InsertItemSales
(IN SKU INT, IN item_sales_month INT, IN item_sales_year INT, IN item_sales_quantity INT, IN item_sales_refund INT, IN item_sales_refund_price FLOAT)
BEGIN
    INSERT INTO item_sales (SKU, item_sales_month, item_sales_year, item_sales_quantity, item_sales_refund, item_sales_refund_price)
    VALUES (SKU, item_sales_month, item_sales_year, item_sales_quantity, item_sales_refund, item_sales_refund_price);
END //
DELIMITER ;


-- ------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER //
CREATE FUNCTION payroll(monthyear VARCHAR(9))
RETURNS FLOAT
READS SQL DATA
BEGIN
  DECLARE payroll_value FLOAT;

  SELECT 
    350 * SUM(NOT activity_absent) - 50 * SUM(activity_late) - SUM(advanced_pay)
  INTO payroll_value
  FROM activity
  WHERE DATE_FORMAT(activity_date, '%Y-%m') = monthyear
  GROUP BY DATE_FORMAT(activity_date, '%Y-%m');

  IF payroll_value IS NULL THEN
    SET payroll_value = 0;
  END IF;

  RETURN payroll_value;
END //
DELIMITER ;


CREATE OR REPLACE VIEW summary_view AS
SELECT
    month_year,
    SUM(total_expense) + payroll(month_year) AS total_expense,
    SUM(avg_expense) AS avg_expense,
    SUM(total_income) AS total_income,
    SUM(avg_income) AS avg_income
FROM (
    SELECT
        DATE_FORMAT(daily_expense_date, '%Y-%m') AS month_year,
        SUM(daily_expense_price) AS total_expense,
        AVG(daily_expense_price) AS avg_expense,
        0 AS total_income,
        0 AS avg_income
    FROM
        daily_expense 
    GROUP BY
        month_year

    UNION

    SELECT
        DATE_FORMAT(receipt_date, '%Y-%m') AS month_year,
        0 AS total_expense,
        0 AS avg_expense,
        SUM(receipt_net) AS total_income,
        AVG(receipt_net) AS avg_income
    FROM
        receipt
    GROUP BY
        month_year
) AS subquery
GROUP BY month_year;


CREATE VIEW total_income_by_type AS
SELECT 
	DATE_FORMAT(receipt_date, '%Y-%m') AS month_year,
	receipt_type,
	SUM(receipt_net) AS total_income
FROM receipt
GROUP BY month_year, receipt_type;


CREATE VIEW total_income_by_branch AS
SELECT 
	DATE_FORMAT(receipt_date, '%Y-%m') AS month_year,
	b.branch_name,
	SUM(r.receipt_net) AS total_income
FROM receipt r
INNER JOIN branch b ON r.branch_id = b.branch_id
GROUP BY month_year,  b.branch_name;


CREATE OR REPLACE VIEW total_expense_by_type AS
SELECT 
	month_year,
	expense_name,
    SUM(total_advanced_pay) + SUM(total_daily_expense_price) AS total_expense
FROM (
	SELECT
			DATE_FORMAT(activity_date, '%Y-%m') AS month_year,
			'เงินเดือนเบิกล่วงหน้า' AS expense_name,
			SUM(advanced_pay) AS total_advanced_pay,
			0 AS total_daily_expense_price
		FROM activity
		GROUP BY month_year, branch_id

	UNION

	SELECT
		DATE_FORMAT(de.daily_expense_date, '%Y-%m') AS month_year,
		et.expense_name AS expense_name,
		0 AS total_advanced_pay,
		SUM(de.daily_expense_price) AS total_daily_expense_price
	FROM daily_expense de
	INNER JOIN expense_type et ON et.expense_id = de.expense_id
	GROUP BY month_year, et.expense_name
) AS subquery
GROUP BY month_year, expense_name;


CREATE OR REPLACE VIEW total_expense_by_branch AS
SELECT 
month_year,
	b.branch_name,
    SUM(total_advanced_pay) + SUM(total_daily_expense_price) AS total_expense
FROM (
	SELECT
		DATE_FORMAT(activity_date, '%Y-%m') AS month_year,
		branch_id AS branch,
		SUM(advanced_pay) AS total_advanced_pay,
		0 AS total_daily_expense_price
	FROM activity
	GROUP BY month_year, branch_id

	UNION

	SELECT
		DATE_FORMAT(daily_expense_date, '%Y-%m') AS month_year,
		branch_id AS branch,
		0 AS total_advanced_pay,
		SUM(daily_expense_price) AS total_daily_expense_price
	FROM daily_expense
	GROUP BY month_year, branch_id
) AS subquery
INNER JOIN branch b ON branch_id = branch
GROUP BY month_year, branch;


CREATE OR REPLACE VIEW top_ten_sales AS
SELECT 
	CONCAT(its.item_sales_year-543, '-', LPAD(its.item_sales_month, 2, '0')) AS month_year,
    pl.product_name,
    SUM(its.item_sales_quantity) AS total_sales
FROM item_sales its
INNER JOIN product_list pl ON pl.SKU = its.SKU
GROUP BY month_year, pl.product_name
ORDER BY total_sales DESC
LIMIT 10;


CREATE OR REPLACE VIEW total_income_before_after_discount AS
SELECT 
	DATE_FORMAT(receipt_date,  '%Y-%m') AS month_year,
	SUM(receipt_total) AS total_income,
	SUM(receipt_net) AS total_net_income
FROM receipt
GROUP BY month_year;


CREATE OR REPLACE VIEW total_income_by_day AS
SELECT
	DATE_FORMAT(receipt_date, '%Y-%m') AS month_year,
	receipt_date,
	SUM(receipt_net) AS total_income
FROM receipt
GROUP BY month_year, receipt_date
ORDER BY receipt_date;


CREATE OR REPLACE VIEW total_expense_and_count_by_month AS    
SELECT 
	DATE_FORMAT(daily_expense_date, '%Y-%m') AS month_year,
	SUM(daily_expense_price) AS total_expense,
	COUNT(record_id) AS count
FROM daily_expense
GROUP BY month_year;


CREATE OR REPLACE VIEW total_expense_by_day AS
SELECT
	DATE_FORMAT(daily_expense_date, '%Y-%m') AS month_year,
	daily_expense_date,
	SUM(daily_expense_price) AS total_expense
FROM daily_expense
GROUP BY month_year, daily_expense_date
ORDER BY daily_expense_date;


CREATE VIEW total_emp_late_absent AS
SELECT
	DATE_FORMAT(activity_date, '%Y-%m') AS month_year,
	SUM(activity_late) AS count_late,
    SUM(activity_absent) AS count_absent
FROM activity
GROUP BY month_year;


CREATE VIEW total_emp_late_absent_by_branch AS
SELECT
	DATE_FORMAT(activity_date, '%Y-%m') AS month_year,
	b.branch_name,
	SUM(a.activity_late) AS count_late,
    SUM(a.activity_absent) AS count_absent
FROM activity a	
INNER JOIN branch b ON a.branch_id = b.branch_id
GROUP BY month_year, b.branch_name
ORDER BY month_year, SUM(a.activity_late) DESC;


CREATE VIEW total_emp_late_absent_by_day AS
SELECT
	DATE_FORMAT(activity_date, '%Y-%m') AS month_year,
	DATE(activity_date) AS by_date,
	SUM(activity_late) AS count_late,
    SUM(activity_absent) AS count_absent
FROM activity
GROUP BY month_year, by_date
ORDER BY by_date;
