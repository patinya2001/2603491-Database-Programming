-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: shabu3peenong
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `total_expense_by_day`
--

DROP TABLE IF EXISTS `total_expense_by_day`;
/*!50001 DROP VIEW IF EXISTS `total_expense_by_day`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_expense_by_day` AS SELECT 
 1 AS `month_year`,
 1 AS `daily_expense_date`,
 1 AS `total_expense`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_income_by_type`
--

DROP TABLE IF EXISTS `total_income_by_type`;
/*!50001 DROP VIEW IF EXISTS `total_income_by_type`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_income_by_type` AS SELECT 
 1 AS `month_year`,
 1 AS `receipt_type`,
 1 AS `total_income`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_expense_by_type`
--

DROP TABLE IF EXISTS `total_expense_by_type`;
/*!50001 DROP VIEW IF EXISTS `total_expense_by_type`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_expense_by_type` AS SELECT 
 1 AS `month_year`,
 1 AS `expense_name`,
 1 AS `total_expense`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_emp_late_absent`
--

DROP TABLE IF EXISTS `total_emp_late_absent`;
/*!50001 DROP VIEW IF EXISTS `total_emp_late_absent`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_emp_late_absent` AS SELECT 
 1 AS `month_year`,
 1 AS `count_late`,
 1 AS `count_absent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_income_by_branch`
--

DROP TABLE IF EXISTS `total_income_by_branch`;
/*!50001 DROP VIEW IF EXISTS `total_income_by_branch`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_income_by_branch` AS SELECT 
 1 AS `month_year`,
 1 AS `branch_name`,
 1 AS `total_income`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_expense_and_count_by_month`
--

DROP TABLE IF EXISTS `total_expense_and_count_by_month`;
/*!50001 DROP VIEW IF EXISTS `total_expense_and_count_by_month`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_expense_and_count_by_month` AS SELECT 
 1 AS `month_year`,
 1 AS `total_expense`,
 1 AS `count`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_expense_by_branch`
--

DROP TABLE IF EXISTS `total_expense_by_branch`;
/*!50001 DROP VIEW IF EXISTS `total_expense_by_branch`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_expense_by_branch` AS SELECT 
 1 AS `month_year`,
 1 AS `branch_name`,
 1 AS `total_expense`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_emp_late_absent_by_day`
--

DROP TABLE IF EXISTS `total_emp_late_absent_by_day`;
/*!50001 DROP VIEW IF EXISTS `total_emp_late_absent_by_day`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_emp_late_absent_by_day` AS SELECT 
 1 AS `month_year`,
 1 AS `by_date`,
 1 AS `count_late`,
 1 AS `count_absent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `summary_view`
--

DROP TABLE IF EXISTS `summary_view`;
/*!50001 DROP VIEW IF EXISTS `summary_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `summary_view` AS SELECT 
 1 AS `month_year`,
 1 AS `total_expense`,
 1 AS `avg_expense`,
 1 AS `total_income`,
 1 AS `avg_income`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_emp_late_absent_by_branch`
--

DROP TABLE IF EXISTS `total_emp_late_absent_by_branch`;
/*!50001 DROP VIEW IF EXISTS `total_emp_late_absent_by_branch`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_emp_late_absent_by_branch` AS SELECT 
 1 AS `month_year`,
 1 AS `branch_name`,
 1 AS `count_late`,
 1 AS `count_absent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_income_before_after_discount`
--

DROP TABLE IF EXISTS `total_income_before_after_discount`;
/*!50001 DROP VIEW IF EXISTS `total_income_before_after_discount`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_income_before_after_discount` AS SELECT 
 1 AS `month_year`,
 1 AS `total_income`,
 1 AS `total_net_income`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_income_by_day`
--

DROP TABLE IF EXISTS `total_income_by_day`;
/*!50001 DROP VIEW IF EXISTS `total_income_by_day`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `total_income_by_day` AS SELECT 
 1 AS `month_year`,
 1 AS `receipt_date`,
 1 AS `total_income`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `top_ten_sales`
--

DROP TABLE IF EXISTS `top_ten_sales`;
/*!50001 DROP VIEW IF EXISTS `top_ten_sales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `top_ten_sales` AS SELECT 
 1 AS `month_year`,
 1 AS `product_name`,
 1 AS `total_sales`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `home_daily`
--

DROP TABLE IF EXISTS `home_daily`;
/*!50001 DROP VIEW IF EXISTS `home_daily`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `home_daily` AS SELECT 
 1 AS `วันที่`,
 1 AS `รายได้สุทธิรวม`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `total_expense_by_day`
--

/*!50001 DROP VIEW IF EXISTS `total_expense_by_day`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_expense_by_day` AS select date_format(`daily_expense`.`daily_expense_date`,'%Y-%m') AS `month_year`,`daily_expense`.`daily_expense_date` AS `daily_expense_date`,sum(`daily_expense`.`daily_expense_price`) AS `total_expense` from `daily_expense` group by `month_year`,`daily_expense`.`daily_expense_date` order by `daily_expense`.`daily_expense_date` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_income_by_type`
--

/*!50001 DROP VIEW IF EXISTS `total_income_by_type`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_income_by_type` AS select date_format(`receipt`.`receipt_date`,'%Y-%m') AS `month_year`,`receipt`.`receipt_type` AS `receipt_type`,sum(`receipt`.`receipt_net`) AS `total_income` from `receipt` group by date_format(`receipt`.`receipt_date`,'%Y-%m'),`receipt`.`receipt_type` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_expense_by_type`
--

/*!50001 DROP VIEW IF EXISTS `total_expense_by_type`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_expense_by_type` AS select `subquery`.`month_year` AS `month_year`,`subquery`.`expense_name` AS `expense_name`,(sum(`subquery`.`total_advanced_pay`) + sum(`subquery`.`total_daily_expense_price`)) AS `total_expense` from (select date_format(`activity`.`activity_date`,'%Y-%m') AS `month_year`,'เงินเดือน' AS `expense_name`,sum(`activity`.`advanced_pay`) AS `total_advanced_pay`,0 AS `total_daily_expense_price` from `activity` group by `month_year` union select date_format(`de`.`daily_expense_date`,'%Y-%m') AS `month_year`,`et`.`expense_name` AS `expense_name`,0 AS `total_advanced_pay`,sum(`de`.`daily_expense_price`) AS `total_daily_expense_price` from (`daily_expense` `de` join `expense_type` `et` on((`et`.`expense_id` = `de`.`expense_id`))) group by `month_year`,`et`.`expense_name`) `subquery` group by `subquery`.`month_year`,`subquery`.`expense_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_emp_late_absent`
--

/*!50001 DROP VIEW IF EXISTS `total_emp_late_absent`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_emp_late_absent` AS select date_format(`activity`.`activity_date`,'%Y-%m') AS `month_year`,sum(`activity`.`activity_late`) AS `count_late`,sum(`activity`.`activity_absent`) AS `count_absent` from `activity` group by `month_year` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_income_by_branch`
--

/*!50001 DROP VIEW IF EXISTS `total_income_by_branch`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_income_by_branch` AS select date_format(`r`.`receipt_date`,'%Y-%m') AS `month_year`,`b`.`branch_name` AS `branch_name`,sum(`r`.`receipt_net`) AS `total_income` from (`receipt` `r` join `branch` `b` on((`r`.`branch_id` = `b`.`branch_id`))) group by date_format(`r`.`receipt_date`,'%Y-%m'),`b`.`branch_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_expense_and_count_by_month`
--

/*!50001 DROP VIEW IF EXISTS `total_expense_and_count_by_month`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_expense_and_count_by_month` AS select date_format(`daily_expense`.`daily_expense_date`,'%Y-%m') AS `month_year`,sum(`daily_expense`.`daily_expense_price`) AS `total_expense`,count(`daily_expense`.`record_id`) AS `count` from `daily_expense` group by `month_year` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_expense_by_branch`
--

/*!50001 DROP VIEW IF EXISTS `total_expense_by_branch`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_expense_by_branch` AS select `subquery`.`month_year` AS `month_year`,`b`.`branch_name` AS `branch_name`,(sum(`subquery`.`total_advanced_pay`) + sum(`subquery`.`total_daily_expense_price`)) AS `total_expense` from ((select date_format(`activity`.`activity_date`,'%Y-%m') AS `month_year`,`activity`.`branch_id` AS `branch`,sum(`activity`.`advanced_pay`) AS `total_advanced_pay`,0 AS `total_daily_expense_price` from `activity` group by date_format(`activity`.`activity_date`,'%Y-%m'),`activity`.`branch_id` union select date_format(`daily_expense`.`daily_expense_date`,'%Y-%m') AS `month_year`,`daily_expense`.`branch_id` AS `branch`,0 AS `total_advanced_pay`,sum(`daily_expense`.`daily_expense_price`) AS `total_daily_expense_price` from `daily_expense` group by date_format(`daily_expense`.`daily_expense_date`,'%Y-%m'),`daily_expense`.`branch_id`) `subquery` join `branch` `b` on((`b`.`branch_id` = `subquery`.`branch`))) group by `subquery`.`month_year`,`subquery`.`branch` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_emp_late_absent_by_day`
--

/*!50001 DROP VIEW IF EXISTS `total_emp_late_absent_by_day`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_emp_late_absent_by_day` AS select date_format(`activity`.`activity_date`,'%Y-%m') AS `month_year`,cast(`activity`.`activity_date` as date) AS `by_date`,sum(`activity`.`activity_late`) AS `count_late`,sum(`activity`.`activity_absent`) AS `count_absent` from `activity` group by `month_year`,`by_date` order by `by_date` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `summary_view`
--

/*!50001 DROP VIEW IF EXISTS `summary_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `summary_view` AS select `subquery`.`month_year` AS `month_year`,sum(`subquery`.`total_expense`) AS `total_expense`,sum(`subquery`.`avg_expense`) AS `avg_expense`,sum(`subquery`.`total_income`) AS `total_income`,sum(`subquery`.`avg_income`) AS `avg_income` from (select date_format(`daily_expense`.`daily_expense_date`,'%Y-%m') AS `month_year`,sum(`daily_expense`.`daily_expense_price`) AS `total_expense`,avg(`daily_expense`.`daily_expense_price`) AS `avg_expense`,0 AS `total_income`,0 AS `avg_income` from `daily_expense` group by `month_year` union select date_format(`receipt`.`receipt_date`,'%Y-%m') AS `month_year`,0 AS `total_expense`,0 AS `avg_expense`,sum(`receipt`.`receipt_net`) AS `total_income`,avg(`receipt`.`receipt_net`) AS `avg_income` from `receipt` group by `month_year` union select date_format(`daily_expense`.`daily_expense_date`,'%Y-%m') AS `month_year`,sum(`daily_expense`.`daily_expense_price`) AS `total_expense`,avg(`daily_expense`.`daily_expense_price`) AS `avg_expense`,0 AS `total_income`,0 AS `avg_income` from `daily_expense` group by `month_year` union select date_format(`activity`.`activity_date`,'%Y-%m') AS `month_year`,(((350 * sum((0 = `activity`.`activity_absent`))) - (50 * sum(`activity`.`activity_late`))) - sum(`activity`.`advanced_pay`)) AS `total_expense`,(((350 * avg((0 = `activity`.`activity_absent`))) - (50 * avg(`activity`.`activity_late`))) - avg(`activity`.`advanced_pay`)) AS `avg_expense`,0 AS `total_income`,0 AS `avg_income` from `activity` group by `month_year`) `subquery` group by `subquery`.`month_year` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_emp_late_absent_by_branch`
--

/*!50001 DROP VIEW IF EXISTS `total_emp_late_absent_by_branch`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_emp_late_absent_by_branch` AS select date_format(`a`.`activity_date`,'%Y-%m') AS `month_year`,`b`.`branch_name` AS `branch_name`,sum(`a`.`activity_late`) AS `count_late`,sum(`a`.`activity_absent`) AS `count_absent` from (`activity` `a` join `branch` `b` on((`a`.`branch_id` = `b`.`branch_id`))) group by `month_year`,`b`.`branch_name` order by `month_year`,sum(`a`.`activity_late`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_income_before_after_discount`
--

/*!50001 DROP VIEW IF EXISTS `total_income_before_after_discount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_income_before_after_discount` AS select date_format(`receipt`.`receipt_date`,'%Y-%m') AS `month_year`,sum(`receipt`.`receipt_total`) AS `total_income`,sum(`receipt`.`receipt_net`) AS `total_net_income` from `receipt` group by `month_year` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_income_by_day`
--

/*!50001 DROP VIEW IF EXISTS `total_income_by_day`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `total_income_by_day` AS select date_format(`receipt`.`receipt_date`,'%Y-%m') AS `month_year`,`receipt`.`receipt_date` AS `receipt_date`,sum(`receipt`.`receipt_net`) AS `total_income` from `receipt` group by `month_year`,`receipt`.`receipt_date` order by `receipt`.`receipt_date` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `top_ten_sales`
--

/*!50001 DROP VIEW IF EXISTS `top_ten_sales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `top_ten_sales` AS select concat((`its`.`item_sales_year` - 543),'-',convert(lpad(`its`.`item_sales_month`,2,'0') using utf8mb4)) AS `month_year`,`pl`.`product_name` AS `product_name`,sum(`its`.`item_sales_quantity`) AS `total_sales` from (`item_sales` `its` join `product_list` `pl` on((`pl`.`SKU` = `its`.`SKU`))) group by `month_year`,`pl`.`product_name` order by `total_sales` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `home_daily`
--

/*!50001 DROP VIEW IF EXISTS `home_daily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `home_daily` AS select cast(`receipt`.`receipt_date` as date) AS `วันที่`,sum(`receipt`.`receipt_total`) AS `รายได้สุทธิรวม` from `receipt` group by cast(`receipt`.`receipt_date` as date) order by cast(`receipt`.`receipt_date` as date) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-18 22:57:21
