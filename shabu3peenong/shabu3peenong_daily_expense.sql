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
-- Table structure for table `daily_expense`
--

DROP TABLE IF EXISTS `daily_expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_expense` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `expense_id` int NOT NULL,
  `branch_id` int NOT NULL,
  `daily_expense_date` datetime NOT NULL,
  `daily_expense_price` float NOT NULL,
  `daily_expense_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `FK_expense_id_idx` (`expense_id`),
  KEY `FK_branch_id_idx` (`branch_id`),
  CONSTRAINT `FK_branch_daily_expense` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `FK_expense_daily_expense` FOREIGN KEY (`expense_id`) REFERENCES `expense_type` (`expense_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_expense`
--

LOCK TABLES `daily_expense` WRITE;
/*!40000 ALTER TABLE `daily_expense` DISABLE KEYS */;
INSERT INTO `daily_expense` VALUES (1,1,1,'2023-12-11 05:39:00',1111,NULL),(2,3,2,'2023-12-14 17:53:00',324,NULL),(3,1,3,'2023-12-15 04:31:00',324,NULL),(4,13,1,'2023-12-16 04:32:00',678,NULL),(5,14,2,'2023-12-17 04:32:00',765,NULL),(6,5,3,'2023-12-18 04:32:00',335,NULL);
/*!40000 ALTER TABLE `daily_expense` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-15  4:36:53
