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
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `activity_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `activity_date` datetime NOT NULL,
  `activity_absent` tinyint(1) DEFAULT '0',
  `activity_late` tinyint(1) DEFAULT '0',
  `advanced_pay` float DEFAULT '0',
  PRIMARY KEY (`activity_id`),
  KEY `FK_branch_activity_idx` (`branch_id`),
  KEY `FK_employee_activity` (`employee_id`),
  CONSTRAINT `FK_branch_activity` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `FK_employee_activity` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES (4,1,2,'2023-12-14 19:04:00',0,0,0),(5,2,4,'2023-12-14 19:15:00',0,0,0),(6,1,1,'2023-12-15 04:34:00',0,0,0),(7,1,2,'2023-12-15 04:34:00',1,0,0),(8,2,3,'2023-12-15 04:34:00',0,1,0),(9,2,4,'2023-12-15 04:34:00',0,0,0),(10,3,5,'2023-12-15 04:35:00',0,0,0),(11,3,6,'2023-12-15 04:35:00',0,0,0),(12,1,1,'2023-12-16 05:37:00',0,0,190),(13,1,1,'2023-09-18 21:45:00',1,0,0),(14,1,2,'2023-09-18 21:46:00',0,1,0),(15,2,3,'2023-09-18 21:46:00',0,1,0),(16,2,4,'2023-09-18 21:46:00',0,0,0),(17,3,5,'2023-09-18 21:46:00',1,0,0),(18,3,6,'2023-09-18 21:46:00',0,0,0),(19,1,1,'2023-09-19 21:50:00',1,0,0),(20,2,3,'2023-09-19 21:50:00',0,1,0),(21,1,1,'2023-12-18 22:19:00',0,0,0);
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-18 22:57:19
